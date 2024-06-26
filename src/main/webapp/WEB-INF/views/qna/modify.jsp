<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../includes/header.jsp"%>
<link rel="stylesheet" href="/resources/css/qna/modify.css">
<div class="content_area">
    <div class="left_menu">
        <%@ include file="/WEB-INF/views/includes/leftmenu.jsp"%>
    </div>
    <div class="main_content">
        <div class="panel panel-default">
            <div class="panel-heading">QNA 수정하기</div>
            <div class="panel-body">
                <form id="qnaForm" role="form" action="/qna/modify" method="post" enctype="multipart/form-data">
                    <input type='hidden' name='pageNum' value='${cri.pageNum}'>
                    <input type='hidden' name='amount' value='${cri.amount}'>
                    <input type='hidden' name='type' value='${cri.type}'>
                    <input type='hidden' name='keyword' value='${cri.keyword}'>
                    <input type='hidden' name='qnaId' value='${qna.qnaId}'>
                    <input type='hidden' name='qnaWriter' value='${qna.qnaWriter}'>
                    
                    <div class="form-group">
                        <label>문의유형</label>
                        <select class="form-control" name="qnaCategory">
                            <option value="">유형선택</option>
                            <c:forEach var="category" items="${category}">
                                <option value="${category.categoryId}" <c:if test="${category.categoryId == qna.qnaCategory}">selected</c:if>>${category.categoryValue}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>제목</label>
                        <input class="form-control" name='qnaTitle' value='${qna.qnaTitle}'>
                    </div>
                    <div class="form-group">
                        <label>내용</label>
                        <textarea class="form-control" rows="3" name='qnaContent'>${qna.qnaContent}</textarea>
                    </div>
                    <div class="form-group">
                        <input type='file' name='uploadFile' multiple>
                    </div>
                    <div class="form-group">
                        <label>변경전 이미지</label>
                        <img src="/download/${qna.qnaImageURL}" alt="제품이미지" class="img-responsive">
                        <input type="hidden" value='${qna.qnaImageURL}' name='qnaImageURL'>
                    </div>
                    <button type="submit" data-oper='modify' class="btn btn-submit">수정하기</button>
                    <button type="button" data-oper='remove' class="btn btn-danger">삭제하기</button>
                    <button type="button" data-oper='list' class="btn btn-info">목록으로</button>
                </form>
            </div>
        </div>
    </div>
</div>

<%@ include file="/WEB-INF/views/includes/footer.jsp"%>

<script type="text/javascript">
    $(document).ready(function() {
        var formObj = $("#qnaForm");

        $("button[data-oper='modify']").on("click", function(e) {
            formObj.attr("action", "/qna/modify").submit();
        });

        $("button[data-oper='remove']").on("click", function(e) {
            if (confirm("삭제하시겠습니까?")) {
                formObj.attr("action", "/qna/remove").submit();
            }
        });

        $("button[data-oper='list']").on("click", function(e) {
            var reviewWriter = $("input[name='qnaWriter']").val();
            var pageNum = $("input[name='pageNum']").val();
            var amount = $("input[name='amount']").val();
            var type = $("input[name='type']").val();
            var keyword = $("input[name='keyword']").val();

            var url = "/review/review/" + reviewWriter + "?pageNum=" + pageNum + "&amount=" + amount + "&type=" + type + "&keyword=" + keyword;
            window.location.href = url;
        });
    });
</script>
