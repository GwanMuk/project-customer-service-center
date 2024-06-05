<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>member Update</title>
<link rel="stylesheet" href="/resources/css/member/update.css">

<script src="https://code.jquery.com/jquery-3.4.1.js"
	integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
	crossorigin="anonymous"></script>

<script
	src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

</head>
<body>
	<%@ include file="/WEB-INF/views/includes/header.jsp"%>
	<div class="content_area">
		<%@ include file="/WEB-INF/views/includes/leftmenu.jsp"%>


		<div class="edit_area">

			<h2>회원정보 수정</h2>
			<div class="wrapper">
				<form id="join_form" method="post" action="/member/update">
					<div class="form-group">
						<label for="memberId">아이디</label> <input type="text" id="memberId"
							name="memberId" readonly="readonly" value="${member.memberId}">
					</div>
					<div class="form-group">
						<label for="memberPw">비밀번호</label> <input type="password"
							id="memberPw" name="memberPw">
					</div>
					<div class="form-group">
						<label for="PwCk">비밀번호 확인</label> <input type="password" id="PwCk"
							name="PwCk"> <span class="pwck_input_re_1"
							style="display: none;">비밀번호가 일치합니다.</span> <span
							class="pwck_input_re_2" style="display: none;">비밀번호가 일치하지
							않습니다.</span>
					</div>
					<div class="form-group">
						<label for="memberName">이름</label> <input type="text"
							id="memberName" name="memberName" readonly="readonly"
							value="${member.memberName}">
					</div>
					<div class="form-group">
						<label for="memberPhone">휴대전화</label> <input type="text"
							id="memberPhone" name="memberPhone" value="${member.memberPhone}">
						<span class="final_phone_ck">휴대전화 번호를 입력해주세요.</span>
					</div>
					<div class="form-group">
						<label for="memberMail">이메일</label> <input type="email"
							id="memberMail" name="memberMail" value="${member.memberMail}">
					</div>
					<div class="form-group ">
						<label for="memberAddr1">우편번호</label> <input type="text"
							id="memberAddr1" name="memberAddr1" readonly="readonly"
							value="${member.memberAddr1}">
						<button type="button" onclick="execution_daum_address()">주소
							찾기</button>
					</div>
					<div class="form-group">
						<input type="text" id="memberAddr2" name="memberAddr2"
							readonly="readonly" value="${member.memberAddr2}">
					</div>
					<div class="form-group">
						<label for="memberAddr3">상세주소</label> <input type="text"
							id="memberAddr3" name="memberAddr3" value="${member.memberAddr3}">
					</div>
					<div class="update_button_wrap">
						<button type="reset">취소하기</button>
						<button type="button" class="update_button">수정완료</button>
					</div>
				</form>
			</div>
		</div>
	</div>

	<%@ include file="/WEB-INF/views/includes/footer.jsp"%>

	<script>
		$(document).ready(
				function() {
					// 회원정보 수정 버튼(회원정보 수정 기능 작동)
					$(".update_button").click(function(event) {
						event.preventDefault();

						var updateData = {
							memberId : $("#memberId").val(),
							memberPw : $("#memberPw").val(),
							memberPhone : $("#memberPhone").val(),
							memberMail : $("#memberMail").val(),
							memberAddr1 : $("#memberAddr1").val(),
							memberAddr2 : $("#memberAddr2").val(),
							memberAddr3 : $("#memberAddr3").val()
						};

						$.ajax({
							type : "POST",
							url : "/member/update",
							contentType : "application/json",
							data : JSON.stringify(updateData),
							success : function(response) {
								alert("회원 정보가 성공적으로 수정되었습니다.");
								window.location.href = "/main"; // 성공 시 메인 페이지로 이동
							},
							error : function(xhr, status, error) {
								alert("회원 정보 수정 중 오류가 발생했습니다.");
							}
						});
					});

					// 비밀번호 확인 일치 유효성 검사
					$('#PwCk').on("propertychange change keyup paste input",
							function() {
								var pw = $('#memberPw').val();
								var pwck = $('#PwCk').val();
								if (pw === pwck) {
									$('.pwck_input_re_1').show();
									$('.pwck_input_re_2').hide();
								} else {
									$('.pwck_input_re_1').hide();
									$('.pwck_input_re_2').show();
								}
							});
				});

		// 다음 주소 연동
		function execution_daum_address() {
			new daum.Postcode(
					{
						oncomplete : function(data) {
							var addr = '';
							var extraAddr = '';

							if (data.userSelectedType === 'R') {
								addr = data.roadAddress;
							} else {
								addr = data.jibunAddress;
							}

							if (data.userSelectedType === 'R') {
								if (data.bname !== ''
										&& /[동|로|가]$/g.test(data.bname)) {
									extraAddr += data.bname;
								}
								if (data.buildingName !== ''
										&& data.apartment === 'Y') {
									extraAddr += (extraAddr !== '' ? ', '
											+ data.buildingName
											: data.buildingName);
								}
								if (extraAddr !== '') {
									extraAddr = ' (' + extraAddr + ')';
								}
								addr += extraAddr;
							} else {
								addr += ' ';
							}

							$("#memberAddr1").val(data.zonecode);
							$("#memberAddr2").val(addr);
							$("#memberAddr3").attr("readonly", false).focus();
						}
					}).open();
		}
	</script>
</body>
</html>
