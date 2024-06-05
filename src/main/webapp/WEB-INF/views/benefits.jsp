<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="/WEB-INF/views/includes/header.jsp"%>
<title>Insert title here</title>
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/benefits.css">
<style>
    .benefits_content {
        text-align: center;
    }
    .benefits_head img, .benefits_body img {
        max-width: 100%;
        height: auto;
        display: inline-block;
        margin: 0; /* 마진 제거 */
    }
    .comment-section {
        margin: 20px auto;
        max-width: 800px;
        text-align: left;
    }
    .comment, .comment-reply {
        margin: 10px 0;
        padding: 10px;
        border: 1px solid #ddd;
        border-radius: 5px;
        background-color: #f9f9f9;
        display: flex;
        align-items: center;
    }
    .comment-reply {
        margin-left: 20px;
        display: flex;
        align-items: center;
    }
    .comment-reply .comment-author::before {
        content: "└ ";
        color: gray;
    }
    .comment-author {
        font-weight: bold;
        background-color: #F1F1F1;
        display: inline-block;
        margin-right: 10px;
        align-self: flex-start; /* Align the author name to the start */
    }
    .comment-date {
        font-size: 0.8em;
        color: gray;
    }
    .comment-content {
        margin-top: 0; /* Remove top margin to align with author name */
        flex: 1;
    }
    .comment-write {
        margin-bottom: 20px;
    }
</style>

</head>
<body>
    <div class="benefits_content">
        <div class="benefits_head">
            <img src="<%=request.getContextPath()%>/resources/img/benefits/1.jpg">
            <img src="<%=request.getContextPath()%>/resources/img/benefits/02.jpg">
        </div>
        <div class="benefits_body">
            <img src="<%=request.getContextPath()%>/resources/img/benefits/01.jpg">
            <img src="<%=request.getContextPath()%>/resources/img/benefits/03-2.jpg">
            <img src="<%=request.getContextPath()%>/resources/img/benefits/04-2.jpg">
            <img src="<%=request.getContextPath()%>/resources/img/benefits/10-2.jpg">
            <img src="<%=request.getContextPath()%>/resources/img/benefits/12.jpg">
            <img src="<%=request.getContextPath()%>/resources/img/benefits/13.jpg">
            <img src="<%=request.getContextPath()%>/resources/img/benefits/14.jpg">
            <img src="<%=request.getContextPath()%>/resources/img/benefits/15.jpg">
            <img src="<%=request.getContextPath()%>/resources/img/benefits/16.jpg">
            <img src="<%=request.getContextPath()%>/resources/img/benefits/17.jpg">
            <img src="<%=request.getContextPath()%>/resources/img/benefits/18.jpg">
            <img src="<%=request.getContextPath()%>/resources/img/benefits/19.jpg">
            <img src="<%=request.getContextPath()%>/resources/img/benefits/22.jpg">
            <img src="<%=request.getContextPath()%>/resources/img/benefits/20.jpg">
            <img src="<%=request.getContextPath()%>/resources/img/benefits/21.jpg">
        </div>
        <div class="bf-greeting">
            <h3>따뜻한 봄날의 5월은 가정의 달!<br>팔닭 가족분들 모두모두 건강하세요</h3>
            <h5>우석MD</h5>
            <hr>
        </div>
        <div class="comment-section">
            <em>MD에게 질문 하세요!</em><span class="panel-side">비방이나 욕설이 포함된 글은 예고없이 삭제 또는 제한될 수 있습니다.</span>
            <div class="comment-write">
                <form role="form" action="${pageContext.request.contextPath}/benefits/register" method="post" enctype="multipart/form-data">
                    <textarea class="form-control" rows="3" name="benefitsDescription" placeholder="댓글을 작성해 주세요."></textarea>
                    <button type="submit" class="btn btn-default benefits-btn-success">등록</button>
                </form>
            </div>
            <c:forEach items="${list}" var="benefits">
                <div class="comment">
                    <div class="comment-author">${benefits.benefitsWriter}</div>
                    <div class="comment-content">
                        ${benefits.benefitsDescription}
                        <div class="comment-date">
                            <fmt:formatDate pattern="yyyy-MM-dd" value="${benefits.benefitsRegDate}" />
                        </div>
                    <c:forEach items="${replyList}" var="benefitsReply">
                        <c:if test="${benefitsReply.benefitsId == benefits.benefitsId}">
                            <div class="comment-reply">
                                <div class="comment-author">${benefitsReply.replyer}</div>
                                <div class="comment-content">
                                    ${benefitsReply.reply}
                                    <div class="comment-date">
                                        <fmt:formatDate pattern="yyyy-MM-dd" value="${benefitsReply.replyDate}" />
                                    </div>
                                </div>
                            </div>
                        </c:if>
                    </c:forEach>
                </div>
                    </div>
            </c:forEach>
        </div>
    </div>
    <form id="actionForm" action="${pageContext.request.contextPath}/benefits" method="get">
        <input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
        <input type="hidden" name="amount" value="${pageMaker.cri.amount}">
        <input type="hidden" name="type" value="${pageMaker.cri.type}">
        <input type="hidden" name="keyword" value="${pageMaker.cri.keyword}">
    </form>
 <script>
        $(document).ready(function() {
            var isLoggedIn = <%= (session.getAttribute("user") != null) ? "true" : "false" %>;
            $("#commentForm").on("submit", function(e) {
                if (!isLoggedIn) {
                    e.preventDefault();
                    alert("회원만 글 작성이 가능합니다.");
                    window.location.href = "${pageContext.request.contextPath}/login"; // 로그인 페이지 URL로 변경
                }
            });

            var result = '${result}';
            checkModal(result);
            history.replaceState({}, null, null);
            function checkModal(result) {
                if (result === '' || history.state) {
                    return;
                } else {
                    if (parseInt(result) > 0) {
                        $(".modal-body").html("게시글 " + parseInt(result) + "번이 등록되었습니다.");
                    }
                    $("#myModal").modal("show");
                }
            }
            $(".regBtn").on("click", function() {
                self.location = "${pageContext.request.contextPath}/benefits/register";
            });
            var actionForm = $("#actionForm");
            $(".paginate_button a").on("click", function(e) {
                e.preventDefault();
                actionForm.find("input[name='pageNum']").val($(this).attr("href"));
                actionForm.submit();
            });
            $(".move").on("click", function(e) {
                e.preventDefault();
                actionForm.append("<input type='hidden' name='benefitsId' value='" + $(this).attr("href") + "'>");
                actionForm.attr("action", "${pageContext.request.contextPath}/benefits/get");
                actionForm.submit();
            });
            var searchForm = $("#searchForm");
            $("#searchForm button").on("click", function(e) {
                if (!searchForm.find("option:selected").val()) {
                    alert("검색종류를 선택하세요");
                    return false;
                }
                if (!searchForm.find("input[name='keyword']").val()) {
                    alert("키워드를 입력하세요");
                    return false;
                }
                searchForm.find("input[name='pageNum']").val("1");
                e.preventDefault();
                searchForm.submit();
            });
        });
    </script>
    <%@ include file="/WEB-INF/views/includes/footer.jsp"%>
</body>
</html>
