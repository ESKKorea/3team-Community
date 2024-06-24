package com.javalab.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.javalab.dao.PetDAO;
import com.javalab.vo.MemberVO;
import com.javalab.vo.PetVO;

@WebServlet("/pet")
public class PetServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public PetServlet() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Redirect to the pet insert form page
        response.sendRedirect(request.getContextPath() + "/petInsertForm.jsp");
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	System.out.println("petservlet dopost");
        // 요청으로부터 데이터 인코딩 설정
        request.setCharacterEncoding("UTF-8");

        // 폼으로부터 반려동물 정보 추출
        String name = request.getParameter("name");
        int age = Integer.parseInt(request.getParameter("age"));
        String type = request.getParameter("type");
        String description = request.getParameter("description");
        System.out.println("petservlet dopost name : " + name);

        // 세션에서 로그인된 회원 정보 가져오기
        HttpSession session = request.getSession();
        MemberVO memberVO = (MemberVO) session.getAttribute("member");
        String memberId = memberVO.getMemberId();

        // PetVO 객체 생성 및 정보 설정
        PetVO pet = new PetVO();
        pet.setName(name);
        pet.setAge(age);
        pet.setType(type);
        pet.setDescription(description);
        pet.setMemberId(memberId);

        // PetDAO 인스턴스 생성
        PetDAO petDAO = PetDAO.getInstance();

        // 반려동물 정보 데이터베이스에 등록
        int rowsInserted = petDAO.insertPet(pet);

        // 등록 결과에 따라 처리
        if (rowsInserted > 0) {
            // 등록 성공 시, 반려동물 목록 페이지로 리다이렉트
            response.sendRedirect(request.getContextPath() + "/petList");
        } else {
            // 등록 실패 시, 오류 메시지와 함께 다시 등록 폼 페이지로 포워딩
            request.setAttribute("error", "반려동물 정보 등록에 실패했습니다.");
            request.getRequestDispatcher("/petInsertForm.jsp").forward(request, response);
        }
    }
}

