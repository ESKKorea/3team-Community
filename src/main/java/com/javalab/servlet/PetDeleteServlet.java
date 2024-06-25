package com.javalab.servlet;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.javalab.dao.PetDAO;

/**
 * Servlet implementation class PetDeleteServlet
 */
@WebServlet("/petDelete")
public class PetDeleteServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PetDeleteServlet() {
        super();
    }

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 파라미터 인코딩
        request.setCharacterEncoding("utf-8");

        // 삭제할 게시물 번호 추출
        int bno = Integer.parseInt(request.getParameter("bno"));

        // DAO에 게시물 삭제 요청
        PetDAO petDAO = PetDAO.getInstance();

        int row = petDAO.deletePet(bno); // 여기서 객체 인스턴스를 사용하도록 수정

        // 데이터베이스 작업 결과로 분기
        if(row > 0) {
            String contextPath = request.getContextPath();
            response.sendRedirect(contextPath + "/petList");
        } else {
            request.setAttribute("error", "게시물 삭제에 실패했습니다.");
            RequestDispatcher rd = request.getRequestDispatcher("/petDetail?bno=" + bno);
            rd.forward(request, response);
        }
    }
}
