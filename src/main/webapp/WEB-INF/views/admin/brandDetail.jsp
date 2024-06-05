<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>브랜드 상세</title>
<link rel="stylesheet" href="../resources/css/admin/brandDetail.css">
<script src="https://code.jquery.com/jquery-3.4.1.js" integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU=" crossorigin="anonymous"></script>
</head>
<body>
<%@include file="../includes/header.jsp" %>
<div class="admin_content_wrap">
    <div class="admin_content_subject">
        <span>브랜드 상세</span>
    </div>
    <div class="admin_content_main">
    
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
                <input class="input_block" name="brandName" readonly="readonly" value="<c:out value='${brandInfo.brandName }'></c:out>" >
            </div>
        </div>
        
        <div class="form_section">
            <div class="form_section_title">
                <label>브랜드소개</label>
            </div>
            <div class="form_section_content">
                <textarea class="input_block" name="brandIntro" readonly="readonly"><c:out value='${brandInfo.brandIntro }'/></textarea>
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
            <button id="cancelBtn" class="btn">브랜드 목록</button>
            <button id="modifyBtn" class="btn modify_btn">수정</button>
        </div> 
    </div>                    
</div>

<form id="moveForm" method="get">
    <input type="hidden" name="brandId" value='<c:out value="${brandInfo.brandId }"/>'>
    <input type="hidden" name="pageNum" value='<c:out value="${cri.pageNum }"/>'>
    <input type="hidden" name="amount" value='<c:out value="${cri.amount }"/>' >
    <input type="hidden" name="keyword" value='<c:out value="${cri.keyword }"/>'>
</form>

<%@include file="../includes/footer.jsp" %>

<script>
    let moveForm = $("#moveForm");

    /* 브랜드 상세 페이지 이동 버튼 */
    $("#cancelBtn").on("click", function(e){
        e.preventDefault();       
        moveForm.attr("action", "/admin/brandManage")
        moveForm.submit();  
    });

    /* 브랜드 수정 페이지로 이동 버튼 */
    $("#modifyBtn").on("click", function(e){
        e.preventDefault();       
        moveForm.attr("action", "/admin/brandModify") 
        moveForm.submit();  
    });
</script>


</body>
</html>
