<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!--  top -->
<jsp:include page="../top.jsp" />
<!--  top -->
<script>
	function bntEdit() {
		$('pwd').val('');
		$('#pf').show('slow');
		$('#pwd').focus();
	}

	function move() {
		if (!$('#pwd').val()) {
			alert('비밀번호를 입력해 주세요.');
			$('#pwd').focus();
			return;
		}
		var pwd = $('#pwd').val();
		var idx = ${meetingInfo.midx};
		$('#mpwd').val(pwd);
		$('#midx').val(idx);
		$('#pf').submit();
	}

	var rperson = ${meetingInfo.rpersonnel};
	var person = ${meetingInfo.personnel};
	var rstatus = ${meetingInfo.rstatus};
	var midx = ${meetingInfo.midx};
	function btnApply() {
		//alert(midx + "/" + rperson);
		if (rperson == person || rperson > person) {
			alert('현재 모집인원이 마감되어 신청할 수 없습니다.');
			return;
		} else if (rperson < person) {
			//alert(midx + "/" + rperson);
			$('#personnel').val(person);
			$('#rpersonnel').val(rperson);
			$('#rstatus').val(rstatus);
			$('#midx').val(midx);
			$('#rf').submit();
		}
	}
	
	var r = ${meetingInfo.rstatus};
	   var cmidx = ${meetingInfo.midx};
	   function btnClose() {
	      alert("모집완료 신청 누름"+cmidx+r);
	      if(r!=1){
	         alert("현재 모집완료된 상태입니다.");
	         return;
	      }
	      $('#cmidx').val(cmidx);
	      $('#rcf').submit();      
	   }

	function fileDown(image) {
		location.href = "fileDown?image=" + encodeURIComponent(image);
	}
</script>
<!-- Input Your JSP Code Start-->
<h1 align="center">소모임 개별 정보</h1>
<c:if test="${meetingInfo eq null}">
	<h3>해당 소모임 게시글이 존재하지 않습니다.</h3>
</c:if>
<c:if test="${meetingInfo ne null}">
	<div class="row">
		<div class="col-md-11">
			<table class="table table-bordered">
				<tr>
					<td>글번호</td>
					<td><c:out value="${meetingInfo.midx}" /></td>
					<td>모집분야</td>
					<td><c:out value="${meetingInfo.category}" /></td>
				</tr>
				<tr>
					<td>모임명</td>
					<td colspan="3"><c:out value="${meetingInfo.meetName}" /></td>
				</tr>
				<tr>
					<td>모임내용</td>
					<td colspan="3"><c:out value="${meetingInfo.meetContent}" /></td>
				</tr>
				<tr>
					<td>모임일정</td>
					<td colspan="3"><fmt:formatDate value="${meetingInfo.mdate}"
							pattern="yyyy-MM-dd" /> <c:out value="(${meetingInfo.mtime})" />
					</td>
				</tr>
				<tr>
					<td>모임장</td>
					<td>${meetingInfo.leader}</td>
					<td>연락처</td>
					<td>${meetingInfo.hp1}-${meetingInfo.hp2}-${meetingInfo.hp3}</td>
				</tr>
				<tr>
					<td>모집현황</td>
					<td colspan="3">${meetingInfo.rpersonnel}/${meetingInfo.personnel}
						명</td>
				</tr>
				<tr>
					<td>모임장소</td>
					<td colspan="3">${meetingInfo.place}</td>
				</tr>
				<tr>
					<td colspan="4"><img src="../images/${meetingInfo.image}"
						class="img img-responsive" id="img" style="width: 400px;"></td>
				</tr>
				<tr align="center">
					<td colspan="4">
						<button class="btn btn-default"
							onclick="location.href='list'">목록으로</button> 
							<c:if test="${loginUser.nick_name ne meetingInfo.leader}">
								<button type="button" class="btn btn-primary" onclick="btnApply()">신청하기</button>
							</c:if>
							<c:if test="${loginUser.nick_name eq meetingInfo.leader}">
								<button class="btn btn-primary" id="btnEdit" onclick="bntEdit()">수정하기</button>
								<button class="btn btn-danger" id="btnClose" onclick="btnClose()">모집완료</button>
							<form name="pf" id="pf" style="display: none; margin-top: 10px" action="update" method="post">
								<input type="hidden" name="midx" id="midx" name="midx">
								<input type="hidden" name="mpwd" id="mpwd">
								<b>비밀번호 : </b> 
								<input type="password" name="pwd" id="pwd">
								<button type="button" class="btn btn-primary" id="btn" onclick="move()">글수정</button>
							</form>
						</c:if>
					</td>
				</tr>
			</table>
		</div>
	</div>
</c:if>
<form name="rf" id="rf" action="apply" method="post">
	<input type="hidden" id="midx" name="midx">
	<input type="hidden" id="rpersonnel" name="rpersonnel">
	<input type="hidden" id="personnel" name="personnel">
	<input type="hidden" id="rstatus" name="rstatus">
</form>
<form name="rcf" id="rcf" action="close" method="post">
   <input type="hidden" id="cmidx" name="cmidx">
</form>
<!-- Input Your JSP Code End-->
<!--  foot -->
<jsp:include page="../foot.jsp" />
<!--  foot -->
