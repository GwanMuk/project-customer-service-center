<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.net.URLEncoder" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../resources/css/admin/brandManage.css">
</head>
<body>

	<%@include file="../includes/admin/header.jsp"%>

	<div class="admin_content_wrap">
		<div class="admin_content_subject">
			<span>브랜드 관리</span>
		</div>
		<div class="brand_table_wrap">
			<!-- 게시물 O -->
			<c:if test="${listCheck != 'empty' }">
				<table class="brand_table">
					<thead>
						<tr>
							<td class="th_column_1">브랜드 번호</td>
							<td class="th_column_2">브랜드 이름</td>
							<td class="th_column_3">등록 날짜</td>
							<td class="th_column_4">수정 날짜</td>
						</tr>
					</thead>
					<!-- 브랜드 목록 출력 -->
					<c:forEach items="${list}" var="item">
						<tr>
							<td><c:out value="${item.brandId}"></c:out></td>
							<td><a class="move"
								href="/admin/brandDetail?brandId=${item.brandId}"> <c:out
										value="${item.brandName}"></c:out>
							</a></td>
							<td><fmt:formatDate value="${item.regDate}"
									pattern="yyyy-MM-dd" /></td>
							<td><fmt:formatDate value="${item.updateDate}"
									pattern="yyyy-MM-dd" /></td>
						</tr>
					</c:forEach>
				</table>
			</c:if>
			<c:if test="${listCheck == 'empty'}">
				<div class="table_empty">등록된 브랜드가 없습니다.</div>
			</c:if>
		</div>

		<!-- 검색 영역 -->
		<div class="search_wrap">
			<form id="searchForm" action="/admin/brandManage" method="get">
				<div class="search_input">
					<input type="text" name="keyword"
						value='<c:out value="${pageMaker.cri.keyword}"></c:out>'>
					<input type="hidden" name="pageNum"
						value='<c:out value="${pageMaker.cri.pageNum }"></c:out>'>
					<input type="hidden" name="amount" value='${pageMaker.cri.amount}'>
					<button class='btn search_btn'>검 색</button>
				</div>
			</form>
		</div>

		<!-- 페이지 이동 인터페이스 영역 -->
		<div class="pageMaker_wrap">
			<ul class="pageMaker">
				<!-- 이전 버튼 -->
				<c:if test="${pageMaker.prev}">
					<li class="pageMaker_btn prev"><a
						href="/admin/brandManage?pageNum=${pageMaker.pageStart - 1}&amount=${pageMaker.cri.amount}">이전</a></li>
				</c:if>
				<!-- 페이지 번호 -->
				<c:forEach begin="${pageMaker.pageStart}" end="${pageMaker.pageEnd}"
					var="num">
					<li
						class="pageMaker_btn ${pageMaker.cri.pageNum == num ? 'active':''}">
						<a
						href="/admin/brandManage?pageNum=${num}&amount=${pageMaker.cri.amount}">${num}</a>
					</li>
				</c:forEach>
				<!-- 다음 버튼 -->
				<c:if test="${pageMaker.next}">
					<li class="pageMaker_btn next"><a
						href="/admin/brandManage?pageNum=${pageMaker.pageEnd + 1}&amount=${pageMaker.cri.amount}">다음</a></li>
				</c:if>
			</ul>
		</div>


		<form id="moveForm" action="/admin/brandManage" method="get">
			<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
			<input type="hidden" name="amount" value="${pageMaker.cri.amount}">
			<input type="hidden" name="keyword" value="${pageMaker.cri.keyword}">
		</form>

	</div>

	<%@include file="../includes/admin/footer.jsp"%>

	<script src="https://code.jquery.com/jquery-3.4.1.js"
		integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
		crossorigin="anonymous">
		
	</script>

	<script>
    $(document).ready(function() {
        // 결과 값 변수 전역으로 선언
        let result = '<c:out value="${enroll_result}"/>';
        let mresult = '<c:out value="${modify_result}"/>';
        let delete_result = '${delete_result}';
        
        // 결과 확인 함수 호출
        checkResult(result);
        checkmResult(mresult);
        checkDeleteResult(delete_result);
        
        // 등록 결과 확인 함수
        function checkResult(result) {
            if (result === '') {
                return;
            }
            alert("브랜드 '" + result + "'을 등록하였습니다.");
        }

        // 수정 결과 확인 함수
        function checkmResult(mresult) {
            if (mresult === '1') {
                alert("브랜드 정보 수정을 완료하였습니다.");
            } else if (mresult === '0') {
                alert("브랜드 정보 수정을 하지 못하였습니다.");
            }
        }

        // 삭제 결과 확인 함수
        function checkDeleteResult(delete_result) {
            if (delete_result == 1) {
                alert("삭제 완료");
            } else if (delete_result == 2) {
                alert("해당 브랜드 데이터를 사용하고 있는 데이터가 있어서 삭제 할 수 없습니다.")
            }
        }
        
     // 페이지 이동 버튼
        $(".pageMaker_btn a").on("click", function(e) {
            e.preventDefault();
            let pageNum = $(this).attr("href").split("=")[1];
            let searchKeyword = $('#searchForm input[name="keyword"]').val(); // 현재 검색어 가져오기
            let encodedKeyword = encodeURIComponent(searchKeyword); // 검색어 인코딩
            
            // 페이지 이동 URL을 조합하여 전달
            let url = "${pageContext.request.contextPath}/admin/brandManage?pageNum=" + pageNum + "&amount=${pageMaker.cri.amount}&keyword=" + encodedKeyword
        })
    };
	</script>



</body>
</html>
