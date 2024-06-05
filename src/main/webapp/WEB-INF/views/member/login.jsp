<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.4.1.js" integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU=" crossorigin="anonymous"></script>
<link rel="stylesheet" href="/resources/css/member/login.css">
</head>
<body>
<%@ include file="/WEB-INF/views/includes/header.jsp" %>
<div class="wrapper">
    <div class="wrap">
        <form id="login_form" method="post">
            <div class="logo_wrap">
                <span>Unknown</span>
            </div>
            <div class="login_wrap">
                <div class="id_wrap">
                    <div class="id_input_box">
                        <input class="id_input" name="memberId">
                    </div>
                </div>
                <div class="pw_wrap">
                    <div class="pw_input_box">
                        <input class="pw_input" name="memberPw" type="password">
                    </div>
                </div>
                <div class="options_wrap">
                    <input type="checkbox" id="auto_login" name="auto_login">
                    <label for="auto_login">자동로그인</label>
                    <input type="checkbox" id="save_id" name="save_id">
                    <label for="save_id">아이디저장</label>
                </div>
                <c:if test="${result == 0}">
                    <div class="login_warn">사용자 ID 또는 비밀번호를 잘못 입력하셨습니다.</div>
                </c:if>
                <div class="login_button_wrap">
                    <input type="button" class="login_button" value="로그인">
                </div>
                <div class="links_wrap">
                    <a href="#">아이디 찾기</a> | <a href="#">비밀번호 찾기</a>
                </div>
                <div class="social_login_wrap">
                    <button class="social_login_button" id="naver_login">N</button>
                    <button class="social_login_button" id="apple_login">A</button>
                    <button class="social_login_button" id="kakao_login">K</button>
                </div>
                <div class="simple_signup">
                    <button class="simple_signup_button">간편회원가입</button>
                </div>
                <div class="icons_wrap">
                    <div class="icon_row">
                        <div class="icon">O</div>
                        <div class="icon">O</div>
                        <div class="icon">O</div>
                        <div class="icon">O</div>
                    </div>
                    <div class="icon_row">
                        <div class="icon">O</div>
                        <div class="icon">O</div>
                        <div class="icon">O</div>
                    </div>
                </div>
            </div>
        </form>
    </div>
</div>
<%@ include file="/WEB-INF/views/includes/footer.jsp" %>
<script>
    $(".login_button").click(function(){
        $("#login_form").attr("action", "/member/login.do");
        $("#login_form").submit();
    });
</script>
</body>
</html>
