<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Welcome Unknown</title>
<link rel="stylesheet" href="/resources/css/goodsDetail.css">
<script src="https://code.jquery.com/jquery-3.4.1.js"
	integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
	crossorigin="anonymous"></script>
</head>
<body>
<%@ include file="/WEB-INF/views/includes/header.jsp" %>

<div class="content_area">
    <div class="line"></div>
    <div class="content_top">
        <div class="ct_left_area">
            <div class="image_wrap"
                data-itemid="${goodsInfo.imageList[0].itemId}"
                data-path="${goodsInfo.imageList[0].uploadPath}"
                data-uuid="${goodsInfo.imageList[0].uuid}"
                data-filename="${goodsInfo.imageList[0].fileName}">
                <img>
            </div>
        </div>
        <div class="ct_right_area">
            <div class="title">
                <h1>${goodsInfo.itemName}</h1>
            </div>
            <div class="line"></div>
            <div class="brand">
                <span>${goodsInfo.brandName}</span> <span>|</span> <span>${goodsInfo.manufacturer}</span> <span>|</span> <span class="mnfcYear">${goodsInfo.mnfcYear}</span>
            </div>
            <div class="line"></div>
            <div class="price">
                <div class="sale_price">
                    정가 : <fmt:formatNumber value="${goodsInfo.itemPrice}" pattern="#,### 원" />
                </div>
                <div class="discount_price">
                    판매가 : <span class="discount_price_number"><fmt:formatNumber
                            value="${goodsInfo.itemPrice - (goodsInfo.itemPrice * goodsInfo.itemDiscount)}"
                            pattern="#,### 원" /></span> [
                    <fmt:formatNumber value="${goodsInfo.itemDiscount * 100}" pattern="###" />%
                    <fmt:formatNumber value="${goodsInfo.itemPrice * goodsInfo.itemDiscount}" pattern="#,### 원" />
                    할인]
                </div>
                <div>
                    적립 포인트 : <span class="point_span"></span>원
                </div>
            </div>
            <div class="line"></div>
            <div class="button">
                <div class="button_quantity">
                    주문수량 <input type="text" class="quantity_input" value="1">
                    <span>
                        <button class="plus_btn">+</button>
                        <button class="minus_btn">-</button>
                    </span>
                </div>
                <div class="button_set">
                    <a class="btn_cart">장바구니 담기</a> <a class="btn_buy">바로구매</a>
                </div>
            </div>
        </div>
    </div>
    <div class="line"></div>
    <div class="content_middle">
        <div class="item_intro">${goodsInfo.itemIntro}</div>
        <div class="item_content">${goodsInfo.itemContents}</div>
    </div>
    <div class="line"></div>
    <div class="content_bottom">
        <h2>리뷰</h2>
         <button id='regBtn' type="button" class="btn-review-register">리뷰쓰기</button>
        <c:forEach var="review" items="${reviewList}">
            <div class="review">
                <h3>${review.reviewTitle}</h3>
                <img src="/download/${review.reviewImageURL}" alt="review Image"
							style="max-width: 800px;">
                <p>${review.reviewContent}</p>
                <p>작성자: ${review.reviewWriter} | 작성일: <fmt:formatDate value="${review.reviewRegdate}" pattern="yyyy-MM-dd"/></p>
            </div>
        </c:forEach>
    </div>
</div>

<!-- 주문 form -->
<form action="/order/${member.memberId}" method="get" class="order_form">
    <input type="hidden" name="orders[0].itemId" value="${goodsInfo.itemId}">
    <input type="hidden" name="orders[0].itemCount" value="">
</form>

<%@ include file="/WEB-INF/views/includes/footer.jsp" %>

<script>
    $(document).ready(function() {
        // 이미지 삽입
        const bobj = $(".image_wrap");

        if (bobj.data("itemid")) {
            const uploadPath = bobj.data("path");
            const uuid = bobj.data("uuid");
            const fileName = bobj.data("filename");

            const fileCallPath = encodeURIComponent(uploadPath + "/t_" + uuid + "_" + fileName);

            bobj.find("img").attr('src', '/display?fileName=' + fileCallPath);
        } else {
            bobj.find("img").attr('src', '/resources/img/goodsNoImage.png');
        }

        // 제조년도 처리
        const year = "${goodsInfo.mnfcYear}";

        let tempYear = year.substr(0, 10);

        let yearArray = tempYear.split("-")
        let mnfcYear = yearArray[0] + "년 " + yearArray[1] + "월 " + yearArray[2] + "일";

        $(".mnfcYear").html(mnfcYear);

        // 포인트 삽입
        let salePrice = "${goodsInfo.itemPrice - (goodsInfo.itemPrice * goodsInfo.itemDiscount)}"
        let point = salePrice * 0.01;
        point = Math.floor(point);
        $(".point_span").text(point);

        // 장바구니 수량 버튼 조작
        $(".plus_btn").on("click", function() {
            let quantity = parseInt($(".quantity_input").val());
            $(".quantity_input").val(quantity + 1);
        });

        $(".minus_btn").on("click", function() {
            let quantity = parseInt($(".quantity_input").val());
            if (quantity > 1) {
                $(".quantity_input").val(quantity - 1);
            }
        });

        // 장바구니 추가
        $(".btn_cart").on("click", function(e) {
            let quantity = $(".quantity_input").val();
            const form = {
                memberId: '${member.memberId}',
                itemId: '${goodsInfo.itemId}',
                itemCount: quantity
            };

            $.ajax({
                url: '/cart/add',
                type: 'POST',
                data: form,
                success: function(result) {
                    cartAlert(result);
                }
            })
        });

        function cartAlert(result) {
            if (result == '0') {
                alert("장바구니에 추가를 하지 못하였습니다.");
            } else if (result == '1') {
                alert("장바구니에 추가되었습니다.");
            } else if (result == '2') {
                alert("장바구니에 이미 추가되어져 있습니다.");
            } else if (result == '5') {
                alert("로그인이 필요합니다.");
            }
        }

        // 바로구매 버튼
        $(".btn_buy").on("click", function(e) {
            if (${member == null}) {
                e.preventDefault();
                alert("로그인이 필요합니다.");
            } else {
                let itemCount = $(".quantity_input").val();
                $(".order_form").find("input[name='orders[0].itemCount']").val(itemCount);
                $(".order_form").submit();
            }
        });
        
        // 리뷰쓰기버튼
        $("#regBtn").on("click", function() {
            self.location = "/review/register/";
        });
    });
</script>

</body>
</html>
