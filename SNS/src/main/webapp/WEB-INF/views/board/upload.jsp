<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<c:import url="/top/" />

<!DOCTYPE html>

<script type="text/javascript">

$(function() {
	
	$('#btnWrite').click(function() {

		if (!$('#file').val()) {
			alert('파일을 선택해주세요');
			$('#file').focus();
			return;
		}
		
		//var reg = /(.*?)\.(jpg|jpeg|png|gif|bmp)$/;
		var reg = new RegExp("jpg|jpeg|png|gif|bmp");
		//var file_check = $('#file');
		
		var file_check = document.getElementById('file').value;	
		file_check=file_check.slice(file_check.indexOf(".")+1).toLowerCase();
		
	  	if(!file_check.match(reg)) {
	  		alert('이미지 파일만 업로드가 가능합니다.');
	  		$('#file').focus();
	  		return;
	  	}
	  	

		$('#bf').submit();
	});
});


</script>

<div class="container">


<div class="col-md-8">
	
	<h1>업로드할 사진을 선택하세요</h1>
	
	<form name="bf" id="bf" role="form" action="upload2" method="POST" enctype="multipart/form-data">
			
 		<table class="table table-bordered">
 		
 	
		<tr>
			<td style="width: 20%"><b>첨부파일</b></td>
			<td style="width: 80%">
			<input type="file" name="mfile" id="file" class="form-control"></td>
		</tr>
		
		<tr>
			<td colspan="2">
				<button type="button" id="btnWrite" class="btn btn-success">확인</button>
				<button type="reset" id="btnReset" class="btn btn-warning">취소</button>
			</td>
		</tr>
	
		</table>
	
	</form>	    

</div>

</div>

<c:import url="/foot/" />


