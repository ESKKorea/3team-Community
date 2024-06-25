<%@ page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.sql.*, java.util.*, com.javalab.vo.*, com.javalab.dao.*"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<%-- 현재 시간의 시분초를 now 변수에 세팅 --%>
<c:set var="now" value="<%= new java.util.Date() %>" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>boardDetail.jsp</title>
<link rel="stylesheet" type="text/css"
	href="<c:url value='/css/boardDetail.css' />" />
<style>
/* 이전 글 링크 스타일 */

.button {
    display: inline-block;
    padding: 10px 20px;
    background-color: #007bff;
    color: white;
    text-decoration: none;
    border: 2px solid transparent;
    border-radius: 5px;
    transition: all 0.3s ease;
    cursor: pointer; /* 추가된 속성: 마우스 포인터를 가리키면 커서를 변경합니다. */
}

.button:hover {
    background-color: #0056b3;
    border-color: #0056b3; /* 버튼에 호버 효과가 적용될 때 테두리 색상을 변경합니다. */
}

.button:active {
    background-color: #004aad;
    border-color: #004aad; /* 버튼을 클릭했을 때 테두리 색상을 변경합니다. */
}
   .delete-button {
        display: inline-block;
        padding: 10px 20px;
        background-color: #dc3545;
        color: white;
        text-decoration: none;
        border: 2px solid transparent;
        border-radius: 5px;
        transition: background-color 0.3s ease, transform 0.2s ease;
        cursor: pointer;
        font-size: 16px;
    }




    .delete-button:hover {
        background-color: #c82333;
        border-color: #c82333;
    }

    .delete-button:active {
        background-color: #bd2130;
        border-color: #bd2130;
        transform: scale(0.95); /* 클릭 시 크기를 조금 줄임 */
    }
</style>
</head>
<body>
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
	<div class="container">
		<main>
			<!-- 게시물 내용 표시 -->
			<table>
				<tr>
					<th>게시물번호</th>
					<td><c:out value="${boardVO.bno }" /></td>
				</tr>
				<tr>
					<th>제목</th>
					<td><c:out value="${boardVO.title }" /></td>
				</tr>
				<tr>
					<th>내용</th>
					<td>${boardVO.content }</td>
				</tr>
				<tr>
					<th>작성자</th>
					<td><c:out value="${boardVO.memberId }" /></td>
				</tr>
				<tr>
					<th>작성일자</th>
					<td><fmt:formatDate value="${boardVO.regDate}"
							pattern="yyyy-MM-dd HH:mm:ss" /></td>
				</tr>
				<tr>
					<th>조회수</th>
					<td><c:out value="${boardVO.hitNo }" /></td>
				</tr>
			</table>
			<br>
			<div class="actions">
				<a href="<c:url value='/boardList'/>" class="button">목록</a> <a
					href="<c:url value='/boardUpdate'/>?bno=${boardVO.bno}"
					class="button">수정</a>
				<form action="<c:url value='/boardDelete'/>" method="post"
					style="display: inline;">
					<input type="hidden" name="bno" value="${boardVO.bno}">

					<button type="submit" class="delete-button" onclick="return confirm('정말 삭제하시겠습니까?');">삭제</button>

					

				</form>
				<a href="<c:url value='/reply'/>?bno=${boardVO.bno}" class="button">답글작성</a>
			</div>

			<!-- 댓글 섹션 -->
			<div class="comments-section">
				<h3>댓글 작성</h3>
				<form class="comment-form" action="<c:url value='/comment' />"
					method="post">
					<input type="hidden" name="boardId" value="${boardVO.bno}">
					<textarea name="content" required></textarea>
					<button type="submit">댓글 작성</button>
				</form>

				<h3>댓글 목록</h3>
				<c:forEach var="comment" items="${comments}">
					<div class="comment">
						<div class="comment-author">${comment.memberId}</div>
						<div class="comment-date">
							<fmt:formatDate value="${comment.regDate}"
								pattern="yyyy-MM-dd HH:mm:ss" />
						</div>
						<div class="comment-content">${comment.content}</div>
						<div class="comment-actions">
							<a
								href="<c:url value='/comment?action=delete&id=${comment.id}&boardId=${boardVO.bno}' />">삭제</a>
						</div>
					</div>
				</c:forEach>
				<!-- 이전글과 다음글 섹션 -->
			</div>
		</main>
	</div>
				<div class="prev-next-section">
					<c:if test="${not empty previousBoard}">
						<div class="previous">
							<h3>이전글</h3>
							<p>번호: ${previousBoard.bno}, 제목: ${previousBoard.title}</p>
							<a href="<c:url value='/boardDetail'/>?bno=${previousBoard.bno}" class="button">이전 글</a>
						</div>
					</c:if>

					<c:if test="${not empty nextBoard}">
						<div class="next">
							<h3>다음글</h3>
							<p>번호: ${nextBoard.bno}, 제목: ${nextBoard.title}</p>
							<a href="<c:url value='/boardDetail'/>?bno=${nextBoard.bno}" class="button">다음 글</a>
						</div>
					</c:if>
				</div>
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