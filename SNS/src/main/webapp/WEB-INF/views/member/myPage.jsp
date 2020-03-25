<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<% String myctx = request.getContextPath();%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/JavaScript" src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>

<c:import url="/top/" />

<script type="text/javascript">

var regex = /^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/;

function go_mypage(index){
	
	if(index==1){
		// 비밀번호 체크------------------
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
		// 공백제거 NULL값 만들기
		//alert('test'+mf.pwd.value);
	/* 	mf.file.value.trim();
		mf.pwd.value.trim();
		mf.email.value.trim();
		mf.hp1.value.trim();
		mf.hp2.value.trim();
		mf.hp3.value.trim();
		mf.post.value.trim();
		mf.addr1.value.trim();
		mf.addr2.value.trim(); */
		//alert('test2');
		
		
		
		
		
		// 비밀번호 체크 -----------------
		// 수정 클릭 후 이동페이지
		document.mf.action='<%=myctx%>/user/myPageEnd';
		//alert("이동경로 : "+document.mf.action);
	}
	
	if(index==2){	// 취소버튼 클릭시 메인화면으로
		document.mf.action='<%=myctx%>/user/main';
	}
	
	//액션
	document.mf.submit();
}//--------------------------------------------------------------------------------------------------

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
								<form name="mf" role="form" class="form-horizontal" onsubmit="return update()"
								action="#" method="POST" enctype="multipart/form-data">
								
								<input type="hidden" name="idx" value="${loginUser.idx}">
								
								
									<div class="form-group">
										<div class="col-sm-2">
											<label for="name" class="control-label">이름</label>
										</div>
										<div class="col-sm-3">
											<input type="text" class="form-control" value="${loginUser.name}" readonly>
										</div>
									</div>
									<div class="form-group">
										<div class="col-sm-2">
											<label for="nick_name" class="control-label">닉네임</label>
										</div>
										<div class="col-sm-3">
												<input type="text" class="form-control" value="${loginUser.nick_name}" readonly>
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
											<img img src="<%=myctx%>/profile_convert/${loginUser.profile}" id="img" class="img-responsive">
										</div>
									</div>
									<div class="form-group">
										<div class="col-sm-2">
											<label for="userid" class="control-label">아이디</label>
										</div>
										<div class="col-sm-3">
											<input type="text" class="form-control" value="${loginUser.userid}" readonly>
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
											<input type="text" class="form-control" value="${loginUser.email}" id="email">
											<div class="checkbox">
												<label> <input type="checkbox">이메일 수신 동의
												</label>
											</div>
										</div>
									</div>
									<div class="form-group">
										<div class="col-sm-2">
											<label for="birth" class="control-label">생년월일</label>
										</div>
										<div class="col-sm-3">
												<input type="text" class="form-control" value="${loginUser.birth}" readonly>
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
											<select id="hp1" name="hp1" class="form-control" value="${loginUser.hp1}"
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
											<input type="text" maxlength="4" class="form-control" id="hp2" value="${loginUser.hp2}">
										</div>
										<div class="col-sm-1">
											<input type="text" maxlength="4" class="form-control" id="hp3" value="${loginUser.hp3}">
										</div>
									</div>
									<div class="form-group">
										<div class="col-sm-2">
											<label for="post" class="control-label">우편번호</label>
										</div>
										<div class="col-sm-2">
											<input type="text" class="form-control" id="post"
												placeholder="10521" name="post" maxlength="5" readonly required>
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
												value="${loginUser.addr1}" name="addr1" readonly>
											<input type="text" class="form-control" id="addr2"
												name="addr2" value="${loginUser.addr2}" >
										</div>
										
									</div>
									
									
									
									<div id="wrap" style="display:none;border:1px solid #DDDDDD;width:500px;margin-top:5px"></div>
									
									
									
									<div class="form-group">
										<div class="col-sm-offset-2 col-sm-10">
											<button type="button" class="btn btn-success" onclick="go_mypage(1)">수정하기</button>
											<button type="button" class="btn btn-warning" onclick="go_mypage(2)">취소</button>
								
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



<c:import url="/foot/" />