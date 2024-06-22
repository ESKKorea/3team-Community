package com.javalab.servlet;

import java.io.IOException;
import java.util.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.javalab.dao.BoardDAO;
import com.javalab.dao.CommentDAO;
import com.javalab.vo.BoardVO;
import com.javalab.vo.CommentVO;


/**
 * 게시물 내용 보기 서블릿
 */
@WebServlet("/boardDetail")
public class BoardDetailServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
       
    public BoardDetailServlet() {
        super();
    }

    /**
     * 게시물 내용 조회
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // 파라미터 추출 및 검사
            String bnoParam = request.getParameter("bno");
            if (bnoParam == null || bnoParam.isEmpty()) {
                throw new IllegalArgumentException("게시물 번호가 없습니다.");
            }

            int bno = Integer.parseInt(bnoParam);

            // BoardDAO 객체 생성
            BoardDAO boardDAO = BoardDAO.getInstance();

            // 1. 조회증가
            boardDAO.incrementHitNo(bno);

            // 2. 게시물 조회
            BoardVO boardVO = boardDAO.getBoard(bno);

            if (boardVO == null) {
                throw new IllegalArgumentException("게시물을 찾을 수 없습니다.");
            }
            // 댓글 목록 조회
            CommentDAO commentDAO = CommentDAO.getInstance();
            List<CommentVO> comments = commentDAO.getCommentsByBoardId(bno);
            
            // request 영역에 저장
            request.setAttribute("boardVO", boardVO);
            request.setAttribute("comments", comments);


            // 게시물 내용보기 페이지 이동
            RequestDispatcher rd = request.getRequestDispatcher("/boardDetail.jsp");
            rd.forward(request, response);
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
}
