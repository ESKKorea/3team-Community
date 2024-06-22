<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.sql.*, java.util.*, com.javalab.vo.*"%>

<c:set var="now" value="<%=new java.util.Date()%>" />

<!-- 컨텍스트패스(진입점폴더) 변수설정 -->
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>03_loginForm.jsp</title>
<link rel="stylesheet" type="text/css"
	href="<c:url value='/css/board.css'/>?v=${now}" />
	 <script src="http://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script src="assets/js/style.js"></script>
    <!-- JavaScript Bundle with Popper -->
    <!-- <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script> -->

    <!-- Swiper -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.1/css/swiper.min.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.1/js/swiper.min.js"></script>



    <!-- bootstrap -->
    <!-- CSS only -->
    <link rel="stylesheet" href="assets/css/style.css">
    <link rel="stylesheet" href="assets/fonts/gmarket.css">
    <link rel="stylesheet" href="assets/fonts/junegull.css">

    <link href="assets/css/bootstrap.css" rel="stylesheet">
</head>
<body style="margin-top: 5rem;"> <!-- Adding 5rem top margin directly to the body -->
    <div class="container">
        
        <main class="form-signin w-300 m-auto">
            <form action="<c:url value='/login' />" method="post">
                <h1 class="h3 mb-3 fw-normal">회원 로그인</h1>

                <div class="form-floating mb-2">
                    <input type="text" class="form-control" id="memberId" name="memberId" required>
                    <label for="memberId">아이디</label>
                </div>

                <div class="form-floating mb-3">
                    <input type="password" class="form-control" id="password" name="password" required>
                    <label for="password">비밀번호</label>
                </div>

                <div class="userInfo_wrap row mt-4 mb-4">
                    <div class="find_wrap col-12 text-end">
                        <a href="find_id.html">아이디 찾기</a>
                        <a href="find_pw.html">비밀번호 찾기</a>
                    </div>
                </div>

                <button class="w-100 btn btn-lg btn-green mb-2" type="submit" style=";">로그인</button> <!-- Setting width to 500px -->
                <a href="<c:url value='/member'/>" class="w-100 btn btn-lg btn-line-green">회원가입</a>

                <div class="sns_login row mt-4">
                    <div class="col-8">
                        <p>SNS 간편로그인</p>
                        <span>간편하게 로그인하실 수 있습니다.</span>
                    </div>
                    <div class="col-4" style="padding: 0;">
                        <div class="row">
                            <div class="col-4 sns_wrap"><a href=""><img src="assets/img/google_ico.png" style="width: 100%;"></a></div>
                            <div class="col-4 sns_wrap"><a href=""><img src="assets/img/naver_ico.png" style="width: 100%;"></a></div>
                            <div class="col-4 sns_wrap"><a href=""><img src="assets/img/facebook_ico.png" style="width: 100%;"></a></div>
                        </div>
                    </div>
                </div>
            </form>

            <!-- 오류 메시지 출력 -->
            <c:if test="${not empty error}">
                <span style="color: red;">${error}</span>
            </c:if>
        
        </main>
        <!-- /MAIN -->

        <!-- FOOTER -->
        <div class="foot_top_menu">
            <div class="container">
                <a href="privacy.html">개인정보 처리방침</a>
                <a href="provision.html">이용약관</a>
                <a href="guide.html">이용안내</a>
                <a href="notice.html">공지사항</a>
            </div>
        </div>

    </div>
</body>
</html>

</html>

