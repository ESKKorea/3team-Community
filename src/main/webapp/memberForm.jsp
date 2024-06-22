<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.sql.*, java.util.*, com.javalab.vo.*" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>펫월드</title>
        <link rel="icon" href="favicon.ico" type="image/x-icon">
    
    <meta name="keywords" content="Petworld site">
    <meta name="description" content="Petworld site">
    <meta name="robots" content="index, follow">


    <!-- favicon -->
    <link rel="icon" type="image/png" sizes="16x16" href="images/favicon.ico">


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

<body class="text-center">
	
    <!-- MAIN -->
    <main class="form-register">
        <div class="reg_info container">
        
             <form id="regForm" action="<c:url value='/member'/>" method="post">

                <!-- <img class="mb-4" src="/docs/5.2/assets/brand/bootstrap-logo.svg" alt="" width="72" height="57"> -->
                <h1 class="h3 mb-3 fw-normal mb-5 green_font">회원가입</h1>

                <div class="row g-3 align-items-center mb-4">
                    <div class="col-lg-2 col-md-2 col-sm-4 label_wrap">
                        <label for="memberId" class="col-form-label">아이디 <span class="green_font">*</span></label>
                    </div>
                    <div class="col-lg-2 col-md-10 col-sm-8">
                        <input type="text" id="memberId" name="memberId" class="form-control" aria-describedby="idHelpInline">
                                                
                    </div>
                    <div class="col-auto">
                        <span id="idHelpInline" class="form-text">
                            (영문 소문자/숫자, 4~16자)
                        </span>
                    </div>
                </div>

                <div class="row g-3 align-items-center mb-4">
                    <div class="col-lg-2 col-md-2 col-sm-4 label_wrap">
                        <label for="password" class="col-form-label">비밀번호 <span class="green_font">*</span></label>
                    </div>
                    <div class="col-lg-2 col-md-10 col-sm-8">
                        <input type="password" id="password" name="password" class="form-control"
                            aria-describedby="passwordHelpInline">
                   
                            
                    </div>
                    <div class="col-auto">
                        <span id="passwordHelpInline" class="form-text">
                            (영문 대소문자/숫자/특수문자 중 2가지 이상 조합, 10~16자)
                        </span>
                    </div>
                </div>

                <div class="row g-3 align-items-center mb-4">
                    <div class="col-lg-2 col-md-2 col-sm-4 label_wrap">
                        <label for="password" class="col-form-label">비밀번호 확인 <span
                                class="green_font">*</span></label>
                    </div>
                    <div class="col-lg-2 col-md-10 col-sm-8">
                        <input type="password" id="password" name="password" class="form-control"
                            aria-describedby="passwordHelpInline">
                    </div>
                </div>

                <div class="row g-3 align-items-center mb-4">
                    <div class="col-lg-2 col-md-2 col-sm-4 label_wrap">
                        <label for="name" class="col-form-label">이름 <span class="green_font">*</span></label>
                    </div>
                    <div class="col-lg-2 col-md-10 col-sm-8">
                        <input type="text" name="name" id="name" class="form-control" aria-describedby="nameHelpInline">
                    </div>
                </div>

                <div class="row g-3 align-items-center mb-4 phone_input">
                    <div class="col-lg-2 col-md-2 col-sm-4 label_wrap">
                        <label for="phone" class="col-form-label">휴대전화</label>
                    </div>
                    <div class="col-lg-2 col-md-10 col-sm-8">
                        <input type="text" name="phone" id="phone" class="form-control">
                    </div>
                </div>

                <div class="row g-3 align-items-center mb-4">
                    <div class="col-lg-2 col-md-2 col-sm-4 label_wrap">
                        <label for="email" class="col-form-label">이메일 <span class="green_font">*</span></label>
                    </div>
                    <div class="col-lg-2 col-md-10 col-sm-8">
                        <input type="email" name="email" id="email" class="form-control" aria-describedby="mailHelpInline">
                        
                    </div>
                     
                  <input type="submit" id="btnSubmit" value="전송">
                  
                </div>
            </form>
            <script>
        // form 태그 submit 이벤트 핸들러 설정
        // id속성이 regForm요소에 이벤트 핸들러 설정
        const form = document.getElementById("regForm5"); 
        form.addEventListener("submit", function(event) { // 이벤트의 종류는 "submit"
            event.preventDefault();   // 폼 submit 방지
         // 각 입력 요소들의 참조 주소값을 변수에 할당
         // getElementById("id") : 메소드 자체가 id 속성으로 찾기 때문에 ("#id")와 같이 사용 안함. 
            const idInput = document.getElementById("id");
            const pwdInput = document.getElementById("password");
            const pwdConfirmInput = document.getElementById("pwdConfirm");
            const nameInput = document.getElementById("name");
            const phoneInput = document.getElementById("phone");
            const emailInput = document.getElementById("email");
         // 입력 요소들의 값을 추출(trim 함수로 값 좌우측 공백 제거)
            const id = idInput.value.trim();
            const pwd = pwdInput.value.trim();
            const pwdConfirm = pwdConfirmInput.value.trim();
            const name = nameInput.value.trim();
            const phone = phoneInput.value.trim();
            const email = emailInput.value.trim();

            //// 정규표현식
            // 아이디는 첫 글자는 영문자, 나머지는 영문자 또는 숫자로 5자리에서 8자리까지
            const regExpId = /^[a-zA-Z][a-zA-Z0-9]{4,7}$/;
            // 이름이 반드시 한글로 시작하고, 2자 이상 5자 이하의 길이
            const regExpName = /^[가-힣]{2,5}$/;
            // 비밀번호는 특수문자와 영어 대문자, 소문자, 숫자를 모두 포함해야 하면 전체 자릿수는 5자리에서 8자리까지
            const regExppwd = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*])[a-zA-Z\d!@#$%^&*]{5,8}$/;
            // 휴대폰 연락처
            const regExpPhone = /^\d{3}-\d{3,4}-\d{4}$/;
            // 이메일 정규식
            const regExpEmail = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;

            // 아이디 검증
            if (id === '') {
                alert('아이디를 입력하세요.');
                idInput.focus();
                return;
            }
            if (!regExpId.test(id)) {
                alert("아이디는 영문자로 시작하고 5자리에서 8자리로 입력하세요");
                idInput.focus();
                return;
            }
            // 비밀번호 검증
            if (pwd === '') {
                alert('비밀번호를 입력하세요.');
                pwdInput.focus();
                return;
            }
            if (!regExppwd.test(pwd)) {
                alert("비밀번호는 영문 대소문자와 숫자, 특수문자가 포함 5자리에서 8자리까지 입력하세요.");
                pwdInput.focus();
                return;
            }
            if (pwd !== pwdConfirm) {
                alert('비밀번호와 비밀번호 확인이 일치하지 않습니다.');
                pwdConfirmInput.focus();
                return;
            }
            
            // 이름 검증
            if (name === '') {
                alert('이름을 입력하세요.');
                nameInput.focus();
                return;
            }
            if (!regExpName.test(name)) {
                alert("이름은 한글 2자 이상 5자 이하로 입력하세요.");
                nameInput.focus();
                return;
            }

            // 연락처 검증
            if (phone === '') {
                alert("연락처를 입력해주세요");
                phoneInput.focus();
                return;
            }
            if (!regExpPhone.test(콜)) {
                alert("연락처를 확인해주세요");
                phoneInput.focus();
                return;
            }

            // 이메일 검증
            if (!regExpEmail.test(email)) {
                alert("이메일을 확인해주세요");
                emailInput.focus();
                return;
            }

            // 모든 검증이 끝난 경우 폼 제출
            form.submit();
        });
    </script>  
        </div>

   

            </form>
        </div>

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
    <footer class="container mt-5">
        <div class="row row-cols-1 row-cols-md-3 mb-3 text-center">
            <div class="col">
                <div class="card mb-4">
                    <div class="py-3 info_bg">
                        <h4 class="my-0">C/S</h4>
                    </div>
                    <div class="card-body mt-3">
                        <p class="green_font">1588-1248</p>
                        <ul class="list-unstyled mt-3 mb-4">
                            <li>AM 10:00 ~ PM 05:00 Off-time PM 12:00 ~ PM 02:00</li>
                            <li>DAY OFF (SATERDAY, SUNDAY, HOLYDAY)</li>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="col">
                <div class="card mb-4">
                    <div class="py-3 info_bg">
                        <h4 class="my-0">COMPANY</h4>
                    </div>
                    <div class="card-body">
                        <ul class="list-unstyled mt-2 mb-4 company_info">
                            <li class="txt_inline">상호 <span>(주)펫월드</span></li>
                            <li class="txt_inline">대표 <span>김대표</span></li>
                            <li>사업자등록번호 <span>[123-45-6789]</span></li>
                            <li>통신판매업신고 <span>제 2022-00000-1234호</span><span>[사업자정보확인]</span></li>
                            <li>팩스 <span>070-1234-1234</span></li>
                            <li>주소 <span>12345 인천광역시 부평구 갈산동 94</span></li>
                            <li>개인정보관리책임자 <span>김개인</span>(<span>dayday@day.com</span>)</li>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="col">
                <div class="card mb-4">
                    <div class="py-3 info_bg">
                        <h4 class="my-0">BANK</h4>
                    </div>
                    <div class="card-body">
                        <ul class="list-unstyled mt-4 mb-4">
                            <li class="mb-2">기업 <span>123456-12-123456</span></li>
                            <li class="mb-2">국민 <span>123456-12-123456</span></li>
                            <li>예금주 <span>(주)펫월드</span></li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
        <!-- <p class="float-end"><a href="#">Back to top</a></p>
    <p>&copy; 2017–2023 Company, Inc. &middot; <a href="#">Privacy</a> &middot; <a href="#">Terms</a></p> -->
    </footer>
    <!-- /FOOTER -->
</body>
<script>
    /* 체크박스 전부 */
    var $agreeAll = $('#all-address');
    $agreeAll.change(function () {
        var $this = $(this);
        var checked = $this.prop('checked'); // checked 문자열 참조(true, false)
        // console.log(checked);

        $('input[name="agree_chk"]').prop('checked', checked);
    });
</script>

</html>