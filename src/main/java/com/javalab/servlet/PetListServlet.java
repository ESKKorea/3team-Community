package com.javalab.servlet;

import java.io.IOException;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.javalab.dao.PetDAO;
import com.javalab.util.PageNavigator;
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
        // 키워드 파라미터 추출
        String keyword = request.getParameter("keyword");

        // 사용자가 요청한 페이지(화면 하단의 페이지 번호 클릭했을 때)
        String pageNum = request.getParameter("pageNum");

        // 처음 화면이 열릴 때는 기본적으로 1페이지가 보이도록 설정
        if (pageNum == null) {
            pageNum = "1";
        }

        // 데이터베이스 전담 객체 생성
        PetDAO petDAO = PetDAO.getInstance();
        
        // 전체 반려동물 수 구하기 (가정)
        int totalCount = petDAO.getAllCount(); // 실제 구현 필요

        // PageNavigator 객체 생성
        PageNavigator pageNavigator = new PageNavigator();

        // 현재 페이지 설정
        int currentPage = Integer.parseInt(pageNum);

        // 페이징 처리된 페이지 목록 문자열 생성
        String pageNavigatorString = pageNavigator.getPageNavigator(
                totalCount, // 전체 반려동물 수
                10, // 한 페이지에 보여줄 반려동물 수
                10, // 페이지에 보여줄 페이지 번호 수
                currentPage); // 현재 페이지

        // petList 가져오기
        List<PetVO> petList = new ArrayList<>();// 실제 구현 필요

        // 키워드 유무에 따른 분기
	      if(keyword != null && !keyword.isEmpty()) {
	         petList = petDAO.searchPetList(keyword); // 검색기능 메소드 호출
	      }else {
	         petList = petDAO.getPetList(currentPage, 10); // getBoardList() 호출
	      }
	      
        // request 영역에 데이터 저장
        request.setAttribute("page_navigator", pageNavigatorString); // 페이징 처리 문자열
        request.setAttribute("petList", petList); // 반려동물 목록

        // petList.jsp로 forward
        RequestDispatcher rd = request.getRequestDispatcher("/petList.jsp");
        rd.forward(request, response);
    }
}