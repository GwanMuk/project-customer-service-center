<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 등록</title>
<link rel="stylesheet" href="../resources/css/admin/goodsModify.css">
<link rel="stylesheet"
	href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
</head>
<body>

	<%@include file="../includes/admin/header.jsp"%>

	<div class="admin_content_wrap">
		<div class="admin_content_subject">
			<span>상품 등록</span>
		</div>
		<div class="admin_content_main">
			<form action="/admin/goodsModify" method="post" id="modifyForm">
				<div class="form_section">
					<div class="form_section_title">
						<label>상품 제목</label>
					</div>
					<div class="form_section_content">
						<input name="itemName" value="${goodsInfo.itemName}"> <span
							class="ck_warn itemName_warn">상품 이름을 입력해주세요.</span>
					</div>
				</div>
				<div class="form_section">
					<div class="form_section_title">
						<label>브랜드</label>
					</div>
					<div class="form_section_content">
						<input id="brandName_input" readonly="readonly"
							value="${goodsInfo.brandName}"> <input
							id="brandId_input" name="brandId" type="hidden"
							value="${goodsInfo.brandId}">
						<button class="brandId_btn">브랜드 선택</button>
						<span class="ck_warn brandId_warn">브랜드를 선택해주세요</span>
					</div>
				</div>
				<div class="form_section">
					<div class="form_section_title">
						<label>제조일</label>
					</div>
					<div class="form_section_content">
						<input name="mnfcYear" autocomplete="off" readonly="readonly">
						<span class="ck_warn mnfcYear_warn">제조일을 선택해주세요.</span>
					</div>
				</div>
				<div class="form_section">
					<div class="form_section_title">
						<label>제조사</label>
					</div>
					<div class="form_section_content">
						<input name="manufacturer" value="${goodsInfo.manufacturer}"> <span
							class="ck_warn manufacturer_warn">제조사를 입력해주세요.</span>
					</div>
				</div>
				<div class="form_section">
					<div class="form_section_title">
						<label>상품 카테고리</label>
					</div>
					<div class="form_section_content">
						<div class="cate_wrap">
							<span>대분류</span> <select class="cate1" name="cateCode" >
								<option selected value="none">선택</option>
							</select>
						</div>
						<div class="cate_wrap">
							<span>소분류</span> <select class="cate2" name="cateCode">
								<option selected value="none">선택</option>
							</select>
						</div>
						<span class="ck_warn cateCode_warn">카테고리를 선택해주세요.</span>
					</div>
				</div>
				<div class="form_section">
					<div class="form_section_title">
						<label>상품 가격</label>
					</div>
					<div class="form_section_content">
						<input name="itemPrice" value="${goodsInfo.itemPrice}"> <span
							class="ck_warn itemPrice_warn">상품 가격을 입력해주세요.</span>
					</div>
				</div>
				<div class="form_section">
					<div class="form_section_title">
						<label>상품 재고</label>
					</div>
					<div class="form_section_content">
						<input name="itemStock" value="${goodsInfo.itemStock}"> <span
							class="ck_warn itemStock_warn">상품 재고를 입력해주세요.</span>
					</div>
				</div>
				<div class="form_section">
					<div class="form_section_title">
						<label>상품 할인율</label>
					</div>
					<div class="form_section_content">
						<input id="discount_interface" maxlength="2" value="0"> <input
							name="itemDiscount" type="hidden"
							value="${goodsInfo.itemDiscount}"> <span class="step_val">할인
							가격 : <span class="span_discount"></span>
						</span> <span class="ck_warn itemDiscount_warn">1~99 숫자를 입력해주세요.</span>
					</div>
				</div>
				<div class="form_section">
					<div class="form_section_title">
						<label>상품 소개</label>
					</div>
					<div class="form_section_content bit">
						<textarea name="itemIntro" id="itemIntro_textarea">${goodsInfo.itemIntro}</textarea>
						<span class="ck_warn itemIntro_warn">상품 소개를 입력해주세요.</span>
					</div>
				</div>
				<div class="form_section">
					<div class="form_section_title">
						<label>상품 목차</label>
					</div>
					<div class="form_section_content bct">
						<textarea name="itemContents" id="itemContents_textarea">${goodsInfo.itemContents}</textarea>
						<span class="ck_warn itemContents_warn">상품 상세 내용을 입력해주세요.</span>
					</div>
				</div>

				<div class="form_section">
					<div class="form_section_title">
						<label>상품 이미지</label>
					</div>
					<div class="form_section_content">
						<input type="file" id="fileItem" name='uploadFile'
							style="height: 30px;">
						<div id="uploadResult"></div>
					</div>
				</div>


				<input type="hidden" name='itemId' value="${goodsInfo.itemId}">
			</form>
			<div class="btn_section">
				<button id="cancelBtn" class="btn">취 소</button>
				<button id="modifyBtn" class="btn modify_btn">수 정</button>
				<button id="deleteBtn" class="btn delete_btn">삭 제</button>
			</div>
		</div>
		<form id="moveForm" action="/admin/goodsManage" method="get">
			<input type="hidden" name="pageNum" value="${cri.pageNum}"> <input
				type="hidden" name="amount" value="${cri.amount}"> <input
				type="hidden" name="keyword" value="${cri.keyword}"> <input
				type="hidden" name='itemId' value="${goodsInfo.itemId}">
		</form>
	</div>

	<%@include file="../includes/admin/footer.jsp"%>

    <script>
    $(document).ready(function() {
        // 캘린더 설정
        const config = {
            dateFormat: 'yy-mm-dd',
            showOn: "button",
            buttonText: "날짜 선택",
            prevText: '이전 달',
            nextText: '다음 달',
            monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
            monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
            dayNames: ['일','월','화','수','목','금','토'],
            dayNamesShort: ['일','월','화','수','목','금','토'],
            dayNamesMin: ['일','월','화','수','목','금','토'],
            yearSuffix: '년',
            changeMonth: true,
            changeYear: true
        };

        let mnfcYear = '${goodsInfo.mnfcYear}';
        if (mnfcYear !== "") {
            $("input[name='mnfcYear']").datepicker(config).datepicker('setDate', new Date(mnfcYear));
        } else {
            $("input[name='mnfcYear']").datepicker(config);
        }

        // 카테고리 설정
        let cateList = JSON.parse('${cateList}');
        let cate1Array = [];
        let cate2Array = [];

        cate1Array = cateList.filter(function(cate) {
            return cate.tier === 1;
        });

        cate1Array.forEach(function(cate) {
            $(".cate1").append("<option value='"+cate.cateCode+"'>" + cate.cateName + "</option>");
        });

        $(".cate1").on("change", function() {
            let selectedCate1 = $(this).val();
            $(".cate2").empty().append("<option value='none'>선택</option>");
            
            if (selectedCate1 === "1000") { // assuming 1000 is the code for 신상품
                $(".cate2").attr("disabled", true);
                $("input[name='cateCode']").val('1000');
            } else {
                $(".cate2").attr("disabled", false);
                $(".cate2").attr("name", "cateCode");
                $(this).removeAttr("name");

                if (selectedCate1 !== "none") {
                    cate2Array = cateList.filter(function(cate) {
                        return cate.cateParent === selectedCate1 && cate.tier === 2;
                    });

                    if (cate2Array.length > 0) {
                        cate2Array.forEach(function(cate) {
                            $(".cate2").append("<option value='"+cate.cateCode+"'>" + cate.cateName + "</option>");
                        });
                    }
                }
            }
        });

        $(".cate2").on("change", function() {
            let selectedCate2 = $(this).val();
            if (selectedCate2 !== "none") {
                $("input[name='cateCode']").val(selectedCate2);
            } else {
                $("input[name='cateCode']").val($(".cate1").val());
            }
        });

        // 할인율 설정
        let itemPriceInput = $("input[name='itemPrice']");
        let discountInput = $("input[name='itemDiscount']");
        
        let itemPrice = itemPriceInput.val();
        let rawDiscountRate = discountInput.val();
        let discountRate = rawDiscountRate * 100;
        
        let discountPrice = itemPrice * (1-rawDiscountRate);
        $(".span_discount").html(discountPrice);
        $("#discount_interface").val(discountRate);

        // 이미지 업로드 결과 표시
        let itemId = '<c:out value="${goodsInfo.itemId}"/>';
        let uploadResult = $("#uploadResult");
        
        $.getJSON("/getAttachList", { itemId: itemId }, function(arr) {
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
            str += "<div class='imgDeleteBtn' data-file='" + fileCallPath + "'>x</div>";
            str += "<input type='hidden' name='imageList[0].fileName' value='" + obj.fileName + "'>";
            str += "<input type='hidden' name='imageList[0].uuid' value='" + obj.uuid + "'>";
            str += "<input type='hidden' name='imageList[0].uploadPath' value='" + obj.uploadPath + "'>";
            str += "</div>";
            
            uploadResult.html(str);
        });

        // 할인율 변경 이벤트
        $("#discount_interface").on("propertychange change keyup paste input", function() {
            let userInput = $("#discount_interface");
            let discountInput = $("input[name='itemDiscount']");
            
            let discountRate = userInput.val();
            let sendDiscountRate = discountRate / 100;
            let goodsPrice = $("input[name='itemPrice']").val();
            let discountPrice = goodsPrice * (1 - sendDiscountRate);
            
            if (!isNaN(discountRate)) {
                $(".span_discount").html(discountPrice);
                discountInput.val(sendDiscountRate);
            }
        });

        $("input[name='itemPrice']").on("change", function() {
            let userInput = $("#discount_interface");
            let discountInput = $("input[name='itemDiscount']");
            
            let discountRate = userInput.val();
            let sendDiscountRate = discountRate / 100;
            let goodsPrice = $("input[name='itemPrice']").val();
            let discountPrice = goodsPrice * (1 - sendDiscountRate);
            
            if (!isNaN(discountRate)) {
                $(".span_discount").html(discountPrice);
            }
        });

        // 취소 버튼
        $("#cancelBtn").on("click", function(e) {
            e.preventDefault();
            $("#moveForm").submit();
        });

        // 수정 버튼
        $("#modifyBtn").on("click", function(e) {
            e.preventDefault();
            $("#modifyForm").submit();
        });

        $("#deleteBtn").on("click", function(e) {
            e.preventDefault();
            let moveForm = $("#moveForm");
            moveForm.find("input").remove();
            moveForm.append('<input type="hidden" name="itemId" value="${goodsInfo.itemId}">');
            moveForm.attr("action", "/admin/goodsDelete");
            moveForm.attr("method", "post");
            moveForm.submit();
        });

        $("#uploadResult").on("click", ".imgDeleteBtn", function(e) {
            deleteFile();
        });

        function deleteFile() {
            let targetFile = $(".imgDeleteBtn").data("file");
            let targetDiv = $("#result_card");

            $.ajax({
                url: '/admin/deleteFile',
                data: { fileName: targetFile },
                dataType: 'text',
                type: 'POST',
                success: function(result) {
                    targetDiv.remove();
                    $("input[type='file']").val("");
                },
                error: function(result) {
                    alert("파일을 삭제하지 못하였습니다.");
                }
            });
        }

        $("input[type='file']").on("change", function(e) {
            if ($(".imgDeleteBtn").length > 0) {
                deleteFile();
            }

            let formData = new FormData();
            let fileInput = $('input[name="uploadFile"]');
            let fileList = fileInput[0].files;
            let fileObj = fileList[0];

            if (!fileCheck(fileObj.name, fileObj.size)) {
                return false;
            }

            formData.append("uploadFile", fileObj);

            $.ajax({
                url: '/admin/uploadAjaxAction',
                processData: false,
                contentType: false,
                data: formData,
                type: 'POST',
                dataType: 'json',
                success: function(result) {
                    showUploadImage(result);
                },
                error: function(result) {
                    alert("이미지 파일이 아닙니다.");
                }
            });
        });
        

        let regex = new RegExp("(.*?)\.(jpg|png)$");
        let maxSize = 1048576; //1MB

        function fileCheck(fileName, fileSize) {
            let maxSize = 1048576; // 1MB
            let regex = new RegExp("(.*?)\.(jpg|png)$");

            if (fileSize >= maxSize) {
                alert("파일 사이즈 초과");
                return false;
            }

            if (!regex.test(fileName)) {
                alert("해당 종류의 파일은 업로드할 수 없습니다.");
                return false;
            }

            return true;
        }

        function showUploadImage(uploadResultArr) {
            if (!uploadResultArr || uploadResultArr.length == 0) { return }

            let uploadResult = $("#uploadResult");
            let obj = uploadResultArr[0];
            let str = "";

            let fileCallPath = encodeURIComponent(obj.uploadPath.replace(/\\/g, '/') + "/t_" + obj.uuid + "_" + obj.fileName);

            str += "<div id='result_card'>";
            str += "<img src='/display?fileName=" + fileCallPath + "'>";
            str += "<div class='imgDeleteBtn' data-file='" + fileCallPath + "'>x</div>";
            str += "<input type='hidden' name='imageList[0].fileName' value='" + obj.fileName + "'>";
            str += "<input type='hidden' name='imageList[0].uuid' value='" + obj.uuid + "'>";
            str += "<input type='hidden' name='imageList[0].uploadPath' value='" + obj.uploadPath + "'>";
            str += "</div>";

            uploadResult.append(str);
        }

        // 상품 등록 버튼
        $("#modifyBtn").on("click", function(e) {
            e.preventDefault();

            /* 체크 변수 */
            let itemNameCk = false;
            let brandIdCk = false;
            let mnfcYearCk = false;
            let manufacturerCk = false;
            let cateCodeCk = true;
            let priceCk = false;
            let stockCk = false;
            let discountCk = false;
            let introCk = false;
            let contentsCk = false;

            /* 체크 대상 변수 */
            let itemName = $("input[name='itemName']").val();
            let brandId = $("input[name='brandId']").val();
            let mnfcYear = $("input[name='mnfcYear']").val();
            let manufacturer = $("input[name='manufacturer']").val();
            let cateCode1 = $(".cate1").val();
            let cateCode2 = $(".cate2").val();
            let itemPrice = $("input[name='itemPrice']").val();
            let itemStock = $("input[name='itemStock']").val();
            let itemDiscount = $("#discount_interface").val();
            let itemIntro = $("textarea[name='itemIntro']").val();
            let itemContents = $("textarea[name='itemContents']").val();

            // Validate fields
            if (itemName) {
                $(".itemName_warn").css('display', 'none');
                itemNameCk = true;
            } else {
                $(".itemName_warn").css('display', 'block');
                itemNameCk = false;
            }

            if (brandId) {
                $(".brandId_warn").css('display', 'none');
                brandIdCk = true;
            } else {
                $(".brandId_warn").css('display', 'block');
                brandIdCk = false;
            }

            if (mnfcYear) {
                $(".mnfcYear_warn").css('display', 'none');
                mnfcYearCk = true;
            } else {
                $(".mnfcYear_warn").css('display', 'block');
                mnfcYearCk = false;
            }

            if (manufacturer) {
                $(".manufacturer_warn").css('display', 'none');
                manufacturerCk = true;
            } else {
                $(".manufacturer_warn").css('display', 'block');
                manufacturerCk = false;
            }

            if (cateCode1 != 'none' && (cateCode2 != 'none' || cateCode1 == '1000')) {
                $(".cateCode_warn").css('display', 'none');
                cateCodeCk = true;
            } else {
                $(".cateCode_warn").css('display', 'block');
                cateCodeCk = false;
            }

            if (itemPrice != 0) {
                $(".itemPrice_warn").css('display', 'none');
                priceCk = true;
            } else {
                $(".itemPrice_warn").css('display', 'block');
                priceCk = false;
            }

            if (itemStock != 0) {
                $(".itemStock_warn").css('display', 'none');
                stockCk = true;
            } else {
                $(".itemStock_warn").css('display', 'block');
                stockCk = false;
            }

            if(!isNaN(itemDiscount)){
                $(".itemDiscount_warn").css('display', 'none');
                discountCk = true;
            } else {
                $(".itemDiscount_warn").css('display', 'block');
                discountCk = false;
            }

            if (itemIntro) {
                $(".itemIntro_warn").css('display', 'none');
                introCk = true;
            } else {
                $(".itemIntro_warn").css('display', 'block');
                introCk = false;
            }

            if (itemContents) {
                $(".itemContents_warn").css('display', 'none');
                contentsCk = true;
            } else {
                $(".itemContents_warn").css('display', 'block');
                contentsCk = false;
            }

            if (itemNameCk && brandIdCk && mnfcYearCk && manufacturerCk
                && cateCodeCk && priceCk && stockCk && discountCk
                && introCk && contentsCk) {
                if (cateCode1 == '1000') {
                    $("input[name='cateCode']").val('1000');
                }
                $("#modifyForm").submit();
            } else {
                return false;
            }
        });
    });

</script>

</body>
</html>
