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
import com.javalab.vo.CommentVO;
import com.javalab.vo.MemberVO;

/**
 * 댓글 등록 및 삭제 처리
 */
@WebServlet("/comment")
public class CommentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public CommentServlet() {
        super();
    }

    /**
     * 댓글 등록 처리
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("CommentServlet doPost");

        try {
            // 파라미터 인코딩 설정
            request.setCharacterEncoding("utf-8");

            // 파라미터 값 확인
            String boardIdParam = request.getParameter("boardId");
            String content = request.getParameter("content");
            if (boardIdParam == null || boardIdParam.isEmpty() || content == null || content.isEmpty()) {
                throw new IllegalArgumentException("게시물 번호나 내용이 없습니다.");
            }

            int boardId = Integer.parseInt(boardIdParam);

            // 세션에서 로그인 사용자 아이디 가져오기
            HttpSession session = request.getSession();
            MemberVO memberVO = (MemberVO) session.getAttribute("member");
            if (memberVO == null) {
                throw new IllegalArgumentException("로그인 정보가 없습니다.");
            }

            String memberId = memberVO.getMemberId();

            // CommentVO 객체 생성 및 데이터 설정
            CommentVO comment = new CommentVO();
            comment.setBoardId(boardId);
            comment.setMemberId(memberId);
            comment.setContent(content);

            // CommentDAO 호출하여 댓글 등록
            CommentDAO commentDAO = CommentDAO.getInstance();
            int row = commentDAO.insertComment(comment);

            if (row > 0) { // 댓글이 정상적으로 등록됨
                response.sendRedirect("boardDetail?bno=" + boardId);
            } else { // 댓글 등록 실패
                request.setAttribute("error", "댓글 작성에 실패했습니다.");
                RequestDispatcher rd = request.getRequestDispatcher("boardDetail?bno=" + boardId);
                rd.forward(request, response);
            }
        } catch (NumberFormatException e) {
            request.setAttribute("error", "잘못된 게시물 번호 형식입니다.");
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
        System.out.println("CommentServlet doGet");

        try {
            String action = request.getParameter("action");
            if ("delete".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                int boardId = Integer.parseInt(request.getParameter("boardId"));

                // CommentDAO 호출하여 댓글 삭제
                CommentDAO commentDAO = CommentDAO.getInstance();
                commentDAO.deleteComment(id);

                response.sendRedirect("boardDetail?bno=" + boardId);
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
