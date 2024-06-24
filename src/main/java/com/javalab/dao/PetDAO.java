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

import com.javalab.vo.BoardVO;
import com.javalab.vo.PetVO;

/**
 * 유기견/유기묘 정보 관련 DAO
 * - 유기견/유기묘 등록
 * - 유기견/유기묘 목록/상세조회
 * - 유기견/유기묘 수정/삭제
 */
public class PetDAO {
    private DataSource dataSource;
    private Connection conn = null; // 커넥션 객체
    private PreparedStatement pstmt = null; // 쿼리문 생성 및 실행 객체
    private ResultSet rs = null; // 쿼리 실행 결과 반환 객체

    // PetDAO를 싱글톤 패턴으로 단 하나의 객체만 생성하기 위한 변수 선언
    private static PetDAO instance;

    /**
     * private 생성자
     * - 외부에서 절대 호출할 수 없으며, 객체 생성 불가
     */
    private PetDAO() {
        try {
            Context ctx = new InitialContext();
            dataSource = (DataSource) ctx.lookup("java:comp/env/jdbc/oracle");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * PetDAO 자신의 인스턴스(객체)를 반환하는 메서드
     * - 이 메서드는 최초 호출 시 객체가 아직 생성되지 않았으므로 단 한 번 객체로 생성된다.
     * - 그 다음부터는 이미 생성된 객체의 참조 주소값을 반환한다.
     * - static 객체 생성 없이 외부에서 호출할 수 있도록 하기 위해
     */
    public static PetDAO getInstance() {
        if (instance == null) {
            instance = new PetDAO();
        }
        return instance;
    }

    /**
     * 유기견/유기묘 등록 처리 메서드
     */
    public int insertPet(PetVO petVO) {
        int row = 0;

        try {
            conn = dataSource.getConnection();
            String sql = "INSERT INTO pet (bno, name, age, description, member_id, reg_date) " +
                         "VALUES (seq_pet.nextval, ?, ?, ?, ?, SYSDATE)";

            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, petVO.getName());           // 이름
            pstmt.setInt(2, petVO.getAge());               // 나이
            pstmt.setString(3, petVO.getDescription());   // 설명
            pstmt.setString(4, petVO.getMemberId());      // 작성자 ID

            row = pstmt.executeUpdate();  // 저장 처리
            System.out.println("row " + row);
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("유기견/유기묘 등록 중 오류가 발생했습니다.");
        } finally {
            closeResource();
        }
        return row;
    }

    /**
     * 유기견/유기묘 목록 조회 메서드
     */
    public List<PetVO> getPetList(int currentPage, int pageSize) {
        List<PetVO> petList = new ArrayList<>();
        try {
            conn = dataSource.getConnection();
            String sql = "SELECT * FROM ( " +
                         "SELECT ROWNUM AS rnum, bno, name, age,  description, reg_date, member_id " +
                         "FROM (SELECT bno, name, age, description, reg_date, member_id FROM pet ORDER BY reg_date DESC) " +
                         "WHERE ROWNUM <= ? ) " +
                         "WHERE rnum >= ?";
            pstmt = conn.prepareStatement(sql);
            int endRow = currentPage * pageSize;
            int startRow = endRow - pageSize + 1;
            pstmt.setInt(1, endRow);
            pstmt.setInt(2, startRow);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                PetVO petVO = new PetVO();
                petVO.setBno(rs.getInt("bno"));
                petVO.setName(rs.getString("name"));
                petVO.setAge(rs.getInt("age"));
                petVO.setDescription(rs.getString("description"));
                petVO.setMemberId(rs.getString("member_id"));
                petVO.setRegDate(rs.getDate("reg_date"));
                petList.add(petVO);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResource();
        }
        return petList;
    }

    /**
     * 유기견/유기묘 상세 조회 메서드
     */
    public PetVO getPet(int bno) {
        PetVO petVO = null;

        try {
            conn = dataSource.getConnection();

            String sql = "SELECT bno, name, age, description, member_id, reg_date FROM pet WHERE bno=?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, bno);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                petVO = new PetVO();
                petVO.setBno(rs.getInt("bno"));
                petVO.setName(rs.getString("name"));
                petVO.setAge(rs.getInt("age"));
                petVO.setDescription(rs.getString("description"));
                petVO.setMemberId(rs.getString("member_id"));
                petVO.setRegDate(rs.getDate("reg_date"));
            }
        } catch (SQLException e) {
            System.out.println("유기견/유기묘 상세 조회 중 오류가 발생했습니다.");
            e.printStackTrace();
        } finally {
            closeResource();
        }
        return petVO;
    }

    /**
     * 유기견/유기묘 정보 수정 메서드
     */
    public int updatePet(PetVO petVO) {
        int row = 0;
        try {
            conn = dataSource.getConnection();

            String sql = "UPDATE pet SET name=?, age=?, description=?, member_id=? WHERE bno=?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, petVO.getName());           // 이름
            pstmt.setInt(2, petVO.getAge());               // 나이
            pstmt.setString(3, petVO.getDescription());   // 설명
            pstmt.setString(4, petVO.getMemberId());      // 작성자 ID

            row = pstmt.executeUpdate();  // 수정 처리

        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("유기견/유기묘 정보 수정 중 오류가 발생했습니다.");
        } finally {
            closeResource();
        }
        return row;
    }

    /**
     * 유기견/유기묘 삭제 메서드
     */
    public int deletePet(int bno) {
        int row = 0;
        try {
            conn = dataSource.getConnection();

            String sql = "DELETE FROM pet WHERE bno=?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, bno);

            row = pstmt.executeUpdate();  // 삭제 처리

        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("유기견/유기묘 삭제 중 오류가 발생했습니다.");
        } finally {
            closeResource();
        }
        return row;
    }

    /**
     * 데이터베이스 관련 자원 해제(반납) 메서드
     */
    private void closeResource() {
        try {
            if (rs != null)
                rs.close();
            if (pstmt != null)
                pstmt.close();
            if (conn != null)
                conn.close();  // 커넥션 반납
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public List<PetVO> searchPetList(String keyword) {
    	List<PetVO> petList = new ArrayList<>();
		try {
			conn = dataSource.getConnection();
			
			String sql = "select bno, title, content, member_id, reg_date, hit_no from pet " +
						" where title like ? or content like ? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "%" + keyword + "%");
			pstmt.setString(2, "%" + keyword + "%");
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				PetVO petVO = new PetVO();
				petVO.setBno(rs.getInt("bno"));
                petVO.setName(rs.getString("name"));
                petVO.setAge(rs.getInt("age"));
                petVO.setDescription(rs.getString("description"));
                petVO.setMemberId(rs.getString("member_id"));
                petVO.setRegDate(rs.getDate("reg_date"));
				petList.add(petVO);			
			}
		}catch (SQLException e) {
			System.out.println("getPetList ERR : " + e.getMessage());
			e.printStackTrace();	// 콘솔에 오류
		}finally {
			closeResource();
		}
		return petList;
	}

    public int getAllCount() {
    	int totalCount = 0;
		StringBuffer sql = new StringBuffer();
		sql.append("select count(*) as totalCount ");
		sql.append(" from pet");
		try {
			conn = dataSource.getConnection();
			pstmt = conn.prepareStatement(sql.toString());
			rs = pstmt.executeQuery();
			if(rs.next()) {
				totalCount = rs.getInt("totalCount");
				System.out.println("PetDAO totlalCount : " + totalCount);
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		return totalCount;
    }
}

