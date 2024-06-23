<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.sql.*, java.util.*,com.javalab.vo.*"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<%-- 현재 시간의 시분초를 now 변수에 세팅 --%>
<c:set var="now" value="<%=new java.util.Date()%>" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>boardList.jsp</title>
<%-- css 자원요청 문자열에 시시각각 변하는 시간을 파라미터로 전달하기 때문에 서브는 매번 새로운 요청을 착각, 
	즉 늘 새로운 css를 읽어온다. 캐싱안함. --%>
<link rel="styleSheet" type="text/css"
	href="<c:url value='/css/galleryList.css'/>?v=${now}" />
</head>
<body>
<header>
    <h3>Gallery List</h3>
    <form action="<c:url value='/galleryList' />" method="get" class="search-form">
        <select name="searchType">
            <option value="member_id">작성자</option>
            <option value="title">제목</option>
            <option value="description">내용</option>
        </select>
        <input type="text" name="keyword" placeholder="검색어 입력" />
        <input type="submit" value="검색" />
    </form>
    </header>
	<main>
    <div class="gallery-container">
        <c:forEach var="gallery" items="${galleryList}" varStatus="loop">
            <div class="gallery-item" 
                 onmouseover="showInfo(this)" 
                 onmouseout="hideInfo(this)">
                <a href="${contextPath}/galleryDetail?bno=${gallery.bno}">
                    <img src="${contextPath}/uploads/${gallery.fileName}" alt="${gallery.title}" class="thumbnail">
                    <div class="gallery-info">
                        <strong>${gallery.title}</strong>
                        <p>작성자: ${gallery.memberId}</p>
                        <p>작성일자: <fmt:formatDate value="${gallery.regDate}" pattern="yyyy-MM-dd HH:mm"/></p>
                    </div>
                </a>
            </div>
        </c:forEach>
    </div>

    <p align="center">${page_navigator}</p>
    <div class="button-container">
        <br>
        <a href="<c:url value='/galleryInsertForm.jsp'/>">
            <button type="button" id="button">게시물 작성</button>
        </a>
        <a href="${contextPath }/main.jsp">
            <button type="button" id="button">메인 페이지로 이동</button>
        </a>
    </div>
</main>
<script>
    function setInfoBoxSize(img) {
        var infoBox = img.parentNode.querySelector('.gallery-info');
        infoBox.style.width = img.clientWidth + 'px';
        infoBox.style.height = img.clientHeight + 'px';
    }

    function showInfo(element) {
        var info = element.querySelector('.gallery-info');
        info.style.opacity = '1';
        info.style.visibility = 'visible';
    }

    function hideInfo(element) {
        var info = element.querySelector('.gallery-info');
        info.style.opacity = '0';
        info.style.visibility = 'hidden';
    }
</script>


</body>
</html>
