<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


<% String myctx = request.getContextPath();%>
<c:import url="/top/" />


<!-- Input Your JSP Code Start-->
<!-- 댓글 보기 -->
<c:if test="${replyList eq null}">
	<p>게시글이 존재하지 않습니다.</p>
</c:if>
<c:if test="${replyList ne null}">
	<c:forEach var="replyAll" items="${replyList}" varStatus="rst">
		<hr class="w3-clear" style="margin: 10px">
		<div>
			<span class="w3-left w3-opacity"> &nbsp;&nbsp;&nbsp;&nbsp;<b>${replyAll.nick_name}</b>&nbsp;&nbsp;
				<fmt:formatDate value="${replyAll.wdate}"
					pattern="yyyy-MM-dd hh:mm:ss" />
			</span> <br>
			<h6>&nbsp;&nbsp;&nbsp;&nbsp;${replyAll.content}, ${rst.index}</h6>
			<hr class="w3-clear" style="margin: 10px">
		</div>
	</c:forEach>
</c:if>
<!-- ------------ -->
