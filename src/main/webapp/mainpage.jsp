<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>3Team</title>
	<title>Visualize by TEMPLATED</title>
	    <link rel="icon" href="favicon.ico" type="image/x-icon">
	
	<meta charset="utf-8">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.9.0/css/all.min.css" integrity="sha512-q3eWabyZPc1XTCmF+8/LuE1ozpg5xxn7iO89yfSOd5/oKvyqLngoNGsx8jq92Y8eXJ/IRxQbEC+FGSYxtk2oiw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/3team.css' />" />
</head>
<body>
	<div id="wrapper">
		<header id="header">
			<nav class="header-nav">
				<a href="#"><i class="fas fa-users"></i><span class="label">커뮤니티</span></a>
				<a href="${contextPath}/login"><i class="fas fa-sign-in-alt"></i><span class="label">로그인</span></a>
				<a href="#"><i class="fas fa-home"></i><span class="label">홈</span></a>
			</nav>
			
			<div class="search-box">
				<input type="text" placeholder="검색어를 입력하세요">
				<button><i class="fas fa-search"></i></button>
			</div>
		</header>
		
		<section class="thumbnails">
			<div class="grid-container">
				<div class="layout-1">
					<a href="#">
						<img src="image/cat2.jpg" alt="">
						<h3>미치겠다</h3>
					</a>
					<a href="#">
						<img src="image/cat4.jpg" alt="">
						<h3>아</h3>
					</a>
					<a href="#">
						<img src="image/cat6.jpg" alt="">
						<h3>아 졸려</h3>
					</a>
					<a href="#">
						<img src="image/cat9.jpg" alt="">
						<h3>망한듯;;</h3>
					</a>
				</div>
				<div class="layout-2">
					<a href="#">
						<img src="image/cat3.jpg" alt="">
						<h3>이게맞을까?</h3>
					</a>
					<a href="#">
						<img src="image/cat5.jpg" alt="">
						<h3>존</h3>
					</a>
					<a href="#">
						<img src="image/cat7.jpg" alt="">
						<h3>려</h3>
					</a>
					<a href="#">
						<img src="image/cat8.jpg" alt="">
						<h3>워</h3>
					</a>
				</div>
			</div>
		</section>
	</div>
	<footer id="footer">
		<nav>
			<ul>
				<li><a href="#">회사소개</a></li>
				<li><a href="#">제휴제안</a></li>
				<li><a href="#">이용약관</a></li>
				<li><a href="#">개인정보처리방침</a></li>
				<li><a href="#">크리에이터 신청</a></li>
			</ul>
		</nav>
		<div class="social-icons">
			<a href="#" class="icon-instagram"><i class="fab fa-instagram"></i><span class="label">Instagram</span></a>
    		<a href="#" class="icon-facebook"><i class="fab fa-facebook"></i><span class="label">Facebook</span></a>
   		 	<a href="#" class="icon-twitter"><i class="fab fa-twitter"></i><span class="label">Twitter</span></a>
    		<a href="#" class="icon-youtube"><i class="fab fa-youtube"></i><span class="label">YouTube</span></a>
		</div>
		</footer>
</body>
</html>