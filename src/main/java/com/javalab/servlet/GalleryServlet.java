package com.javalab.servlet;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.nio.file.Paths;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import com.javalab.dao.GalleryDAO;
import com.javalab.vo.GalleryVO;
import com.javalab.vo.MemberVO;

@WebServlet("/GalleryServlet")
@MultipartConfig
public class GalleryServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String UPLOAD_DIRECTORY = "uploads";

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	
    	// message body 파라미터 인코딩
        request.setCharacterEncoding("utf-8");
        
        HttpSession ses = request.getSession();
		MemberVO memberVO = (MemberVO) ses.getAttribute("member");
		String memberId = memberVO.getMemberId(); // 사용자Id

        // 파일 업로드 처리
        String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIRECTORY;
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdir(); // 디렉토리 생성
        }

        Part filePart = request.getPart("image"); // HTML form에서 파일 파트 가져오기
        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString(); // 파일 이름 가져오기
        String filePath = uploadPath + File.separator + fileName;

        try (InputStream fileContent = filePart.getInputStream();
             OutputStream out = new FileOutputStream(new File(filePath))) {

            int read = 0;
            final byte[] bytes = new byte[1024];

            while ((read = fileContent.read(bytes)) != -1) {
                out.write(bytes, 0, read);
            }

        } catch (IOException fne) {
            request.setAttribute("error", "파일 업로드 실패: " + fne.getMessage());
            RequestDispatcher dispatcher = request.getRequestDispatcher("galleryInsertForm.jsp");
            dispatcher.forward(request, response);
            return;
        }

        // 게시물 정보 데이터베이스 저장
        String title = request.getParameter("title");
        String description = request.getParameter("description");

        // memberId가 null인지 확인
        if (memberId == null) {
            request.setAttribute("error", "로그인이 필요합니다.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("loginForm.jsp");
            dispatcher.forward(request, response);
            return;
        }

        GalleryVO galleryVO = new GalleryVO();
        galleryVO.setTitle(title);
        galleryVO.setDescription(description);
        galleryVO.setFileName(fileName);
        galleryVO.setFilePath(filePath);
        galleryVO.setMemberId(memberId);

        GalleryDAO galleryDAO = GalleryDAO.getInstance();
        int result = galleryDAO.insertGallery(galleryVO);

        if (result > 0) {
            response.sendRedirect("galleryList.jsp"); // 성공 시 갤러리 목록으로 리다이렉트
        } else {
            request.setAttribute("error", "게시물 등록에 실패했습니다.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("galleryInsertForm.jsp");
            dispatcher.forward(request, response);
        }
    }
}
