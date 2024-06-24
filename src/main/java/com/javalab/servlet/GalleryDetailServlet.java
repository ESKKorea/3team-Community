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
import com.javalab.dao.GalleryCommentDAO;
import com.javalab.vo.GalleryVO;
import com.javalab.vo.CommentVO;

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

        try {
            // 파라미터 추출
            int bno = Integer.parseInt(request.getParameter("bno"));

            // GalleryDAO 객체 생성
            GalleryDAO galleryDAO = GalleryDAO.getInstance();

            // 조회 증가
            galleryDAO.incrementHitNo(bno);

            // 게시물 조회
            GalleryVO galleryVO = galleryDAO.getGallery(bno);

            // GalleryCommentDAO 객체 생성
            GalleryCommentDAO commentDAO = GalleryCommentDAO.getInstance();
            List<CommentVO> comments = commentDAO.getCommentsByGalleryId(bno);

            // request 영역에 저장
            request.setAttribute("galleryVO", galleryVO);
            request.setAttribute("comments", comments);

            // 게시물 내용보기 페이지 이동
            RequestDispatcher rd = request.getRequestDispatcher("/galleryDetail.jsp");
            rd.forward(request, response);
        } catch (NumberFormatException e) {
            request.setAttribute("error", "잘못된 게시물 번호 형식입니다.");
            RequestDispatcher rd = request.getRequestDispatcher("/error.jsp");
            rd.forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "알 수 없는 오류가 발생했습니다.");
            RequestDispatcher rd = request.getRequestDispatcher("/error.jsp");
            rd.forward(request, response);
        }
    }

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
