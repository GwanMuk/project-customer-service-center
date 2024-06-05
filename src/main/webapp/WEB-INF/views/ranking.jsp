<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>판매량 랭킹</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/ranking.css">
<script src="https://code.jquery.com/jquery-3.4.1.js" integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU=" crossorigin="anonymous"></script>
</head>
<body>
    <%@ include file="/WEB-INF/views/includes/header.jsp" %>
    <div class="content_area">
        <h1>오늘의 전체 랭킹 순위</h1>
        <c:forEach items="${topSellingItems}" var="item" varStatus="status">
            <div class="ranking_item">
                <div class="rank">${status.index + 1}</div>
                <div class="image">
                    <c:choose>
                        <c:when test="${not empty item.imageList}">
                            <c:forEach var="image" items="${item.imageList}" begin="0" end="0">
                                <img src="${pageContext.request.contextPath}/displayRankingImage?fileName=${fn:replace(image.uploadPath, '\\', '/')}/${image.uuid}_${image.fileName}" alt="${item.itemName}">
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <img src="${pageContext.request.contextPath}/resources/img/noImage.png" alt="No Image">
                        </c:otherwise>
                    </c:choose>
                </div>
                <div class="details">
                    <div class="item_title">
                        <div class="title">${item.itemName}</div>
                        <div class="brand">${item.brandName}</div>
                        <div class="delivery">
                            <img src="${pageContext.request.contextPath}/resources/img/delivery.png" alt="Express Delivery">
                        </div>
                    </div>
                    <div class="price_info">
                        <del><fmt:formatNumber value="${item.itemPrice}" pattern="#,### 원"/></del>
                        <strong><fmt:formatNumber value="${item.itemPrice * (1 - item.itemDiscount)}" pattern="#,### 원"/></strong>
                    </div>
                    <div class="extras">
                        <span>1% 적립</span>
                        <span>★ 5.0</span>
                    </div>
                </div>
                <div class="actions">
                     <a href="${pageContext.request.contextPath}/cart/${member.memberId}" id="cart-icon">
                        <img src="${pageContext.request.contextPath}/resources/img/cart.png" alt="Add to Cart">
                    </a>
                    <img src="${pageContext.request.contextPath}/resources/img/heart.png" alt="Add to Wishlist">
                </div>
            </div>
        </c:forEach>
    </div>
    <%@ include file="/WEB-INF/views/includes/footer.jsp" %>
</body>
</html>
