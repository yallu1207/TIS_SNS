<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <% Cookie[] cks = request.getCookies();
 String uid="";
 boolean ckflag = false;
 if(cks!=null){
	 for(Cookie ck : cks){
 		String key = ck.getName();
 		if(key.equals("uid")){
 			uid=ck.getValue();
 			ckflag=true;
 			break;
 		}
	 }
	}
 %>

<div class="row">
	<!-- Modal Dialog -->
	<div class="modal fade" role="dialog" id="myModal">
		<!-- id 지정 필수, class는 modal (옵션,효과) -->
		<div class="modal-dialog">
			<!--겉 테두리 창 -->
			<div class="modal-content">
				<!-- 내용 창 -->
				<form name="loginF" action="login" method="POST">
					<div class="modal-header">
						<!--헤더 영역-->
						<h4>TODAY 로그인</h4>
						<button class="close" data-dismiss="modal">&times;</button>
					</div>
					<div class="modal-body">
						<!-- 바디 영역-->
						<div class="row m-2" style=margin-bottom:10px>
							<label for="userid" class="col-md-3">아이디</label>
							<div class="col-md-9">
								<input type="text" name="userid" id="userid"
									placeholder="아이디를 입력해주세요" class="form-control"
									value="<%=uid%>"
									required>
							</div>
						</div>
					
						<div class="row m-2">
							<label for="userpwd" class="col-md-3">비밀번호</label>
							<div class="col-md-9">
								<input type="password" name="pwd" id="pwd"
									placeholder="비밀번호를 입력해주세요" class="form-control"
									required>
							</div>
						</div>
						
							<div class="row m-2">
							<label for="saveId" class="col-md-4"> 아이디 저장하기</label>
							<div class="col-md-4">
						<input type="checkbox" name="saveId" id="saveId" class="form-check-input"
						<%=(ckflag)?"checked":""%>><!-- 쿠키에 저장된 id가 있으면 체크박스 체크ㅡ -->
						</div>
						</div>
						
					</div>
					<div class="modal-footer">
						<!-- footer 영역 -->
						<button type="button" id="loginBtn" onclick="loginCheck()" class="btn btn-warning">Login</button>
						<button data-dismiss="modal" class="btn btn-info">close</button>
					</div>
				</form>
			</div>
		</div>
	</div>
	<!--      ---     -->
</div>
<script>
function loginCheck(){
	
	//아이디 입력하세요
	if(!loginF.userid.value){
		alert('아이디를 입력하세요');
		loginF.userid.focus();
		return;
	}
	
	//비밀번호 입력하세요
	if(!loginF.pwd.value){
		alert('비밀번호를 입력하세요');
		loginF.pwd.focus();
		return;
	}
	// 전송
	loginF.submit();
}
</script>