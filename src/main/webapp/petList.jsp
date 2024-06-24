<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.*, com.javalab.vo.*" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="now" value="<%= new java.util.Date() %>" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>유기견/유기묘 리스트</title>
<link rel="stylesheet" type="text/css" href="<c:url value='/css/board.css' />?v=${now}" />
</head>
<body>
   <div class="container">
		<jsp:include page="/common/header.jsp" />
        <main>
        	<h3>유기견/유기묘 리스트</h3>
        	
        	<form action="<c:url value='/petList'/>" method="get" class="search-form" >
        		<input type="text" name="keyword" placeholder="검색어 입력" />
        		<input type="submit" value="검색" />
        	</form>
        	
        	<c:if test="${empty petList}">
                <p>유기견/유기묘 정보가 존재하지 않습니다.</p>
            </c:if>
            
            <c:if test="${not empty petList}">
				<table border="1">
					<caption>유기견/유기묘 정보 목록</caption>
					<colgroup>
						<col width="100" />
						<col width="500" />
						<col width="100" />
						<col width="200" />
					</colgroup>
					<thead>
						<tr>
							<th>번호</th>
							<th>이름</th>
							<th>나이</th>
							<th>설명</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="pet" items="${petList}" varStatus="idx">
							<tr>
								<td><c:out value="${idx.count}" /></td>
								<td>
									<a href="<c:url value='/petDetail'/>?id=${pet.bno}">
										<c:out value="${pet.name}" />
									</a>
								</td>
								<td><c:out value="${pet.age}" /></td>
								<td><c:out value="${pet.description}" /></td>
							</tr>		
						</c:forEach>
					</tbody>
					<tfoot>
						<tr>
							<td align="center" colspan="4">${page_navigator}</td>
						</tr>
					</tfoot>
				</table>
			</c:if>
			
			<br>
			<a href="<c:url value='/petInsertForm.jsp'/>">유기견/유기묘 등록</a>
			 <a 	href="<c:url value='/index.jsp' />">메인 페이지로 이동</a>
		</main>
	</div>		
</body>
</html>
