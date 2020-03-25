<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%-- <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> --%>
<%
	String myctx = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<script type="text/javascript"
	src="http://cdnjs.cloudflare.com/ajax/libs/jquery/2.0.3/jquery.min.js"></script>
<script type="text/javascript"
	src="http://netdna.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
<link
	href="http://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.3.0/css/font-awesome.min.css"
	rel="stylesheet" type="text/css">
<link href="<%=myctx%>/css/form1.css" rel="stylesheet" type="text/css">
<title>아이디 중복 체크</title>


<script>

var flag=false;
//var idReg = /^[a-z]+[a-z0-9]{5,19}$/g;
var idReg = /^[ㄱ-ㅎ|ㅏ-ㅣ|가-힣|a-z|A-Z|0-9]{1,7}$/g;


$(function(){
	$('#uid').focus(); // userid창에 포커스
})

var change=function(){
	$('#uid').attr("readonly",false);
	$('#useid_use').hide();
	$('#useid_change').hide();
}


var idCheck=function(){
	
	var uid=$('#uid').val();
	//alert(uid);
	
	//정규식
	if( !idReg.test( $("input[name=uid]").val() ) ) {
         alert("닉네임은 2~8자 이내의 한글과 영어, 숫자만 가능합니다. (특수문자 사용불가)");
         return;
    }
	
	$.ajax({
		type:'GET',
		url:'nick_check?userid='+uid,
		dataType:'json',
		cache:false,
		success:function(res){
			var str='';
			if(res.canUse>0){
				str=uid+"는 사용가능합니다.";	
				flag=true;
				$('#useid_use').show();
				$('#uid').attr("readonly",true);
				$('#useid_change').show();
			}
			else{
				str=uid+"는 이미 사용중입니다.";
				flag=false;
				$('#useid').hide();
			}
			
			$('#idMsg').html(str);
	
			},
			error:function(err){
				alert('error:'+err.status);
			}
		})
	
}//-----------------------------------------
</script>
</head>
<body>

	<div class="container">
		<div class="row" style="margin-top: 30px">
			<!-- <form name="idf" id="idf" action="id_check" method="post"> -->
				<label for="userid" class="col-xs-2">닉네임</label>
				<div class="col-xs-8">
					<input type="text" name="uid" id="uid" class="form-control" 
					onkeypress="if( event.keyCode==13 ){ idCheck();}"
					placeholder="아이디를 입력하세요" required>
				</div>
	
				<div class="col-xs-2">
					<!-- <button class="btn btn-primary">확인</button> -->
					<button class="btn btn-primary" onclick="idCheck()" >확인</button>
				</div>
				
				<br>
				<span class="text-danger col-xs-12" id="idMsg"></span>
				
				<div class="col-xs-10 col-offset-2">
					<button class="btn btn-primary" style="display:none" id="useid_use" onclick="set()">사용하기</button>
					<button class="btn btn-primary" style="display:none" id="useid_change" onclick="change()">다른 닉네임 찾기</button>
				</div>
		</div>
	</div>

	

<script>
	function set(){
		//alert(uid);
		opener.document.mf.nick_name.value=$('#uid').val();
		// 열었던 페이지의 form mf에 저장 후 닫음
		self.close();
	}
</script>
</body>
</html>