package com.javalab.servlet;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.javalab.dao.CommentDAO;
import com.javalab.dao.GalleryCommentDAO;
import com.javalab.vo.CommentVO;
import com.javalab.vo.MemberVO;

/**
 * 갤러리 댓글 등록 및 삭제 처리 서블릿
 */
@WebServlet("/galleryComment")
public class GalleryCommentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public GalleryCommentServlet() {
        super();
    }

    /**
     * 댓글 등록 및 수정 처리
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // 파라미터 인코딩 설정
            request.setCharacterEncoding("utf-8");

            // 파라미터 값 확인
            String galleryIdParam = request.getParameter("galleryId");
            String content = request.getParameter("content");
            if (galleryIdParam == null || galleryIdParam.isEmpty() || content == null || content.isEmpty()) {
                throw new IllegalArgumentException("갤러리 ID나 내용이 없습니다.");
            }

            int galleryId = Integer.parseInt(galleryIdParam);

            // 세션에서 로그인 사용자 아이디 가져오기
            HttpSession session = request.getSession();
            MemberVO memberVO = (MemberVO) session.getAttribute("member");
            if (memberVO == null) {
                throw new IllegalArgumentException("로그인 정보가 없습니다.");
            }

            String memberId = memberVO.getMemberId();

            // CommentVO 객체 생성 및 데이터 설정
            CommentVO comment = new CommentVO();
            comment.setGalleryId(galleryId);
            comment.setMemberId(memberId);
            comment.setContent(content);

            // GalleryCommentDAO 호출하여 댓글 등록 또는 수정
            GalleryCommentDAO commentDAO = GalleryCommentDAO.getInstance();
            int row = 0;

            // 댓글 ID가 있으면 수정, 없으면 등록
            String commentIdParam = request.getParameter("commentId");
            if (commentIdParam != null && !commentIdParam.isEmpty()) {
                int commentId = Integer.parseInt(commentIdParam);
                comment.setId(commentId);
                row = commentDAO.updateComment(comment);
            } else {
                row = commentDAO.insertGalleryComment(comment);
            }

            if (row > 0) {
                response.sendRedirect("galleryDetail?bno=" + galleryId);
            } else {
                request.setAttribute("error", "댓글 작성에 실패했습니다.");
                RequestDispatcher rd = request.getRequestDispatcher("galleryDetail?bno=" + galleryId);
                rd.forward(request, response);
            }
        } catch (NumberFormatException e) {
            request.setAttribute("error", "잘못된 갤러리 ID 형식입니다.");
            RequestDispatcher rd = request.getRequestDispatcher("/error.jsp");
            rd.forward(request, response);
        } catch (IllegalArgumentException e) {
            request.setAttribute("error", e.getMessage());
            RequestDispatcher rd = request.getRequestDispatcher("/error.jsp");
            rd.forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "알 수 없는 오류가 발생했습니다.");
            RequestDispatcher rd = request.getRequestDispatcher("/error.jsp");
            rd.forward(request, response);
        }
    }

    /**
     * 댓글 삭제 처리
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String action = request.getParameter("action");
            if ("delete".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                int galleryId = Integer.parseInt(request.getParameter("galleryId"));

                // GalleryCommentDAO 호출하여 댓글 삭제
                GalleryCommentDAO commentDAO = GalleryCommentDAO.getInstance();
                commentDAO.deleteComment(id);

                response.sendRedirect("galleryDetail?bno=" + galleryId);
            }
        } catch (NumberFormatException e) {
            request.setAttribute("error", "잘못된 요청입니다.");
            RequestDispatcher rd = request.getRequestDispatcher("/error.jsp");
            rd.forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "알 수 없는 오류가 발생했습니다.");
            RequestDispatcher rd = request.getRequestDispatcher("/error.jsp");
            rd.forward(request, response);
        }
    }
}
