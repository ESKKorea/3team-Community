package com.javalab.servlet;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import com.javalab.dao.GalleryDAO;
import com.javalab.vo.GalleryVO;
import com.javalab.vo.MemberVO;

@WebServlet("/GalleryServlet")
public class GalleryServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String UPLOAD_DIRECTORY = "uploads";

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // message body 파라미터 인코딩
        request.setCharacterEncoding("utf-8");
        
        HttpSession ses = request.getSession();
        MemberVO memberVO = (MemberVO) ses.getAttribute("member");
        String memberId = memberVO != null ? memberVO.getMemberId() : null; // 사용자Id

        if (memberId == null) {
            request.setAttribute("error", "로그인이 필요합니다.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("loginForm.jsp");
            dispatcher.forward(request, response);
            return;
        }

        // 파일 업로드 처리
        String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIRECTORY;
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdir(); // 디렉토리 생성
        }

        DiskFileItemFactory factory = new DiskFileItemFactory();
        factory.setRepository(new File(System.getProperty("java.io.tmpdir")));
        factory.setSizeThreshold(1024 * 1024); // 1MB

        ServletFileUpload upload = new ServletFileUpload(factory);

        String title = null;
        String description = null;
        String fileName = null;
        String filePath = null;

        try {
            List<FileItem> items = upload.parseRequest(request);
            for (FileItem item : items) {
                if (item.isFormField()) {
                    String fieldName = item.getFieldName();
                    String fieldValue = item.getString("utf-8");

                    if ("title".equals(fieldName)) {
                        title = fieldValue;
                    } else if ("description".equals(fieldName)) {
                        description = fieldValue;
                    }
                } else {
                    fileName = new File(item.getName()).getName();
                    filePath = uploadPath + File.separator + fileName;
                    File uploadFile = new File(filePath);
                    item.write(uploadFile);
                }
            }

        } catch (Exception e) {
            request.setAttribute("error", "파일 업로드 실패: " + e.getMessage());
            RequestDispatcher dispatcher = request.getRequestDispatcher("galleryInsertForm.jsp");
            dispatcher.forward(request, response);
            return;
        }

        // 게시물 정보 데이터베이스 저장
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
