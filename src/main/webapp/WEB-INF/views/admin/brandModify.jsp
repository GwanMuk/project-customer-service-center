<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../resources/css/admin/brandModify.css">

<script
  src="https://code.jquery.com/jquery-3.4.1.js"
  integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
  crossorigin="anonymous"></script>
</head>
<body>
				<%@include file="../includes/admin/header.jsp" %>
                <div class="admin_content_wrap">
                    <div class="admin_content_subject"><span>브랜드 상세</span></div>
                    <div class="admin_content_main">
                    	<form id="modifyForm" action="/admin/brandModify" method="post">
	                   		<div class="form_section">
	                   			<div class="form_section_title">
	                   				<label>브랜드 번호</label>
	                   			</div>
	                   			<div class="form_section_content">
	                   				<input class="input_block" name="brandId" readonly="readonly" value="<c:out value='${brandInfo.brandId }'></c:out>">
	                   			</div>
	                   		</div>                    
	                   		<div class="form_section">
	                   			<div class="form_section_title">
	                   				<label>브랜드 이름</label>
	                   			</div>
	                   			<div class="form_section_content">
	                   				<input name="brandName" value="<c:out value='${brandInfo.brandName }'></c:out>" >
	                   				<span id="warn_brandName">브랜드 이름을 입력 해주세요.</span>
	                   			</div>
	                   		</div>
	                   		
	                   		<div class="form_section">
	                   			<div class="form_section_title">
	                   				<label>브랜드소개</label>
	                   			</div>
	                   			<div class="form_section_content">
	                   				<textarea name="brandIntro" ><c:out value='${brandInfo.brandIntro }'/></textarea>
	                   				<span id="warn_brandIntro">브랜드 소개를 입력 해주세요.</span>
	                   			</div>
	                   		</div>
	                   		<div class="form_section">
	                   			<div class="form_section_title">
	                   				<label>등록 날짜</label>
	                   			</div>
	                   			<div class="form_section_content">
	                   				<input class="input_block" type="text" readonly="readonly" value="<fmt:formatDate value="${brandInfo.regDate}" pattern="yyyy-MM-dd"/>">
	                   			</div>
	                   		</div>
	                   		<div class="form_section">
	                   			<div class="form_section_title">
	                   				<label>수정 날짜</label>
	                   			</div>
	                   			<div class="form_section_content">
	                   				<input class="input_block" type="text" readonly="readonly" value="<fmt:formatDate value="${brandInfo.updateDate}" pattern="yyyy-MM-dd"/>">
	                   			</div>
	                   		</div>
	                 		<div class="btn_section">
	                   			<button id="cancelBtn" class="btn">취 소</button>
		                    	<button id="modifyBtn" class="btn modify_btn">수 정</button>
		                    	<button id="deleteBtn" class="btn delete_btn">삭 제</button>
		                    	
		                    </div> 
	                    </form>
                    </div>                    
                </div>
                
                <form id="moveForm" method="get">
                	<input type="hidden" name="brandId" value='<c:out value="${brandInfo.brandId }"/>'>
                	<input type="hidden" name="pageNum" value='<c:out value="${cri.pageNum }"/>'>
                	<input type="hidden" name="amount" value='<c:out value="${cri.amount }"/>' >
                	<input type="hidden" name="keyword" value='<c:out value="${cri.keyword }"/>'>
                </form>
				<%@include file="../includes/admin/footer.jsp" %>
				
<script>
let moveForm = $("#moveForm");
	let modifyForm = $("#modifyForm");
	



	/* 브랜드 상세 페이지 이동 버튼 */
	$("#cancelBtn").on("click", function(e){
		
		e.preventDefault();
				
		moveForm.attr("action", "/admin/brandDetail")
		moveForm.submit();
		
	});
	
	/* 브랜드 수정 버튼 작동 및 유효성 검사 */
	$("#modifyBtn").on("click", function(e){

		let brandName = $(".form_section_content input[name='brandName']").val();
		let brandIntro = $(".form_section_content textarea").val();		
		let	nameCk = false;
		let introCk = false;		
		
		e.preventDefault();
		
		if(!brandName){
			$("#warn_brandName").css("display", "block");
		} else {
			$("#warn_brandName").css("display", "none");
			nameCk = true;
		}
		if(!brandIntro){
			$("#warn_brandIntro").css("display", "block");
		} else {
			$("#warn_brandIntro").css("display", "none");
			introCk = true;
		}

		
		if(nameCk && introCk ){
			modifyForm.submit();	
		} else {
			return false;
		}
		
		
	});
	
	/* 삭제 버튼 */
	$("#deleteBtn").on("click", function(e){
		e.preventDefault();
		moveForm.find("input").remove();
		moveForm.append('<input type="hidden" name="brandId" value="${brandInfo.brandId}">');
		moveForm.attr("action", "/admin/brandDelete");
		moveForm.attr("method", "post");
		moveForm.submit();
	});
	
	
</script>

</body>
</html>