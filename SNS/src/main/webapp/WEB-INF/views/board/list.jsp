<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%-- 로그인 여부를 체크하는 모듈을 inlcude(소스를 포함시키는 방식으로) --%>
<!-- --------------------------------------------------- -->
<%@ include file="./detail.jsp" %> 
<!-- --------------------------------------------------- -->
    
<c:import url="/top/" />

<%	
	String ctx = request.getContextPath();	
	int count = 0;

%>
<style>
	.box img:hover {
		transform:scale(1.5);		/*이미지 확대*/
		transition:transform.3s;	/*마우스 오버시 사진이 커지고 작아지는 시간 설정*/
	}
	table{
		border-spacing:1px;
		border-collapse:separate;
	}
	#show_img{
		align:center;
		width:50px;
		height:50px;
		margin:'3px';
	}
</style>

<div class="container">

<%-- ${boardlist} 
 --%>
<div class="col-md-8">
<h3 text-align="center" class="col-md-offset-3"> </h3>

	<c:if test="${boardlist == null || empty boardlist }">
		<tr>
			<td colspan="5" text-align="center"><b>게시글이 없습니다.</b></td>
		</tr>
	</c:if>
	
	
	<!-- <div class="col-md-10 col-md-offset-3"> -->
	<div class="col-md-10 col-md-offset-1">
	<!-- <table class="w3-table w3-center"> -->
	<table class="table table-responsive">
		<tr>
			<c:forEach var="list" items="${boardlist}" varStatus="state">
			
				<td id="show_img">
					<div class="box">
					
						<!-- ========================================================== -->
							<a href="#detail" data-toggle="modal" onclick="send(${list.boardnum})">
								<c:if test="${list.addr ne null}">
									<img src="../convert/${list.addr}" class="img img-responsive" style="width:100%; height:auto;">
								</c:if>
								<%-- <img src="../convert/${list.addr}" class="w3-responsive"> --%>
								
							</a>
						
						
					</div>
					
				</td>
				
				
				<c:if test="${(state.count%4) eq 0}"></tr><tr></c:if>
				
			</c:forEach>
		</tr>	
	</table>
	</div>
	
	
	
	<!-- <hr color='red'> -->
</div>
</div>

<script>
	function send(i){
		//alert('${list.addr}');
		
		
		//document.getElementById('#reply').value = null;		//이전에 작성되어 있던 댓글 지우기
		//이전에 입력한 댓글 값 지우기
		//$('#reply').html('');
		//$('#form_id input[type="text"]').val(""); 
		$('#reply').val('');
		//이전에 작성되어 있던 댓글 지워주기
		
		$.ajax({
			type:'GET',
			url:"detail?boardnum="+i,
			dataType:'json',		//응답유형 json
			cache:false,
			success:function(res){
				
			//alert(res.title);	
			//alert(res.content);
			//alert(res.boardnum);
			//alert(res.addr);
			
			//: json객체를 문자열로 나열해서 보여줌(직렬화)
			//JSON.parse(문자열) : 문자열을 파싱하여 JSON객체로 만들어줌
			//console.log(JSON.stringify(res));
			//showData(res);
			//alert(res.content);
			$('#content').html(res.content);	//div의 경우
			$('#content2').val(res.content);	//input의 경우
			$('#boardnum').html(res.boardnum);
			$('#boardnum2').val(res.boardnum);
			//alert(JSON.stringify(parseInt(res.wdate.year)+1900));
			
			//alert(parseLong(res.wdate)+"<<<");
			var time=Number(res.wdate);
			var d=new Date();
			d.setTime(time);
		
			/* var time="업로드 날짜 : "
			+JSON.stringify(parseInt(res.indate.year)+1900)+"년 "
			+JSON.stringify(parseInt(res.indate.month)+1)+"월 "
			+JSON.stringify(parseInt(res.indate.date))+"일 "
			+JSON.stringify(parseInt(res.indate.hours))+"시 "
			+JSON.stringify(parseInt(res.indate.minutes))+"분 "
			+JSON.stringify(parseInt(res.indate.seconds))+"초 ";  */
			//alert(time);
		
			/* 이 부분 사용하기~~~~~~~~~~~~~~~~~~~~~~~~~ */
			//alert(res.wdate);
			//alert("getFullYear : "+d.getFullYear()); 
			//alert("getMonth : "+d.getMonth()+1);
			//alert("getDay : "+d.getDay());
			//alert("getHours : "+d.getHours());
			//alert("getMinutes : "+d.getMinutes());
			//alert("getSeconds : "+d.getSeconds());
			
			//alert(d.getDay());
			
			var date="작성일 : "+d.getFullYear()+"년 "+(d.getMonth()+1)+"월 "+d.getDate()+"일 "+
					showDay(d.getDay())+" "+d.getHours()+"시 "+d.getMinutes()+"분 "+d.getSeconds()+"초 ";
	
			//$('#time').html(time);
			$('#time').html(date);
			
			
			//alert(res.addr);
			//alert(res.boardnum);
			//$('#reply').html(res.content);
			$('#author').html(res.author);
			
			if('${loginUser.nick_name}'==res.author){
				
				$('#show1').show();
				$('#show2').show();
			}
			else{
				
				$('#show1').hide();
				$('#show2').hide();
			}
			
			
			
			$('#bimg').attr('src','../convert/'+res.addr);
			$('#bimg2').val('../convert/'+res.addr);
			
							
			showReply(res.replyList); 
			},
			error:function(e){
				alert('error:'+e.status);
			}
		})
	}//send()----------------------------------------------------------------------------
	
 	function showDay(day){
		var str='';
		switch(day){
			case 0:str='일요일'; break;
			case 1:str='월요일'; break;
			case 2:str='화요일'; break;
			case 3:str='수요일'; break;
			case 4:str='목요일'; break;
			case 5:str='금요일'; break;
			case 6:str='토요일'; break;
		}
		return str;
	}//========================================================================
	
	function showReply(replyList){
		$('#re').html('');

		$.each(replyList, function(index, item){
			// $.each(obj, function(index, item){ }) 
			// 객체(obj)를 전달받으면 index는 객체의 key(property)를 가리키고
			// item은 키의 값을 가져온다.
			
			var time=Number(item.wdate);
			var d=new Date();
			d.setTime(time);
			
			var date=d.getFullYear()+"년 "+(d.getMonth()+1)+"월 "+d.getDate()+"일 "+
			showDay(d.getDay())+" "+d.getHours()+"시 "+d.getMinutes()+"분 "+d.getSeconds()+"초";
			
			
			
			var str = "<div>"+item.author+" | "+item.content
					+"<br>"+date;
			
			if('${loginUser.nick_name}'==item.author){
				//alert('test');
				str+="<a href='<%=ctx%>/user/delete_reply?reply_number="+item.reply_num+"'> 삭제</div>";
			}
					
																			 
			$('#re').append(str);

		})
		
	}//showReply()------------------------------------------------------------------------------
</script>

<c:import url="/foot/"/>
