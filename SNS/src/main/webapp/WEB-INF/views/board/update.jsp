<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:import url="/top/" />
<!DOCTYPE html>
<script type="text/javascript">
	$(function() {
		$('#btnWrite').click(function() {
			if (!$('#content').val()) {
				alert('하고싶은 말을 입력하세요');
				$('#subject').focus();
				return;
			}
			
		var reg = new RegExp("jpg|jpeg|png|gif|bmp");
			
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
	
	// 입력한 글자의 byte수를 확인하는 함수 부분 시작
    var oldStr, oldCnt;
    function checkByte(element){
        var onechar;
        var tcount=0;
        for(k=0; k<element.value.length; k++){
            onchar=element.value.charAt(k);
            if(escape(onechar).length>4){
                tcount+=2;
            }
            else if(onechar!='\r'){
                tcount++;
            }
        }
        if(tcount>1000){
            document.bf.cbyte.value=tcount;   
            alert('허용된 글자수가 초과되었습니다.\r\n 초과된 부분은 자동으로 삭제됩니다');
            element.value=oldStr;
            tcount=oldCnt;
        }
        oldStr=element.value;
        oldCnt=tcount;
        document.bf.cbyte.value=tcount;   
    }// checkbyte----------------
    
    
    // 이미지 파일 실시간 변환하는 부분
    var sel_file;
    $(document).ready(function(){
    	$("#file").on("change", change_img);
    });//-------------------------------------------------------

    function change_img(e){
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
    			$("#file_img").attr("src", e.target.result);
    		}
    		//alert("f : "+JSON.stringify(f))
    		reader.readAsDataURL(f);
    	});
    }//---------------------------------------------------
	
</script>

<% String ctx = request.getContextPath(); %>

<div class="container">
<div class="row">
<div class="col-md-8">

	<!--파일 업로드시
	method: POST
	enctype: multipart/form-data
	C:\MyJava\Workspace\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\MvcShop\Upload
	  -->	
	<form name="bf" id="bf" role="form" action="update2" method="POST" enctype="multipart/form-data">
	<input type="hidden" name="boardnum" value="${boardnum}">
 	<table class="table table-bordered">
 		<tr>
 			<td>
				<img src="${filename}" id="file_img" style="width:100%">
			</td>
 			<td style="width:80%">
 				<span id="name"> ${userName} 님 게시물 수정을 환영합니다~ </span><br><br>
 				※ 게시물 업로드시 주의사항<br>
 					1. 냔냔냐<br>
 					2. 뇸뇬뇸<br>
 					3. 룐륜류
 			</td>
 		</tr> 		
 		<tr>
			<td colspan="2">
			<input type="file" name="file" id="file" class="form-control">
			</td>
		</tr>
 		<tr>
 			<td colspan="2">
 			<textarea name="content" id="content" name="content" rows="10" cols="50" class="form-control" 
 			placeholder="하고싶은말을 입력하세요~" onkeyup="checkByte(this)">${content}</textarea>
 			</td>
 		</tr>
		<tr>
			<td colspan="2">
				<button type="button" id="btnWrite" class="btn btn-success" >글쓰기</button>
				<button type="reset" id="btnReset" class="btn btn-warning">다시쓰기</button>
				<input type="text" id="byte" name="cbyte" class=byte value="0" size="3" text-align="left">/1000Byte(한글 500자)<br>
			</td>
		</tr>
	</table>
	</form>	    
</div>
</div>
</div>

<c:import url="/foot/" />