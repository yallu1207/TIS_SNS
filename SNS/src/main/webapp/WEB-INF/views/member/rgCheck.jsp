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
<title>이용약관</title>


<script>


</script>
</head>
<body>

	<div class="container">
		<div class="row" style="margin-top: 30px">
			<form name="rg" role="form" onsubmit="return set()">
				<h1 style="color:red">### 이용약관 ###</h1>
				<br>
				<h3>1. &&&&&&&& </h3>
				<h3>2. ******** </h3>
				<h3>3. ######## </h3>
				<h3>4. @@@@@@@@ </h3>
				<h3>5. 99999999 </h3>
			
				<br><br>
				
				<div class="checkbox">
					<label> <input type="checkbox" id="service">이용약관에 동의합니다.</label>
				</div>
				<button type="submit" class="btn btn-success">확인</button>
			</form>
		</div>
	</div>

	

<script>

//var flag=false;


	function set(){
		//if(rg.service.value==true){
		if($('input:checkbox[id="service"]').is(":checked"))
		{
			// 속성은 다음과 같이 바꾼다.
			opener.document.mf.check.disabled=false;
			opener.document.mf.check.checked=true;
			opener.document.mf.check.disabled=true;
			//$('#check').val('Y');
			//$('input:checkbox[id="check"]')val(":checked");
			//flag=true;
			
			// 열었던 페이지의 form mf에 저장 후 닫음
			//alert("check - true");
			opener.flag3=true;
			self.close();
		}
		//alert("false에서");
		else{ 
			//flag=false;
			//alert("check - false");
			opener.document.mf.check.disabled=false;
			opener.document.mf.check.checked=false;
			opener.document.mf.check.disabled=true;
			opener.flag3=false;
			self.close();
		}
	}
</script>
</body>
</html>