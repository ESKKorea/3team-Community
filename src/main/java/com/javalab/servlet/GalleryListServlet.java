package com.javalab.servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.javalab.dao.GalleryDAO;
import com.javalab.util.PageNavigator;
import com.javalab.util.PageNavigator2;
import com.javalab.vo.GalleryVO;

/**
 * Servlet implementation class GalleryListServlet
 */
@WebServlet("/galleryList")
public class GalleryListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public GalleryListServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 키워드 파라미터 추출
	      String keyword = request.getParameter("keyword");
	      
	      // 사용자가 요청한 페이지(화면 하단의 페이지 번호 클릭했을 때)
	      String pageNum = request.getParameter("pageNum");
	      
	      // 처음 화면이 열릴 때는 기본적으로 1페이지가 보이도록 설정
	      if(pageNum == null) {
	         pageNum = "1";
	      }
	      
	      GalleryVO galleryVO = new GalleryVO();
	      galleryVO.setPageNum(pageNum);
	      
	      List<GalleryVO> galleryList = null;
	      // 데이터베이스 전담 객체 생성
	      GalleryDAO galleryDAO = GalleryDAO.getInstance();
	      
	      // 키워드 유무에 따른 분기
	      if(keyword != null && !keyword.isEmpty()) {
	         galleryList = galleryDAO.searchGalleryList(keyword); // 검색기능 메소드 호출
	      }else {
	         galleryList = galleryDAO.getGalleryList(galleryVO); // getBoardList() 호출
	      }
	      
	      // 전체 게시물 수 구하기
	      int totalCount = galleryDAO.getAllCount();
	      
	      // 이동해갈 페이지에서 사용할 수있게 request 영역 저장
	      request.setAttribute("totalCount", totalCount);   // 전체페이지 갯수
	      request.setAttribute("pageNum", pageNum); // 요청 페이지 번호
	      
	      PageNavigator2 pageNavigator2 = new PageNavigator2();
	      // jsp 화면에 보여질 페이징 문자열 만들기
	      String pageNums = pageNavigator2.getPageNavigator2(
	                              totalCount, 
	                              galleryVO.getListCount(), 
	                              galleryVO.getPagerPerBlock(), 
	                              Integer.parseInt(pageNum));
	      // 디버깅 문자열
	      System.out.println("pageNums : " + pageNums);
	      
	      // 페이징 문자열을 request영역에 저장
	      request.setAttribute("page_navigator", pageNums);      
	      
	      // request영역에 boardList 저장
	      request.setAttribute("galleryList", galleryList);   
	      
	      // 저장한 boardList 출력할 페이지인 boardList.jsp 이동
	      // 여기서 "/" 슬래시는 웹 애플리케이션의 컨텍스트 루트를 말한다.(추가 주석)
	      RequestDispatcher rd = request.getRequestDispatcher("/galleryList.jsp");
	      rd.forward(request, response);
	   }
	
	
}
