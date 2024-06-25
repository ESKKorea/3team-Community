<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.sql.*, java.util.*, com.javalab.vo.*" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<%-- now : 현재 시간의 시분초를 now 변수에 세팅 --%>
<c:set var="now" value="<%= new java.util.Date() %>" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>boardList.jsp</title>
<%-- css 자원요청 문자열에 시시각각 변하는 시간을 파라미터로 전달하기 때문에 서브는 매번 새로운 요청으로 착각, 
	늘 css 읽어온다. 캐싱안함. --%>
<link rel="stylesheet" type="text/css" href="<c:url value='/css/boardList.css' />?v=${now}" />
</head>

<body>
	<div class="nav">
    	<div class="logo">
        <a href="${contextPath}/index.jsp"><img src="./image/logo.png" alt=""></a>
    </div>
    <div class="nav_but">
        <a href="${contextPath}/boardList">자유게시판</a>
        <a href="${contextPath}/galleryList">갤러리 게시판</a>
        <a href="${contextPath}/petList">분양 게시판</a>
        <c:choose>
            <c:when test="${not empty sessionScope.member}">
                <div class="user-info">
                    <a href="<c:url value='/logout'/>">로그아웃</a>
                    <p><strong>${sessionScope.member.name}</strong>님 환영합니다!</p>
                </div>
            </c:when>
            <c:otherwise>
                <a href="<c:url value='/login'/>">로그인</a>
            </c:otherwise>
        </c:choose>
   	</div>
</div>
   	
 		<%-- 헤더부분 include 액션 태그 사용, c:url 사용금지, 경로 직접 지정해야함. --%>



		<jsp:include page="/common/boardheader.jsp" />
		

        <main>
        	<c:if test="${empty boardList}">
                <p>게시물이 존재하지 않습니다.</p>
            </c:if>
            
            <c:if test="${not empty boardList}">
            <div class="board-container">
				<table border="1">
					<colgroup>
						<col width="100" />
						<col width="500" />
						<col width="80" />
						<col width="200" />
						<col width="80" />
						<col width="100" />
						<col width="100" />
						<col width="100" />
					</colgroup>
					<thead>
						<tr>
							<th>게시물</th>
							<th>제목</th>
							<th>작성자</th>
							<th>작성일자</th>
							<th>조회수</th>
							<th>그룹</th>
							<th>그룹내정렬순서</th>
							<th>들여쓰기</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="board" items="${boardList }" varStatus="idx">
							<tr>
								<td><c:out value="${idx.count }"/></td>
								<td>
									<c:if test="${board.replyIndent > 0 }">
										<c:forEach begin="1" end="${board.replyIndent}">
											&nbsp;&nbsp;
										</c:forEach>
										<img src="<c:url value='/image/icons8-reply-20.png'/>" />
									</c:if>
									<a href="<c:url value='/boardDetail'/>?bno=${board.bno}">
										<c:out value="${board.title }"/>
									</a>									
								</td>
								<td><c:out value="${board.memberId }"/></td>
								<td><fmt:formatDate value="${board.regDate}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
								<td><c:out value="${board.hitNo }"/></td>
								
								<td><c:out value="${board.replyGroup }"/></td>
								<td><c:out value="${board.replyOrder }"/></td>
								<td><c:out value="${board.replyIndent }"/></td>
							</tr>		
						</c:forEach>
					</tbody>
				</table>
			</c:if>
			 	<p align="center">${page_navigator}</p>
    				<div class="button-container">
    	    <br>
        <a href="<c:url value='/boardInsertForm.jsp'/>">
            <button type="button" id="button">게시물 작성</button>
        </a>
        <a href="${contextPath }/index.jsp">
            <button type="button" id="button">메인 페이지로 이동</button>
        </a>
    </div>
		</main>
	
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
</body>
</html>	
