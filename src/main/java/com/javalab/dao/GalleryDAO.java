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

import com.javalab.vo.GalleryVO;

/**
 * 게시물 관련 DAO
 * - 게시물 등록
 * - 게시물 목록/상세조회
 * - 게시물 수정/삭제
 */
public class GalleryDAO {
   private DataSource dataSource;
   private Connection conn = null; // 커넥션 객체
   private PreparedStatement pstmt = null; // 쿼리문 생성 및 실행 객체
   private ResultSet rs = null; // 쿼리 실행 결과 반환 객체

   // BoarDAO를 싱글톤 패턴으로 단 한개의 객체만 생성하기 위한 변수 선언
   private static GalleryDAO instance;
   
   /**
    * private 생성자
    * - 밖에서는 절대로 호출할 수 없다. 즉, 밖에서는 객체 생성 불가.
    */
   private GalleryDAO() {
		try {
			Context ctx = new InitialContext();
			dataSource = (DataSource) ctx.lookup("java:comp/env/jdbc/oracle");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
   
   /**
    * BoardDAO 자신의 인스턴스(객체)를 반환해주는 메소드
    * - 이 메소드는 최초로 호출 될 때는 아직 객체가 생성되어 있지 않으므로
    *     그 때 단 한 번 객체로 생성된다.
    * - 그 다음 부터는 이미 생성되어 있는 그 객체의 참조 주소값을 반환한다.
    * - static 객체 생성 없이도 밖에서 호출할 수 있도록 하기 위해서 
    */
   public static GalleryDAO getInstance() {
      if(instance == null) {
         instance = new GalleryDAO();
      }
      return instance;
   }
   
   
   /**
    * 게시물 등록 처리 메소드
    * - 트랜잭션 적용 : 다음 bno를 조회하는 SQL과 insert구문을 실행하는 코드를 하나의 작업 단위로 묶음
    */
// 게시물 등록 처리 메소드
public int insertGallery(GalleryVO galleryVO) {
    int row = 0;
    
    try {
        conn = dataSource.getConnection();
        conn.setAutoCommit(false); // 트랜잭션 시작(오토 커밋 중지)
        
        // 게시물 등록 SQL
        String sql = "INSERT INTO gallery (bno, title, description, file_name, file_path, member_id, reply_group, reply_order, reply_indent) ";
        sql += "VALUES (seq_gallery.nextval, ?, ?, ?, ?, ?, seq_gallery.currval, 0, 0)";
        
        // PreparedStatement 객체 생성 및 파라미터 설정
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, galleryVO.getTitle());
        pstmt.setString(2, galleryVO.getDescription());
        pstmt.setString(3, galleryVO.getFileName());
        pstmt.setString(4, galleryVO.getFilePath());
        pstmt.setString(5, galleryVO.getMemberId()); // memberId 설정
        
        // 쿼리 실행
        row = pstmt.executeUpdate();
        
        conn.commit(); // 트랜잭션 커밋
    } catch (SQLException e) {
        e.printStackTrace();
        System.out.println("게시물 등록 중 오류 발생");
        try {
            conn.rollback(); // 롤백 처리
        } catch (SQLException e1) {
            e1.printStackTrace();
        }
    } finally {
        closeResource(); // 자원 해제
    }
    
    return row;
}

   /**
    * 답글 등록 처리 메소드[트랜잭션]
    * - 기존 답글들의 replyOrder + 1 증가 시키는 작업
    * - 답변 게시물 등록 작업
    */
   public int insertReplyGallery(GalleryVO galleryVO) {
      int row = 0;
      
      try{
         conn = dataSource.getConnection();
         conn.setAutoCommit(false); // 트랜잭션 시작(오토컷밋 중지)
         
         // 1단계 기존 답글들의 replyOrder 를 +1씩 증가
         String updateQuery = "update board set reply_order = reply_order + 1 " +
                        "where reply_group = ? " +
                        "and reply_order > ?";
         pstmt = conn.prepareStatement(updateQuery);
         pstmt.setInt(1, galleryVO.getReplyGroup());   // 부모의 그룹번호
         pstmt.setInt(2, galleryVO.getReplyOrder());   // 부모의 그룹내 순번(order)
         row = pstmt.executeUpdate();
         if(row > 0) {
            System.out.println("답글 저장전 기존 답글들의 reply_order 업데이트 성공");
         }
         
         // 2단계 답글 등록   
         String sql = "insert into board(bno, title, description, member_id, reply_group, reply_order, reply_indent) ";
         sql +=       " values(seq_board.nextval, ?, ?, ?, ?, ?, ?) ";
         // PreparedStatment 객체 얻기
         pstmt = conn.prepareStatement(sql);
         pstmt.setString(1, galleryVO.getTitle());      // 제목
         pstmt.setString(2, galleryVO.getDescription());   // 내용
         pstmt.setString(3, galleryVO.getMemberId());   // 작성자         
         pstmt.setInt(4, galleryVO.getReplyGroup());   // 부모의 replyGroup을 넣어줌(그래야 부모와 묶임)         
         pstmt.setInt(5, galleryVO.getReplyOrder() + 1);   // 부모의 replyOrder + 1을 넣어줌(그래야 부모 바로 밑에 위치함)         
         pstmt.setInt(6, galleryVO.getReplyIndent() + 1);   // 부모의 replyIndent + 1을 넣어줌(부모 보다 한칸더 들여써짐)         
         
         row = pstmt.executeUpdate();   // 저장처리
         if(row > 0) {
            conn.commit();
         }else {
            conn.rollback();
         }
      }catch(Exception e){
         e.printStackTrace();
         try {
            conn.rollback();
         } catch (SQLException e1) {
            e1.printStackTrace();
         }
         System.out.println("답글 등록중 오류가 발생했습니다.");
      }finally{
         closeResource();   // 자원해제(반납)
      }      
      return row;
   }
   
   
   public List<GalleryVO> getGalleryList(GalleryVO galleryVO) {
	    List<GalleryVO> galleryList = new ArrayList<>();
	    
	    int start = 0;   // 시작 게시물 번호
	      int end = 0;   // 끝 게시물 번호
	      
	      start = (Integer.parseInt(galleryVO.getPageNum()) - 1) * galleryVO.getListCount() ;
	      // 가져올 게시물수
	      end = galleryVO.getListCount() ;
	    
	    try {
	        StringBuffer sql = new StringBuffer();
	        
	        sql.append("SELECT bno, title, file_name, description, member_id, reg_date, reply_group, reply_order, reply_indent ");
	        sql.append("FROM gallery ");
	        sql.append("ORDER BY reply_group DESC, reply_order ASC, reply_indent ASC ");
	        sql.append("OFFSET ? ROWS ");
	        sql.append("FETCH NEXT ? ROWS ONLY ");
	        
	        conn = dataSource.getConnection();
	        pstmt = conn.prepareStatement(sql.toString());
	        pstmt.setInt(1, start);
	        pstmt.setInt(2, end);
	        
	        rs = pstmt.executeQuery();
	        
	        while(rs.next()) {
	            GalleryVO gallery = new GalleryVO();
	            gallery.setBno(rs.getInt("bno"));
	            gallery.setTitle(rs.getString("title"));
	            gallery.setFileName(rs.getString("file_name"));
	            gallery.setDescription(rs.getString("description"));
	            gallery.setMemberId(rs.getString("member_id"));
	            gallery.setRegDate(rs.getDate("reg_date"));
	            gallery.setReplyGroup(rs.getInt("reply_group"));
	            gallery.setReplyOrder(rs.getInt("reply_order"));
	            gallery.setReplyIndent(rs.getInt("reply_indent"));
	            
				galleryList.add(gallery); 
	         
	        }
	    } catch (SQLException e) {
	        System.out.println("getGalleryList ERR : " + e.getMessage());
	        e.printStackTrace();
	    } finally {
	        closeResource();
	    }
	    return galleryList;
	}

   
   
   /**
    * 검색 기능 메소드
    */
   public List<GalleryVO> searchGalleryList(String keyword){
      List<GalleryVO> galleryList = new ArrayList<>();
      try {
         conn = dataSource.getConnection();
         
         String sql = "select bno, title, description, file_name, file_path, member_id, reg_date from gallery " +
                  " where title like ? or description like ? or member_id like ?";
         pstmt = conn.prepareStatement(sql);
         pstmt.setString(1, "%" + keyword + "%");
         pstmt.setString(2, "%" + keyword + "%");
         pstmt.setString(3, "%" + keyword + "%");
         rs = pstmt.executeQuery();
         
         while(rs.next()) {
            GalleryVO galleryVO = new GalleryVO();
            galleryVO.setBno(rs.getInt("bno"));
            galleryVO.setTitle(rs.getString("title"));
            galleryVO.setFileName(rs.getString("file_name"));
            galleryVO.setFilePath(rs.getString("file_path"));
            galleryVO.setDescription(rs.getString("description"));
            galleryVO.setMemberId(rs.getString("member_id"));
            galleryVO.setRegDate(rs.getDate("reg_date"));
            galleryList.add(galleryVO);         
         }
      }catch (SQLException e) {
         System.out.println("getgalleryList ERR : " + e.getMessage());
         e.printStackTrace();   // 콘솔에 오류
      }finally {
         closeResource();
      }
      return galleryList;
   }
   
   /**
    * 게시물 내용 보기
    */
   public GalleryVO getGallery(int bno) {
      System.out.println("getGallery");
      GalleryVO galleryVO = null;
      
      try {
         conn = dataSource.getConnection();
         
           // 게시물 조회 쿼리
         String sql = "SELECT bno, title, description, file_name, file_path, member_id, reg_date, " +
                 "reply_group, reply_order, reply_indent, hit_no " +                 
                 "FROM gallery " + 
                 "WHERE bno = ? ";       
           pstmt = conn.prepareStatement(sql);   // PreparedStatement 객체 얻기(쿼리문 전달)
           pstmt.setInt(1, bno);
           rs = pstmt.executeQuery(); // 게시물 1건 반환
           
         if(rs.next()){
            galleryVO = new GalleryVO();
            galleryVO.setBno(rs.getInt("bno"));
            galleryVO.setTitle(rs.getString("title"));
            galleryVO.setDescription(rs.getString("description"));      // 게시물 내용
            galleryVO.setFileName(rs.getString("file_name"));	
            galleryVO.setMemberId(rs.getString("member_id"));
            galleryVO.setRegDate(rs.getDate("reg_date"));
            galleryVO.setHitNo(rs.getInt("hit_no"));            // 조회수
            galleryVO.setReplyGroup(rs.getInt("reply_group"));   // 그룹번호
            galleryVO.setReplyOrder(rs.getInt("reply_order"));   // 그룹내 순서
            galleryVO.setReplyIndent(rs.getInt("reply_indent"));   // 들여쓰기
            galleryVO.setHitNo(rs.getInt("hit_no"));
            
         }        
       } catch (SQLException e) {
          System.out.println("getgallery() ERR => " + e.getMessage());
           e.printStackTrace();
       } finally {
           closeResource();
       }     
      return galleryVO;
   }
   
   /**
    * 게시물 	조회수 증가 메소드
    */
   public void incrementHitNo(int bno) {
      try {
         conn = dataSource.getConnection();
         
           // 게시물의 조회수 증가 쿼리
           // 조회수 증가 쿼리문 실행
           String updateHitSql = "UPDATE gallery SET hit_no = hit_no + 1 WHERE bno = ?";
           pstmt = conn.prepareStatement(updateHitSql);
           pstmt.setInt(1, bno);
           pstmt.executeUpdate();
           pstmt.close();
      }catch (SQLException e) {
         e.printStackTrace();
      }finally {
         closeResource();
      }
   }
   
   /**
    * 게시물 수정
    */
   public int updateGallery(GalleryVO galleryVO) {
      int row = 0;
      try {
         conn = dataSource.getConnection();
         String sql = "update gallery set title=?, description=? where bno=?" ;
           
           pstmt = conn.prepareStatement(sql);   // PreparedStatement 객체 얻기(쿼리문 전달)
           pstmt.setString(1, galleryVO.getTitle());      // title
           pstmt.setString(2, galleryVO.getDescription());   // content
           pstmt.setInt(3, galleryVO.getBno());         // bno   
           
           row = pstmt.executeUpdate();   // 쿼리문 실행 영향 받은 행수 반환         
      }catch (SQLException e) {
         e.printStackTrace();
      }finally {
         closeResource();
      }
      return row;
   }
   
   /**
    * 게시물 삭제
    */
   public int deleteGallery(int bno) {
      int row = 0;
      try {
         conn = dataSource.getConnection();
          String sql = "delete gallery where bno=?" ;   // ? 동적파라미터
           pstmt = conn.prepareStatement(sql);   // PreparedStatement 객체 얻기(쿼리문 전달)
           pstmt.setInt(1, bno);         // bno   
           row = pstmt.executeUpdate();   // 쿼리문 실행 영향 받은 행수 반환
      }catch(SQLException e) {
         e.printStackTrace();
      }finally {
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
            conn.close();   // 컨넥션 반납
      } catch (Exception e) {
         e.printStackTrace();
      }
   }
   /**
    * 전체 게시물의 갯수를 조회하는 메소드
    */
   public int getAllCount() {
      int totalCount = 0;
      StringBuffer sql = new StringBuffer();
      sql.append("select count(*) as totalCount ");
      sql.append(" from gallery");
      try {
         conn = dataSource.getConnection();
         pstmt = conn.prepareStatement(sql.toString());
         rs = pstmt.executeQuery();
         if(rs.next()) {
            totalCount = rs.getInt("totalCount");
            System.out.println("GalleryDAO totlalCount : " + totalCount);
         }
      }catch (Exception e) {
         e.printStackTrace();
         
      }
      return totalCount;
   }
}
