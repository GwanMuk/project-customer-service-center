<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@include file="../includes/header.jsp"%>
<link rel="stylesheet" href="/resources/css/faq/register.css">
<div class="content_area">
    <div class="sideList">
        <div class="sideListTitle">메뉴</div>
        <ul class="nav nav-pills nav-stacked">
            <li><a href="/board/notice">공지사항</a></li>
            <li><a href="/faq/faq">자주 묻는 질문</a></li>
            <li><a href="/qna/qna">1:1 문의하기</a></li>
            <li><a href="#">고객의 소리</a></li>
        </ul>
         <div class="contact_info">
            <p><strong>고객센터</strong></p>
            <p>02-0000-0000</p>
            <p>평일 09:00 ~ 18:00</p>
            <p>주말, 공휴일 휴무</p>
        </div>
        <div class="chat_info">
            <p><strong>실시간 채팅 상담</strong></p>
            <p>평일 09:00 ~ 21:00</p>
            <p>토요일 09:00 ~ 15:00</p>
        </div>
    </div>
    <div class="main_content">
        <h1 class="page-header">FAQ Register</h1>
        <div class="panel panel-default">
            <div class="panel-heading">FAQ Register</div>
            <div class="panel-body">
                <form role="form" action="/faq/register" method="post" enctype="multipart/form-data">
                    <div class="form-group">
                        <label>문의유형</label>
                        <select class="form-control" name="faqCategory">
                            <option value="">유형선택</option>
                            <c:forEach var="category" items="${category}">
                                <option value="${category.categoryId}">${category.categoryValue}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>Title</label>
                        <input class="form-control" name='faqTitle'>
                    </div>
                    <div class="form-group">
                        <label>Text area</label>
                        <textarea class="form-control" rows="3" name='faqDescription'></textarea>
                    </div>
                    <div class="form-group">
                        <label for="uploadFile">uploadFile</label>
                        <input type="file" id="uploadFile" name="uploadFile" multiple>
                        <input type="hidden" value='defaltImage.jpg' name='faqImageURL'>
                    </div>
                    <button type="submit" class="btn btn-success">Submit</button>
                    <button type="reset" class="btn btn-info">Reset</button>
                </form>
            </div>
        </div>
    </div>
</div>

<%@include file="../includes/footer.jsp"%>
