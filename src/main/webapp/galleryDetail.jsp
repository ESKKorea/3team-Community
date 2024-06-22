<%@ page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.sql.*, java.util.*, com.javalab.vo.*"%>
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
    String DB_USER = "teamboard";
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
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>boardList.jsp</title>
<link rel="stylesheet" type="text/css"
	href="<c:url value='/css/board.css'/>?v=${now}" />
</head>
<body>
	<div class="container">
		<%-- 헤더부분 include 액션 태그 사용, c:url 사용금지, 경로 직접 지정해야함 --%>
		<jsp:include page="/common/header.jsp" />
	</div>
	<main>
		<table border="1">
			<tr>
				<th>게시물번호</th>
				<td><c:out value="${gallery.bno}" /></td>
			</tr>
			<tr>
				<th>제목</th>
				<td><c:out value="${gallery.title}" /></td>
			</tr>
			<tr>
				<th>사진</th>
				<td><img src="${contextPath}/uploads/${gallery.fileName}"
					alt="${gallery.title}" class="image-uploaded"></td>
			</tr>
			<tr>
				<th>내용</th>
				<td><c:out value="${gallery.description}" /></td>
			</tr>
			<tr>
				<th>작성자</th>
				<td><c:out value="${gallery.memberId}" /></td>
			</tr>
			<tr>
				<th>작성일자</th>
				<td><fmt:formatDate value="${gallery.regDate}"
						pattern="yyyy-MM-dd HH:mm:ss" /></td>
			</tr>
		</table>
	</main>
	<br>
	<div class="button-container">
		<a href="<c:url value='/galleryList'/>"><button type="button"
				id="button">목록</button></a> <a
			href="<c:url value='/galleryUpdate'/>?bno=${galleryVO.bno}"><button
				type="button" id="button">수정</button></a>
		<form action="<c:url value='/galleryDelete'/>" method="post">
			<input type="hidden" name="bno" value="${galleryVO.bno}"> <input
				type="submit" value="삭제" onclick="return confirm('정말 삭제하시겠습니까?');">
		</form>
		<a href="<c:url value='/reply'/>?bno=${galleryVO.bno}"><button>답글작성</button></a>
	</div>
	 <script>
        // 이미지 크기 조정
        var img = document.querySelector('.image-uploaded');
        if (img && img.width > 800) {
            img.style.width = '800px';
            img.style.height = 'auto';
        }
    </script>
</body>
</html>
