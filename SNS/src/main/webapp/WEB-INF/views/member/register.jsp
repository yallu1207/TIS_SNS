<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<% String myctx = request.getContextPath();%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/JavaScript" src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>

<c:import url="/top_before/" />

<script type="text/javascript">
/* 아이디, 닉네임 중복체크를 위해 팝업창을 띄운다*/
var win = null;
var win2 = null;
var win3 = null;
var flag = false;
var flag2 = false;
var flag3 = false;

var regex = /^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/;
// 비밀번호 정규식

$(function(){
	$('#name').focus(); // userid창에 포커스
})

var idCheck=function(){
	var url="idCheck";
	win=window.open(url,"idCheck","width=460, height=180, left=100, top=100");
	flag = true; // 아이디 중복체크 버튼을 누르면 true로 변경
}
var nickCheck=function(){
	var url2="nickCheck";
	win2=window.open(url2,"nickCheck","width=460, height=180, left=100, top=100");
	flag2 = true; // 닉네임 중복체크 버튼을 누르면 true로 변경
}
var rgCheck=function(){
	var url3="rgCheck";
	win3=window.open(url3,"rgCheck","width=500, height=500, left=100, top=100");
	//flag3=true;	//이용약관 확인여부
	//alert("flag3 = "+flag3);
}


/* function rgCheck(){
	var url3="rgCheck";
	win3=window.open(url3,"rgCheck","width=500, height=500, left=100, top=100");
	var flag3=true;	//이용약관 확인여부
	alert("flag3 = "+flag3);
} */
 
/* var rgCheck()=function(){
	var url3="rgCheck";
	win3=window.open(url3,"rgCheck","width=500, height=500, left=100, top=100");
	var flag3=true;	//이용약관 확인여부
	alert("flag3 = "+flag3);
} */




function go(index){

	if(index==1){
		if(!mf.name.value){
			alert('이름을 입력하세요');
			mf.name.focus();
			return false;
		}
		if(!flag2){
			alert('[필수] 닉네임 중복체크');
			mf.nick_name.focus();
			return false;
		}
		if(!mf.nick_name.value){
			alert('[필수] 닉네임 중복체크');
			mf.nick_name.focus();
			return false;
		}
		
		if(!flag){ // 중복체크를 하지 않았다면
			alert('[필수] 아이디 중복체크');
			mf.userid.focus();
			return false;
		}
		if(!mf.userid.value){
			alert('[필수] 아이디 중복체크');
			mf.userid.focus();
			return false;
		}
	
		if(!mf.pwd.value){
			alert('비밀번호를 입력하세요');
			mf.pwd.focus();
			return false;
		}
		if(!mf.pwd2.value){
			alert('비밀번호를 입력하세요');
			mf.pwd2.focus();
			return false;
		}
		if(mf.pwd.value){
			if(mf.pwd.value!=mf.pwd2.value){
				alert('비밀번호가 일치하지 않습니다.');
				mf.pwd.focus();
				return false;
			}
			//-----비밀번호 정규식
			if( !regex.test(mf.pwd.value) ) {
	         alert("비밀번호는 특수문자 / 문자 / 숫자 포함 형태의 8~15자리 이내만 가능합니다.");
	         return false;
	   		}
		}
		if(!mf.email.value){
			alert('이메일을 입력하세요');
			mf.email.focus();
			return false;
		}
	/* 	//----------이메일 형식 체크
		if(isEmail(mf.email.value)){
			alert('이메일 형식이 올바르지 않습니다.');
			mf.email.focus();
			return false;
		}
		//--------이메일 정규식
		function isEmail(asValue) {
	
			var regExp = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
	
			return regExp.test(asValue); // 형식에 맞는 경우 true 리턴	
	
		}//--------이메일 정규식 */
		
		if(!mf.birth.value){
			alert('생일을 입력하세요');
			mf.birth.focus();
			return false;
		}
		if(!mf.hp1.value){
			alert('전화번호를 입력하세요');
			mf.hp1.focus();
			return false;
		}
		if(!mf.hp2.value){
			alert('전화번호를 입력하세요');
			mf.hp2.focus();
			return false;
		}
		if(!mf.hp3.value){
			alert('전화번호를 입력하세요');
			mf.hp3.focus();
			return false;
		}
		if(!mf.post.value){
			alert('우편번호를 입력하세요');
			mf.post.focus();
			return false;
		}
		if(!mf.addr1.value){
			alert('주소를 입력하세요');
			mf.addr1.focus();
			return false;
		}
		if(!mf.addr2.value){
			alert('나머지 주소를 입력하세요');
			mf.addr2.focus();
			return false;
		}
		
		//===========================================
		
		if(!flag3){
			alert("이용약관을 확인해주세요");
			mf.service.focus();
			return false;
		}
		
	
		
		// 그외 유효성 체크 : 정규식 이용해서 필터링
		
		document.mf.action='<%=myctx%>/registerEnd';
	}
	
	
	if(index==2){
		document.mf.action='<%=myctx%>/index';
	}
	
	
	//액션
	document.mf.submit();
}

var sel_file;

$(document).ready(function(){
	$("#file").on("change", handleImgFileSelect);
});

function handleImgFileSelect(e){
	var files = e.target.files;
	var filesArr = Array.prototype.slice.call(files);
	
	filesArr.forEach(function(f){
		if(!f.type.match("image.*")){
			alert('이미지 파일만 업로드 가능합니다!');
			return;
		}
		sel_file = f;
		
		var reader = new FileReader();
		reader.onload = function(e){
			$("#img").attr("src", e.target.result);
		}
		reader.readAsDataURL(f);
	});
}
</script>
<div class="w3-container w3-card w3-white w3-round w3-margin">
	<div class="col-xl-10 col-lg-12 col-md-10">
		<div class="card o-hidden border-0 shadow-lg my-5">
			<div class="card-body p-0">
				<!-- Nested Row within Card Body -->
				<div class="container">
					<div class="section">
						<div class="row">
							<div class="col-md-12">
								<form name="mf" role="form" class="form-horizontal" onsubmit="return regi()"
								action="#" method="POST" enctype="multipart/form-data">
									<div class="form-group">
										<div class="col-sm-2">
											<label for="name" class="control-label">이름</label>
										</div>
										<div class="col-sm-3">
											<input type="text" class="form-control" id="name"
												placeholder="성함을 입력하세요" name="name">
										</div>
									</div>
									<div class="form-group">
										<div class="col-sm-2">
											<label for="nick_name" class="control-label">닉네임</label>
										</div>
									
										<div class="col-sm-3">
											<input type="text" class="form-control" id="nick_name"
												placeholder="닉네임 중복체크를 해주세요" name="nick_name" readonly>
										</div>
										<div class="col-sm-2">
											<button type="button" onclick="nickCheck()"
												class="btn btn-danger">중복체크</button>
										</div>
									</div>
									
									<div class="form-group">
										<div class="col-sm-2">
											<label for="profile" class="control-label">프로필 사진</label>
										</div>
										<div class="col-sm-3">
											<input type="file" name="file" id="file" class="control-label">10Mb 이하,
												권장사이즈 180x180, 240x280 jpg,png,jpeg
										</div>
										<div class="col-sm-2">
											<img id="img" class="img-responsive">
										</div>
									</div>
									
									<div class="form-group">
										<div class="col-sm-2">
											<label for="userid" class="control-label">아이디</label>
										</div>
										<div class="col-sm-3">
											<input type="text" class="form-control" id="userid"
												placeholder="아이디 중복체크를 해주세요" name="userid" readonly>
										</div>
										<div class="col-sm-2">
											<button type="button"  onclick="idCheck()"
												class="btn btn-danger">중복체크</button>
										</div>
									</div>
									
									<div class="form-group">
										<div class="col-sm-2">
											<label for="pwd" class="control-label">비밀번호</label>
										</div>
										<div class="col-sm-3">
											<input type="password" class="form-control" id="pwd"
												name="pwd" placeholder="비밀번호">
										</div>
									</div>
									
									<div class="form-group">
										<div class="col-sm-2">
											<label for="pwd2" class="control-label">비밀번호 확인</label>
										</div>
										<div class="col-sm-3">
											<input type="password" class="form-control" id="pwd2"
												placeholder="비밀번호 확인" name="pwd2">
										</div>
									</div>
									
									<div class="form-group">
										<div class="col-sm-2">
											<label for="email" class="control-label">이메일</label>
										</div>
										<div class="col-sm-4">
											<input type="email" class="form-control" id="email"
												placeholder="abc123@naver.com" name="email">
											<div class="checkbox">
												<label> <input type="checkbox" id="email_check">이메일 수신 동의
												</label>
											</div>
										</div>
									</div>
									
									<div class="form-group">
										<div class="col-sm-2">
											<label for="birth" class="control-label">생년월일</label>
										</div>
										<div class="col-sm-3">
											<input type="text" class="form-control" id="birth"
												placeholder="2020/03/25 형태로 입력해주세요" name="birth">
										</div>
									</div>
									
									<div class="form-group">
										<div class="col-sm-2">
											<label for="hp" class="control-label" contenteditable="true">연락처</label>
										</div>
										<div class="col-sm-1">
											<select id="tel" name="tel" class="form-control"
												style="width: 6em">
												<option value="skt">SKT</option>
												<option value="kt">KT</option>
												<option value="lgt">LGT</option>
												<option value="else">알뜰폰</option>
											</select>
										</div>
										
										<div class="col-sm-1">
											<select id="hp1" name="hp1" class="form-control"
												style="width: 6em">
												<option value="010">010</option>
												<option value="011">011</option>
												<option value="016">016</option>
												<option value="017">017</option>
												<option value="018">018</option>
												<option value="019">019</option>
											</select>
										</div>
										
										<div class="col-sm-1">
											<input type="text" maxlength="4" class="form-control"
												id="hp2" placeholder="1234" name="hp2">
										</div>
										<div class="col-sm-1">
											<input type="text" maxlength="4" class="form-control"
												id="hp3" placeholder="5678" name="hp3">
										</div>
									</div>
									<div class="form-group">
										<div class="col-sm-2">
											<label for="post" class="control-label">우편번호</label>
										</div>
										<div class="col-sm-1">
											<input type="text" class="form-control" id="post"
												placeholder="" name="post" maxlength="5" readonly required>
										</div>
										<div class="col-sm-2">
											<button type="button" onclick="openDaumZipAddress();"
												class="btn btn-danger">우편번호체크</button>
										</div>
									</div>
									
									<div class="form-group">
										<div class="col-sm-2">
											<label for="addr" class="control-label">주소</label>
										</div>
										<div class="col-sm-3">
											<input type="text" class="form-control" id="addr1"
												placeholder="우편번호 체크를 통해 입력해주세요" name="addr1" readonly>
											<input type="text" class="form-control" id="addr2"
												name="addr2" placeholder="나머지 주소">
										</div>
										
									</div>
									<!-- -------------------------------------------------------------------------- -->
									
									
								
									
									<div id="wrap" style="display:none;border:1px solid #DDDDDD;width:500px;margin-top:5px"></div>
									<div class="form-group">
										<div class="col-sm-offset-2 col-sm-8">
										
											<div class="col-sm-4">
												<button type="button" id="service" onclick="rgCheck()" class="btn btn-danger">이용약관보기</button>
												<label> <input type="checkbox" id="check" disabled>약관 동의 완료</label>
											</div>
						
										</div>
									</div>
									<div class="form-group">
										<div class="col-sm-offset-2 col-sm-10">
											<button type="button" class="btn btn-success" onclick="go(1)">회원가입</button>
											<button type="button" class="btn btn-danger" onclick="go(2)">취소</button>
										</div>
									</div>
								</form>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>



<script>

function openDaumZipAddress() {
	var element_wrap = document.getElementById("wrap");
	if (jQuery("#wrap").css("display") == "none") {
		new daum.Postcode({
			oncomplete : function(data) {
				jQuery("#post").val(data.zonecode);
				jQuery("#addr1").val(data.address);
				jQuery("#addr2").focus();
				console.log(data);
			},
			onclose : function(state) {
				if (state === "COMPLETE_CLOSE") {
					offDaumZipAddress(function() {
						element_wrap.style.display = "none";
					});
				}
			}
		}).embed(element_wrap);
		jQuery("#wrap").slideDown();
	} else {
		offDaumZipAddress(function() {
			element_wrap.style.display = "none";
			return false;
		});
	}
}
function offDaumZipAddress() {
	jQuery("#wrap").slideUp();
}

</script>



<c:import url="/foot_before/" />