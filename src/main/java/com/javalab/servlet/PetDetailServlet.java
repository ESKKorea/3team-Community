package com.javalab.servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.javalab.dao.PetDAO;
import com.javalab.vo.PetVO;

/**
 * 반려동물 상세 정보 보기 서블릿
 */
@WebServlet("/petDetail")
public class PetDetailServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public PetDetailServlet() {
        super();
    }

    /**
     * 반려동물 상세 정보 조회
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // 파라미터 추출 및 검사
            String idParam = request.getParameter("id");
            if (idParam == null || idParam.isEmpty()) {
                throw new IllegalArgumentException("반려동물 번호가 없습니다.");
            }

            int id = Integer.parseInt(idParam);

            // PetDAO 객체 생성
            PetDAO petDAO = PetDAO.getInstance();

            // 반려동물 정보 조회
            PetVO petVO = petDAO.getPet(id);

            if (petVO == null) {
                throw new IllegalArgumentException("반려동물을 찾을 수 없습니다.");
            }

            // request 영역에 데이터 저장
            request.setAttribute("pet", petVO);

            // 반려동물 상세 정보 페이지로 forward
            RequestDispatcher rd = request.getRequestDispatcher("/petDetail.jsp");
            rd.forward(request, response);
        } catch (NumberFormatException e) {
            request.setAttribute("error", "잘못된 반려동물 번호 형식입니다.");
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
