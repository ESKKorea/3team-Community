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

public class GalleryCommentDAO {
    private DataSource dataSource;
    private Connection conn = null;
    private PreparedStatement pstmt = null;
    private ResultSet rs = null;

    private static GalleryCommentDAO instance;

    private GalleryCommentDAO() {
        try {
            Context ctx = new InitialContext();
            dataSource = (DataSource) ctx.lookup("java:comp/env/jdbc/oracle");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static GalleryCommentDAO getInstance() {
        if (instance == null) {
            instance = new GalleryCommentDAO();
        }
        return instance;
    }

    public int insertGalleryComment(CommentVO comment) {
        int row = 0;
        String SQL = "INSERT INTO GALLERY_COMMENTS (ID, GALLERY_ID, MEMBER_ID, CONTENT) VALUES (SEQ_GALLERY_COMMENTS.NEXTVAL, ?, ?, ?)";
        try {
            conn = dataSource.getConnection();
            pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, comment.getGalleryId());
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

    public List<CommentVO> getCommentsByGalleryId(int galleryId) {
        List<CommentVO> comments = new ArrayList<>();
        String SQL = "SELECT * FROM GALLERY_COMMENTS WHERE GALLERY_ID = ? ORDER BY REG_DATE DESC";
        try {
            conn = dataSource.getConnection();
            pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, galleryId);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                CommentVO comment = new CommentVO();
                comment.setId(rs.getInt("ID"));
                comment.setGalleryId(rs.getInt("GALLERY_ID"));
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

    public int updateComment(CommentVO comment) {
        int row = 0;
        String SQL = "UPDATE GALLERY_COMMENTS SET CONTENT = ? WHERE ID = ?";
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

    public int deleteComment(int id) {
        int row = 0;
        String SQL = "DELETE FROM GALLERY_COMMENTS WHERE ID = ?";
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

    private void closeResource() {
        try {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
