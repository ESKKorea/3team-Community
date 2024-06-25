<%@ page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.sql.*, java.util.*, com.javalab.vo.*, com.javalab.dao.*"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<%-- 현재 시간의 시분초를 now 변수에 세팅 --%>
<c:set var="now" value="<%= new java.util.Date() %>" />

<%
    // 게시물 번호(웹에서는 파라미터가 모두 문자열이므로 int 변환)
    int bno = Integer.parseInt(request.getParameter("bno"));

    // 데이터베이스 드라이버 로딩 문자열 
    String JDBC_DRIVER = "oracle.jdbc.driver.OracleDriver";
    // 데이터베이스 연결 문자열
    String DB_URL = "jdbc:oracle:thin:@localhost:1521:orcl";
    String DB_USER = "rboard";
    String DB_PASSWORD = "1234";

    Connection conn = null; // 커넥션 객체
    PreparedStatement pstmt = null; // 쿼리문 생성 및 실행 객체
    ResultSet rs = null; // 쿼리 실행 결과 반환 객체

    GalleryVO gallery = null;

    try {
        Class.forName(JDBC_DRIVER); // jdbc 드라이버 로딩
        conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD); // 커넥션 객체 획득

        String sql = "SELECT bno, title, description, member_id, file_name, file_path, reg_date FROM gallery WHERE bno = ? ";
        pstmt = conn.prepareStatement(sql); // PreparedStatement 객체 얻기(쿼리문 전달)
        pstmt.setInt(1, bno);
        rs = pstmt.executeQuery(); // 게시물 1건 반환

        if (rs.next()) {
            gallery = new GalleryVO();
            gallery.setBno(rs.getInt("bno"));
            gallery.setTitle(rs.getString("title"));
            gallery.setDescription(rs.getString("description")); // 게시물 내용
            gallery.setFileName(rs.getString("file_name"));
            gallery.setFilePath(rs.getString("file_path"));
            gallery.setMemberId(rs.getString("member_id"));
            gallery.setRegDate(rs.getTimestamp("reg_date"));
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        try {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // 게시물목록을 현재 페이지 객체에 저장
    pageContext.setAttribute("gallery", gallery);

    // 갤러리 댓글목록 조회
    List<CommentVO> comments = null;
    GalleryCommentDAO commentDAO = GalleryCommentDAO.getInstance();
    comments = commentDAO.getCommentsByGalleryId(gallery.getBno());
    pageContext.setAttribute("comments", comments);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>galleryDetail.jsp</title>
<link rel="stylesheet" type="text/css"
    href="<c:url value='/css/galleryDetail.css'/>?v=${now}" />
</head>
<div class="nav">
        <div class="logo">
        <a href="${contextPath}/index.jsp"><img src="./image/logo.png" alt=""></a>
        </div>
        <div class="nav_but">
            <a href="${contextPath}/boardList">자유게시판</a>
            <a href="${contextPath}/galleryList">갤러리 게시판</a>
            <a href="">분양 게시판</a>
             <c:choose>
            <c:when test="${not empty sessionScope.member}">
            	<div class="user-info">
                 <a href="<c:url value='/logoutServlet'/>">로그아웃</a>
                <p><strong>${sessionScope.member.name}</strong>님 환영합니다!</p>
                 </div>
            </c:when>
            <c:otherwise>
                <a href="<c:url value='/login'/>">로그인</a>
            </c:otherwise>
        </c:choose>
        	</div>
        </div>
<body>
<main>
    <div class="container">
        <img src="${contextPath}/uploads/${gallery.fileName}" alt="${gallery.title}" class="image-uploaded">
        <div class="gallery-info">
            <h2>${gallery.title}</h2>
            <p><strong>작성자:</strong> ${gallery.memberId}</p>
            <p><strong>작성일자:</strong> <fmt:formatDate value="${gallery.regDate}" pattern="yyyy-MM-dd HH:mm:ss" /></p>
            <p><strong>내용:</strong> ${gallery.description}</p>
        </div>
    </div>

    <div class="button-container">
        <a href="<c:url value='/galleryList'/>"><button type="button" id="button">목록</button></a>
        <form action="<c:url value='/galleryDelete'/>" method="post">
            <input type="hidden" name="bno" value="${gallery.bno}">
            <input type="submit" value="삭제" onclick="return confirm('정말 삭제하시겠습니까?');" style="padding: 10px 20px; border: none; cursor: pointer; background-color: #f8f8f8; color: black; border-radius: 5px; transition: background-color 0.3s ease;">
        </form>
        <a href="<c:url value='/reply'/>?bno=${gallery.bno}"><button style="padding: 10px 20px; border: none; cursor: pointer; background-color: #f8f8f8; color: black; border-radius: 5px; transition: background-color 0.3s ease;">답글작성</button></a>
    </div>

    <!-- 댓글 섹션 시작 -->
    <div class="comments-section">
        <h3>댓글</h3>
        <c:forEach var="comment" items="${comments}">
            <div class="comment">
                <p class="comment-author">${comment.memberId}</p>
                <p class="comment-date"><fmt:formatDate value="${comment.regDate}" pattern="yyyy-MM-dd HH:mm:ss" /></p>
                <p class="comment-content">${comment.content}</p>
                <c:if test="${sessionScope.member != null && sessionScope.member.memberId == comment.memberId}">
                    <div class="comment-actions">
                        <a href="<c:url value='/galleryComment'/>?action=delete&id=${comment.id}&galleryId=${gallery.bno}">삭제</a>
                    </div>
                </c:if>
            </div>
        </c:forEach>
    </div>
    <!-- 댓글 섹션 끝 -->

    <!-- 댓글 입력 폼 시작 -->
    <div class="comment-form">
        <h3>댓글 작성</h3>
        <form action="<c:url value='/galleryComment'/>" method="post">
            <input type="hidden" name="galleryId" value="${gallery.bno}">
            <textarea name="content" placeholder="댓글을 작성하세요" required></textarea>
            <input type="submit" value="댓글 작성">
        </form>
    </div>
    </main>
    <!-- 댓글 입력 폼 끝 -->
    <footer>
    <div class="container">
        <div class="left">
            <h1>CAT X DOG BOARD</h1>
            <p>3TEAM@git.com</p>
            <div class="sns">
                <i class="fab fa-twitter"></i>
                <i class="fab fa-facebook-square"></i>
                <i class="fab fa-instagram"></i>
                <i class="fab fa-github"></i>
            </div>
        </div>
        <div class="right">
            <div class="list">
                <h2>context</h2>
                <ul>
                    <li>context1</li>
                    <li>context2</li>
                    <li>context3</li>
                    <li>context4</li>
                </ul>
            </div>
            <div class="list">
                <h2>Popular Posts</h2>
                <ul>
                    <li>posts1</li>
                    <li>posts2</li>
                    <li>posts3</li>
                    <li>posts4</li>
                </ul>
            </div>
        </div>
    </div>
    <div class="copy_right">
        <p>3TEAM3</p>
    </div>
</footer>
    <script>
        // 이미지 크기 조정
        var img = document.querySelector('.image-uploaded');
        if (img && img.width > 500) {
            img.style.width = '500px';
            img.style.height = 'auto';
        }
    </script>
</body>
</html>
