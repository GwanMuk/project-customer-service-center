<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 상세</title>
<link rel="stylesheet" href="../resources/css/admin/goodsDetail.css">
<script src="https://code.jquery.com/jquery-3.4.1.js"
	integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
	crossorigin="anonymous"></script>
</head>
<body>
	<%@include file="../includes/admin/header.jsp"%>
	<div class="admin_content_wrap">
		<div class="admin_content_subject">
			<span>상품 상세</span>
		</div>

		<div class="admin_content_main">
			<div class="form_section">
				<div class="form_section_title">
					<label>상품명</label>
				</div>
				<div class="form_section_content">
					<input name="itemName"
						value="<c:out value="${goodsInfo.itemName}"/>" disabled>
				</div>
			</div>
			<div class="form_section">
				<div class="form_section_title">
					<label>등록 날짜</label>
				</div>
				<div class="form_section_content">
					<input
						value="<fmt:formatDate value='${goodsInfo.regDate}' pattern='yyyy-MM-dd'/>"
						disabled>
				</div>
			</div>
			<div class="form_section">
				<div class="form_section_title">
					<label>최근 수정 날짜</label>
				</div>
				<div class="form_section_content">
					<input
						value="<fmt:formatDate value='${goodsInfo.updateDate}' pattern='yyyy-MM-dd'/>"
						disabled>
				</div>
			</div>
			<div class="form_section">
				<div class="form_section_title">
					<label>브랜드명</label>
				</div>
				<div class="form_section_content">
					<input id="brandName_input" readonly="readonly"
						value="${goodsInfo.brandName }" disabled>
				</div>
			</div>
			<div class="form_section">
				<div class="form_section_title">
					<label>제조일</label>
				</div>
				<div class="form_section_content">
					<input name="mnfcYear" autocomplete="off" readonly="readonly"
						value="<c:out value="${goodsInfo.mnfcYear}"/>" disabled>
				</div>
			</div>
			<div class="form_section">
				<div class="form_section_title">
					<label>제조사</label>
				</div>
				<div class="form_section_content">
					<input name="manufacturer"
						value="<c:out value="${goodsInfo.manufacturer}"/>" disabled>
				</div>
			</div>
			<div class="form_section">
				<div class="form_section_title">
					<label>상품 카테고리</label>
				</div>
				<div class="form_section_content">
					<div class="cate_wrap">
						<span>대분류</span> <select class="cate1" name="cateCode" disabled>
							<option value="none">선택</option>
						</select>
					</div>
					<div class="cate_wrap">
						<span>소분류</span> <select class="cate2" disabled>
							<option value="none">선택</option>
						</select>
					</div>
				</div>
			</div>
			<div class="form_section">
				<div class="form_section_title">
					<label>상품 가격</label>
				</div>
				<div class="form_section_content">
					<input name="itemPrice"
						value="<c:out value="${goodsInfo.itemPrice}"/>" disabled>
				</div>
			</div>
			<div class="form_section">
				<div class="form_section_title">
					<label>상품 재고</label>
				</div>
				<div class="form_section_content">
					<input name="itemStock"
						value="<c:out value="${goodsInfo.itemStock}"/>" disabled>
				</div>
			</div>
			<div class="form_section">
				<div class="form_section_title">
					<label>상품 할인율</label>
				</div>
				<div class="form_section_content">
					<input id="discount_interface" maxlength="2" disabled>
				</div>
			</div>
			<div class="form_section">
				<div class="form_section_title">
					<label>상품 소개</label>
				</div>
				<div class="form_section_content bit">
					<textarea name="itemIntro" id="itemIntro_textarea" disabled>${goodsInfo.itemIntro}</textarea>
				</div>
			</div>
			<div class="form_section">
				<div class="form_section_title">
					<label>상품 상세 내용</label>
				</div>
				<div class="form_section_content bct">
					<textarea name="itemContents" id="itemContents_textarea" disabled>${goodsInfo.itemContents}</textarea>
				</div>
			</div>

			<div class="form_section">
				<div class="form_section_title">
					<label>상품 이미지</label>
				</div>
				<div class="form_section_content">
					<div id="uploadResult"></div>
				</div>
			</div>

			<div class="btn_section">
				<button id="cancelBtn" class="btn">상품 목록</button>
				<button id="modifyBtn" class="btn enroll_btn">수정</button>
			</div>
		</div>

		<form id="moveForm" action="/admin/goodsManage" method="get">
			<input type="hidden" name="pageNum" value="${cri.pageNum}"> <input
				type="hidden" name="amount" value="${cri.amount}"> <input
				type="hidden" name="keyword" value="${cri.keyword}">
		</form>
	</div>
	<%@include file="../includes/admin/footer.jsp"%>

	<script>
	$(document).ready(function(){
	    /* 이미지 정보 호출 */
	    let itemId = '<c:out value="${goodsInfo.itemId}"/>';
	    let uploadResult = $("#uploadResult"); 
	    
	    $.getJSON("/getAttachList", {itemId: itemId}, function(arr) {
	        if (arr.length === 0) {
	            let str = "<div id='result_card'><img src='/resources/img/goodsNoImage.png'></div>";
	            uploadResult.html(str);
	            return;
	        }
	        
	        let str = "";
	        let obj = arr[0];
	        let fileCallPath = encodeURIComponent(obj.uploadPath + "/t_" + obj.uuid + "_" + obj.fileName);
	        
	        str += "<div id='result_card' data-path='" + obj.uploadPath + "' data-uuid='" + obj.uuid + "' data-filename='" + obj.fileName + "'>";
	        str += "<img src='/display?fileName=" + fileCallPath + "'>";
	        str += "</div>";
	        
	        uploadResult.html(str);
	    });

	    /* 할인율 값 삽입 */
	    let itemDiscount = '<c:out value="${goodsInfo.itemDiscount}"/>' * 100;
	    $("#discount_interface").attr("value", itemDiscount);
	});

	/* 출판일 값 가공 */
	let mnfcYear = '${goodsInfo.mnfcYear}';
	let length = mnfcYear.indexOf(" ");
	mnfcYear = mnfcYear.substring(0, length);
	$("input[name='mnfcYear']").attr("value", mnfcYear);

	/* 카테고리 */
	let cateList = JSON.parse('<c:out value="${cateList}" escapeXml="false"/>');
	let cate1Array = [];
	let cate2Array = [];
	let cateSelect1 = $(".cate1");        
	let cateSelect2 = $(".cate2");

	/* 카테고리 배열 초기화 메서드 */
	function makeCateArray(cateList, tier) {
	    return cateList.filter(cate => cate.tier === tier);
	}

	/* 배열 초기화 */
	cate1Array = makeCateArray(cateList, 1);
	cate2Array = makeCateArray(cateList, 2);

	let targetCate2 = '${goodsInfo.cateCode}';

	for(let i = 0; i < cate1Array.length; i++) {
	    cateSelect1.append("<option value='"+cate1Array[i].cateCode+"'>" + cate1Array[i].cateName + "</option>");
	}

	cateSelect1.on("change", function() {
	    let selectVal1 = $(this).find("option:selected").val();
	    cateSelect2.children().remove();
	    cateSelect2.append("<option value='none'>선택</option>");

	    for (let i = 0; i < cate2Array.length; i++) {
	        if (selectVal1 === cate2Array[i].cateParent) {
	            cateSelect2.append("<option value='" + cate2Array[i].cateCode + "'>" + cate2Array[i].cateName + "</option>");
	        }
	    }

	    $(".cate2 option").each(function(i, obj) {
	        if (targetCate2 === obj.value) {
	            $(obj).attr("selected", "selected");
	        }
	    });
	});

	$(".cate1 option").each(function(i, obj) {
	    if (targetCate2.substr(0, 2) === obj.value.substr(0, 2)) {
	        $(obj).attr("selected", "selected");
	    }
	});

	// 트리거를 통해 초기 값을 설정합니다.
	cateSelect1.trigger("change");

	/* 목록 이동 버튼 */
	$("#cancelBtn").on("click", function(e) {
	    e.preventDefault();
	    $("#moveForm").submit();    
	});    

	/* 수정 페이지 이동 */
	$("#modifyBtn").on("click", function(e) {
	    e.preventDefault();
	    let addInput = '<input type="hidden" name="itemId" value="${goodsInfo.itemId}">';
	    $("#moveForm").append(addInput);
	    $("#moveForm").attr("action", "/admin/goodsModify");
	    $("#moveForm").submit();
	});

    </script>
</body>
</html>
