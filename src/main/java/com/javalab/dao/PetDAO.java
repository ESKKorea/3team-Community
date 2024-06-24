package com.javalab.dao;

import com.javalab.vo.PetVO;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

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


    // Singleton instance for PetDAO
    private static PetDAO instance;

    private PetDAO() {
        try {
            Context ctx = new InitialContext();
            dataSource = (DataSource) ctx.lookup("java:comp/env/jdbc/oracle");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static PetDAO getInstance() {
        if (instance == null) {
            instance = new PetDAO();
        }
        return instance;
    }

    /**
     * 유기견/유기묘 등록 메서드
     */
    public void insertPet(PetVO pet) {
        String sql = "INSERT INTO pet (id, name, age, description) VALUES (?, ?, ?, ?)";
        try (Connection conn = dataSource.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, pet.getId());
            pstmt.setString(2, pet.getName());
            pstmt.setInt(3, pet.getAge());
            pstmt.setString(4, pet.getDescription());
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    /**
     * 유기견/유기묘 목록 조회 메서드
     */
    public List<PetVO> getPetList() {
        List<PetVO> petList = new ArrayList<>();
        String sql = "SELECT id, name, age, description FROM pet";
        try (Connection conn = dataSource.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                PetVO petVO = new PetVO();
                petVO.setId(rs.getInt("id"));
                petVO.setName(rs.getString("name"));
                petVO.setAge(rs.getInt("age"));
                petVO.setDescription(rs.getString("description"));
                petList.add(petVO);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return petList;
    }

    /**
     * 유기견/유기묘 상세 조회 메서드
     */
    public PetVO getPet(int id) {
        PetVO petVO = null;
        String sql = "SELECT id, name, age, description FROM pet WHERE id=?";
        try (Connection conn = dataSource.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, id);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    petVO = new PetVO();
                    petVO.setId(rs.getInt("id"));
                    petVO.setName(rs.getString("name"));
                    petVO.setAge(rs.getInt("age"));
                    petVO.setDescription(rs.getString("description"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return petVO;
    }

    /**
     * 유기견/유기묘 정보 수정 메서드
     */
    public int updatePet(PetVO petVO) {
        int row = 0;
        String sql = "UPDATE pet SET name=?, age=?, description=? WHERE id=?";
        try (Connection conn = dataSource.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, petVO.getName());
            pstmt.setInt(2, petVO.getAge());
            pstmt.setString(3, petVO.getDescription());
            pstmt.setInt(4, petVO.getId());
            row = pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return row;
    }

    /**
     * 유기견/유기묘 삭제 메서드
     */
    public int deletePet(int id) {
        int row = 0;
        String sql = "DELETE FROM pet WHERE id=?";
        try (Connection conn = dataSource.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, id);
            row = pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return row;
    }

    /**
     * 데이터베이스 자원 해제 메서드
     */
	private void closeResource() {
		try {
			if (rs != null)
				rs.close();
			if (pstmt != null)
				pstmt.close();
			if (conn != null)
				conn.close(); // 컨넥션 반납
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public int getAllCount() {
		// TODO Auto-generated method stub
		return 0;
	}

	public List<PetVO> getPetList(int currentPage, int petsPerPage) {
		// TODO Auto-generated method stub
		return null;
	}
}
