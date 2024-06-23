package com.javalab.servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.javalab.dao.BoardDAO;
import com.javalab.dao.GalleryDAO;
import com.javalab.vo.BoardVO;
import com.javalab.vo.GalleryVO;

/**
 * 게시물 내용 보기 서블릿
 */
@WebServlet("/galleryDetail")
public class GalleryDetailServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public GalleryDetailServlet() {
		super();
	}

	/**
	 * 게시물 내용 조회
	 */

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		System.out.println("bno: " + request.getParameter("bno"));
		// 파라미터 추출
		int bno = Integer.parseInt(request.getParameter("bno"));
		
		// BoardDAO 객체 생성
	      GalleryDAO galleryDAO = GalleryDAO.getInstance();

		
		// 1. 조회증가
		galleryDAO.incrementHitNo(bno);
		
		// 2. 게시물 조회
		GalleryVO galleryVO = galleryDAO.getGallery(bno);
		
		// request 영역에 저장
		request.setAttribute("galleryVO", galleryVO);
		
		// 게시물 내용보기 페이지 이동
		RequestDispatcher rd = request.getRequestDispatcher("/galleryDetail.jsp");
		rd.forward(request, response);

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
