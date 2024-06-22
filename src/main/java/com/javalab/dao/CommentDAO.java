package com.javalab.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import com.javalab.vo.CommentVO;

public class CommentDAO {
    private DataSource dataSource;
    private Connection conn = null; // 커넥션 객체
    private PreparedStatement pstmt = null; // 쿼리문 생성 및 실행 객체
    private ResultSet rs = null; // 쿼리 실행 결과 반환 객체

    // CommentDAO를 싱글톤 패턴으로 단 한개의 객체만 생성하기 위한 변수 선언
    private static CommentDAO instance;

    /**
     * private 생성자
     * - 밖에서는 절대로 호출할 수 없다. 즉, 밖에서는 객체 생성 불가.
     */
    private CommentDAO() {
        try {
            Context ctx = new InitialContext();
            dataSource = (DataSource) ctx.lookup("java:comp/env/jdbc/oracle");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * CommentDAO 자신의 인스턴스(객체)를 반환해주는 메소드
     * - 이 메소드는 최초로 호출 될 때는 아직 객체가 생성되어 있지 않으므로
     * 그 때 단 한 번 객체로 생성된다.
     * - 그 다음 부터는 이미 생성되어 있는 그 객체의 참조 주소값을 반환한다.
     * - static 객체 생성 없이도 밖에서 호출할 수 있도록 하기 위해서 
     */
    public static CommentDAO getInstance() {
        if (instance == null) {
            instance = new CommentDAO();
        }
        return instance;
    }

    /**
     * 댓글 등록 처리 메소드
     */
    public int insertComment(CommentVO comment) {
        int row = 0;
        String SQL = "INSERT INTO COMMENTS (BOARD_ID, MEMBER_ID, CONTENT) VALUES (?, ?, ?)";
        try {
            conn = dataSource.getConnection();
            pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, comment.getBoardId());
            pstmt.setString(2, comment.getMemberId());
            pstmt.setString(3, comment.getContent());
            row = pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResource();
        }
        return row;
    }

    /**
     * 특정 게시물의 댓글 목록 조회 메소드
     */
    public List<CommentVO> getCommentsByBoardId(int boardId) {
        List<CommentVO> comments = new ArrayList<>();
        String SQL = "SELECT * FROM COMMENTS WHERE BOARD_ID = ? ORDER BY REG_DATE DESC";
        try {
            conn = dataSource.getConnection();
            pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, boardId);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                CommentVO comment = new CommentVO();
                comment.setId(rs.getInt("ID"));
                comment.setBoardId(rs.getInt("BOARD_ID"));
                comment.setMemberId(rs.getString("MEMBER_ID"));
                comment.setContent(rs.getString("CONTENT"));
                comment.setRegDate(rs.getDate("REG_DATE"));
                comments.add(comment);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResource();
        }
        return comments;
    }

    /**
     * 댓글 수정 메소드
     */
    public int updateComment(CommentVO comment) {
        int row = 0;
        String SQL = "UPDATE COMMENTS SET CONTENT = ? WHERE ID = ?";
        try {
            conn = dataSource.getConnection();
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, comment.getContent());
            pstmt.setInt(2, comment.getId());
            row = pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResource();
        }
        return row;
    }

    /**
     * 댓글 삭제 메소드
     */
    public int deleteComment(int id) {
        int row = 0;
        String SQL = "DELETE FROM COMMENTS WHERE ID = ?";
        try {
            conn = dataSource.getConnection();
            pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, id);
            row = pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResource();
        }
        return row;
    }

    /**
     * 데이터베이스 관련 자원 해제(반납) 메소드
     */
    private void closeResource() {
        try {
            if (rs != null)
                rs.close();
            if (pstmt != null)
                pstmt.close();
            if (conn != null)
                conn.close(); // 커넥션 반납
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
