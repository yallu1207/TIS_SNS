<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!--jQuery Google CDN-------------------------->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<!-------------------------------------------->
<% String myctx = request.getContextPath(); %>

<style>
	#content{
	 word-break:break-all;	
	 /* width 범위를 초과해서 글자가 나가버리는거 방지 */
	}
</style>
<script type="text/javascript">


	function mySubmit(index){
		if(index==1){			//수정버튼 클릭시
			document.detail.action='<%=myctx%>/user/update';
		}//--1번
		if(index==2){			//삭제버튼 클릭시
			var isDel=confirm('정말 삭제하시겠습니까?');
			if(isDel==true){
				document.detail.action='<%=myctx%>/user/delete';
			}
		}//--2번
		if(index==3){			//댓글작성 클릭시
			if(!$('#reply').val()){
				alert('댓글을 입력해주세요');
				$('#reply').val('').focus();
				return;
			}
			var isOk=reply_lengthCheck();
			if(isOk==false){
				alert('댓글은 20자 내로 작성해주세요^^');
				$('#reply').val('').focus();
				return;
			}
			document.detail.action='<%=myctx%>/user/write_reply';
		}//--3번
		document.detail.submit();
	}// submit()----------------------------------------------

	function show_text(index) {
		if (index == 1) {
			$('#te').html("slide Up");
			$('#content').slideUp(1000);
			$("#detail").modal('show');
		}// content 보이기 클릭
		if (index == 2) {
			$('#te').html("slide Down");
			$('#content').slideDown(1000);
			$("#detail").modal('show');	//모달이 자동으로 닫히는거 방지
		}// content 숨기기 클릭
	}//show_text()-------------------------------------

	function reply_lengthCheck() {
		var flag = true;
		if ($('#reply').val().length > 25) {
			flag = false;
		}
		return flag;
	}//reply_lengthCheck()-----------------
	

</script>

<div id="detail" class="modal fade" role="dialog">
	<div class="modal-dialog" text-align="center">
		<div class="modal-content">
			<form name="detail" method="post">
				<input type="hidden" name="boardnum" ID="boardnum2" /> 
				<input type="hidden" name="content" ID="content2" />
				<input type="hidden" name="filename" ID="bimg2" />
				<input type="hidden" name="author" ID="author2" />

				<table class="table table-condensed table-striped">
					<tr>
						<td colspan='2'><div id="author"></div></td>
					</tr>
					<tr>
						<td colspan='2'><div id="time"></div></td>
					</tr>
					<tr>
					
						<td><img id="bimg"></td>
						
						
						<td colspan='2'>
							<button type="button" onclick="show_text(1)">내용숨기기</button>
							<button type="button" onclick="show_text(2)">내용보이기</button>
							<div id="content"></div>
						</td>
					</tr>
					<tr>
						<td><b>댓글작성</b></td>
						<td><input type="text" name="reply" id="reply" onkeypress="if( event.keyCode==13 ){ mySubmit(3);}"></td>
						<td><button type="button" class="btn btn-primary" onclick="mySubmit(3)">작성</button></td>
					</tr>
					<tr>
						<td colspan='2'>
							<div id="re"></div>
						</td>
					</tr>
				</table>

				<div class="madal-footer text-center">
					
						<button type="button" class="btn btn-primary" id="show1" style="display:none" onclick="mySubmit(1)">수정</button>
						<button type="button" class="btn btn-warning" id="show2" style="display:none" onclick="mySubmit(2)">삭제</button>
						<button data-dismiss="modal" class="btn btn-danger">닫기</button>
					
				</div>
			</form>
		</div>
	</div>
</div>