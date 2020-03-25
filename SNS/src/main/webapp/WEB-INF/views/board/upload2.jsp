<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!-- taglib 지시어 기술========================== -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- taglib jar 파일(4개) 은 프로젝트(Context)/WEB-INF/lib 아래 붙여넣는다. -->


<c:import url="/top/" />



<!DOCTYPE html>
<style>
	#byte{ text-align: left; }


</style>


<script type="text/javascript">
	
	$(function() {
		
		$('#btnWrite').click(function() {
			
			if (!$('#content').val()) {
				alert('하고싶은 말을 입력하세요');
				$('#content').focus();
				return;
			}

			//alert('${file}');

			$('#bf').submit();
		});
	});
	
	// 입력한 글자의 byte수를 확인하는 함수
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
            document.bf.cbyte.value=tcount;   //수정할 부분
            alert('허용된 글자수가 초과되었습니다.\r\n 초과된 부분은 자동으로 삭제됩니다');
            element.value=oldStr;
            tcount=oldCnt;
        }
        oldStr=element.value;
        oldCnt=tcount;
        document.bf.cbyte.value=tcount;   //수정할 부분
    }// checkbyte----------------
    

</script>

<%
	String ctx = request.getContextPath();
%>

<div class="container">

<div class="col-md-8">
	

			<!--파일 업로드시
	method: POST
	enctype: multipart/form-data
	C:\MyJava\Workspace\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\MvcShop\Upload
	  -->	

	<form name="bf" id="bf" role="form" action="upload3" method="POST" >
		
	<input type="hidden" name="file" value="${file}">
	<!-- 원본글쓰기mode는 write, 답변글쓰기 mode는 rewrite로 감  -->	 	
 	<table class="table table-bordered">
 		
 		<tr>
			
			<td>
			<img src="../convert/${file}">
			<%-- file : ${file} --%>
			</td>
 			<td style="width:80%" text-align="center">
 			<!-- <span id="name">### 님 게시물 작성을 환영합니다~ </span><br><br> -->
 			${userName} 님 게시물 작성을 환영합니다~ <br><br>
 			※ 게시물 업로드시 주의사항<br>
 			1. 냔냔냐<br>
 			2. 뇸뇬뇸<br>
 			3. 룐륜류
 			</td>
		</tr>
 	
 		<tr>
 			
 		</tr> 		
 		
 		<tr>
 			<td style="width:80%" colspan='2'>
 			<textarea name="content" id="content" name="content" rows="10" cols="50" class="form-control" placeholder="하고싶은말을 입력하세요~" onkeyup="checkByte(this)"></textarea>
 			</td>
 		</tr>
 	
		
		<tr>
			<td colspan="2">
				<button type="button" id="btnWrite" class="btn btn-success">글쓰기</button>
				<button type="reset" id="btnReset" class="btn btn-warning">다시쓰기</button>
				<input type="text" id="byte" name="cbyte" class=byte value="0" size="3" text-align="left">/1000Byte(한글 500자)<br>
			</td>
		</tr>
	
		</table>
	</form>	    

</div>
</div>


<c:import url="/foot/" />



