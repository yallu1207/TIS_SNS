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


$(function(){
	$('#name').focus(); // userid창에 포커스
})



	function set(index){
		
		if(index==1){	//아이디 찾기
		
			if(!$('#name').val()){
				alert("이름을 입력하세요");
				mf.name.focus();
				return;
			}
			if(!$('#birth').val()){
				alert("생년월일을 입력하세요");
				mf.birth.focus();
				return;
			}
			  
			//alert("mf.name.value"+mf.name.value);
			//alert("mf.birth.value"+mf.birth.value);
			
			var name=$('#name').val();
			var birth=$('#birth').val();
			
			
			//alert("name"+name);
			//alert("birth"+birth);
		
			
			$.ajax({
				type:'GET',
				url:'find_userid?name='+name+'&birth='+birth,
				dataType:'json',
				cache:false,
				success:function(res){
					
					var str=""
					if(res.find!=null){
						str="회원님의 아이디는 "+res.find+" 입니다.";
					}
					else{
						alert('회원정보가 존재하지 않습니다.');
						str="";
					}
					
					$('#idMsg').html(str);
			
				},
				error:function(err){
						alert('error:'+err.status);
					}
				})
			
		}
		else if(index==2){	//창닫기
			self.close();
		}
		
	}
</script>


</head>
<body>

	<div class="container">
		<div class="row" style="margin-top: 30px">
		
		
		<form name="mf" role="form" class="form-horizontal">
		
		
				<label for="uid" class="col-xs-3">이름</label>
				
				<div class="col-xs-8">
					<input type="text" name="name" id="name" class="form-control" placeholder="이름입력하세요" required>
				</div>
				<br><br>
				
				<label for="birth" class="col-xs-3">생년월일</label>
				
				<div class="col-xs-8">
					<input type="text" name="brith" id="birth" class="form-control" placeholder="생년월일을 입력하세요( 2020/03/25)" required>
				</div>
				<br>
				
				<span class="text-danger col-xs-12" id="idMsg"></span>
				
				<div class="col-xs-8 col-offset-2">
					<button type="button" class="btn btn-success" onclick="set(1)">아이디 찾기</button>
					<button type="button" class="btn btn-danger" onclick="set(2)">취소</button>
				</div>
		 </form>
		</div>
	</div>

</body>
</html>