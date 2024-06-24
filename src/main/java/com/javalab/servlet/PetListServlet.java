package com.javalab.servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.javalab.dao.PetDAO;
import com.javalab.vo.PetVO;

/**
 * 반려동물 목록 서블릿
 */
@WebServlet("/petList")
public class PetListServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public PetListServlet() {
        super();
    }

    /**
     * 반려동물 목록 조회
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // 키워드 파라미터 추출 (이 부분은 필요에 따라 추가할 수 있음)
        String keyword = request.getParameter("keyword");

        // 사용자가 요청한 페이지(화면 하단의 페이지 번호 클릭했을 때)
        String pageNum = request.getParameter("pageNum");

        // 처음 화면이 열릴 때는 기본적으로 1페이지가 보이도록 설정
        int currentPage = 1;
        if (pageNum != null && !pageNum.isEmpty()) {
            currentPage = Integer.parseInt(pageNum);
        }

        // 한 페이지에 보여줄 반려동물 수
        int petsPerPage = 10;

        // 데이터베이스 전담 객체 생성
        PetDAO petDAO = PetDAO.getInstance();

        // 전체 반려동물 수 가져오기
        int totalCount = petDAO.getAllCount(); // 실제 구현 필요

        // 페이징 처리된 페이지 목록 가져오기
        List<PetVO> petList = petDAO.getPetList(currentPage, petsPerPage);

        // request 영역에 데이터 저장
        request.setAttribute("petList", petList); // 반려동물 목록
        request.setAttribute("totalCount", totalCount); // 전체 반려동물 수 (페이징 계산용)

        // petList.jsp로 forward
        RequestDispatcher rd = request.getRequestDispatcher("/petList.jsp");
        rd.forward(request, response);
    }

    /**
     * 반려동물 등록 (POST 요청 처리는 여기서 사용하지 않으므로 생략)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // doPost는 여기서 사용하지 않으므로 생략
    }
}
