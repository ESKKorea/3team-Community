<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>3Team</title>
<title>Visualize by TEMPLATED</title>
<meta charset="utf-8">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.9.0/css/all.min.css" integrity="sha512-q3eWabyZPc1XTCmF+8/LuE1ozpg5xxn7iO89yfSOd5/oKvyqLngoNGsx8jq92Y8eXJ/IRxQbEC+FGSYxtk2oiw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="./css/p.css">
</head>
<body>
	 <div class="nav">
        <div class="logo">
            <img src="./image/logo.png" alt="">
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
    <section class="header">
        <div class="title">
            <img src="./image/logomain.jpg" alt="Main Logo">
            <h1>Cat Board</h1>
            <p>환영합니다!!</p>
             <a href="" class="button-link">동물 보러가기</a>
        </div>
    </section>
    <section class="intro">
        <div class="card">
            <i class="fas fa-chalkboard"></i>
            <h1>게시물</h1>
            <p>커뮤니티 내의 다양한 주제와 토론을 다루는 다양한 게시물을 살펴보세요.</p> 
            <p>Explore our diverse range of posts covering various topics and discussions within the community.</p>
        </div>
        <div class="card">
            <i class="fas fa-handshake"></i>
            <h1>연맹</h1>
               <p> 회원들이 협력 활동에 참여하고 전문 지식을 공유하는 제휴에 가입함으로써 얻을 수 있는 이점을 알아보세요.</p> 
               <p> Discover the benefits of joining our alliance, where members engage in collaborative activities and share expertise.</p>
        </div>
        <div class="card">
            <i class="fas fa-hand-holding-heart"></i>
            <h1>마음</h1>
            <p>고양이에 대한 사랑과 연민을 전파하고 모두를 위한 지원 환경을 조성하기 위해 헌신하는 배려심 깊은 커뮤니티에 참여하세요.</p>
            <p>Join our caring community dedicated to spreading love and compassion for cats, creating a supportive environment for all.</p>
        </div>
    </section>
    <section class="service">
        <div class="container">
            <div class="img">
                <img src="./image/cat.png" alt="">
            </div>
            <div class="text">
                <h1>소개글</h1>
                <p>고양이들은 음악과 같아요.고양이들을 인정하지 않는 사람들에게 고양이의 가치를 설명하려고 노력하는 것은 정말로 어리석은 짓입니다
                    "Cats are like Music. It's foolish to try to explain their worth to those who    don't appreciate them.</p>
                <button>more..</button>
            </div>
        </div>
    </section>
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
                    <h2>
                        Popular Posts</h2>
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