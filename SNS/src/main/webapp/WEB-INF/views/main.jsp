<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


<% String myctx = request.getContextPath();%>
<c:import url="/top/" />


<script type="text/javascript">
	$(function(){
		$('#content').focus();
		
		
		$('#btnBoardInput').click(function(e){
			e.preventDefault();
			if(!$('#content').val()){
				alert('글을 작성해 주세요.');
				$('#content').focus();
				return;
			}
			$('#mcf').submit();
		});
	});
	
	
	/* 메인 댓글기능 추가화면 -------------- */
	
	function replyShow(st_index){
		//alert(st_index);
		$('#rf'+st_index).show('slow');
	}
	
	function replyInput(midx, st_index){
		//alert(midx+"/"+st_index+"/");
		if(!$('#comment'+st_index).val()){
			alert('댓글을 작성해 주세요.');
			return;
		}
		$('#rf'+st_index).submit();
		$('#comment'+st_index).val('');
	}
		
	function showReply(idx){
		
		var str = "idx="+idx;
		$.ajax({
			type:'post',
			url: "<%=myctx%>/user/mainReply",
			data: str,
			success:function(res){
				if(res!='-1')
				{
					var tmpp =JSON.parse(res);
					var size = tmpp.length;   /* 반복횟수 */
					var str ='';
					var idx=tmpp[0].board_num;
					console.log(idx);
					for(var i=0;i<size;i++)
						{
						//
							str+="<h4>"+tmpp[i].author+"     ||     "+tmpp[i].wdate+"</h4>";
							str+=tmpp[i].content+"<br>";
						} 
					$('.replyList'+idx).append("<h6>"+str+"</h6>");
				}
			},
			error:function(err){
				alert('error:'+err.status);
			}
			
		})
	}
	
	
</script>
    <!-- Input Your JSP Code Start-->
    <body>
    <div class="w3-row-padding">
          <div class="w3-col m12">
            <div class="w3-card w3-round w3-white">
              <div class="w3-container w3-padding">
                <h3 class="w3-opacity">한 줄 게시글</h3>
                <form name="mcf" id="mcf" action="<%=myctx%>/user/mainInput" method="POST">
	                <input class="form-control input-lg" id="content" name="content" type="text">
	                <input type="hidden" id="author" name="author" value="${loginUser.nick_name}" >
	                <button type="button" class="w3-button w3-theme mt-1" id="btnBoardInput"><i class="fa fa-pencil"></i>글쓰기</button> 
                </form>
              </div>
            </div>
          </div>
        </div> 
        <!-- 반복문 시작 -->
        <c:if test="${boardlist eq null}">
        	<!-- <p>게시글이 존재하지 않습니다.</p> -->
        </c:if>
        
        
        <!-- ================================================================================================= -->
        <!--  -->
        <c:if test="${boardlist ne null}">
      
	        <c:forEach var="boardAll" items="${boardlist}" varStatus="st">
	        <div class="w3-container w3-card w3-white w3-round w3-margin" class="mainBoardArr" id="mainBoardArr${st.index}"><br>
	        
	        <!-- ============================================================= -->
	        
	        <c:choose>
		        <c:when test="${boardAll.profile eq null}">
		          	<%-- <img src="<%=myctx%>/images/noimage.jpg" alt="유저 프로필" class="w3-left w3-circle w3-margin-right" style="width:60px;"> --%>
		          	<img src="<%=myctx%>/images/noimage.PNG" alt="유저 프로필" class="w3-left w3-circle w3-margin-right" style="width:60px;">
		         </c:when>
		         <c:otherwise>
		         	<img src="<%=myctx%>/profile_convert/${boardAll.profile}" alt="유저 프로필" class="w3-left w3-circle w3-margin-right" style="width:60px;">
		         	<%-- <img src="<%=myctx%>/images/noimage.PNG" alt="유저 프로필" class="w3-left w3-circle w3-margin-right" style="width:60px;"> --%>
		         	
		
		         </c:otherwise>
	         </c:choose>
	         
	         <!-- ============================================================= -->
	          
	          
	          
	          <span class="w3-right w3-opacity">${boardAll.wdate}</span>
	          <h4><b>${boardAll.author}</b></h4><br>
	          <p class="text" style="margin-top:5px">${boardAll.title}</p>
	          <hr class="w3-clear">
	          <p>${boardAll.content}</p>
	          <c:if test="${boardAll.addr ne null}">
	          	<img src="<%=myctx%>/convert/${boardAll.addr}"  style="width:100px">
	          </c:if>
	          <hr class="w3-clear">
	          <button type="button" class="w3-button w3-theme-d1 w3-margin-bottom"><i class="fa fa-thumbs-up"></i>  Like</button> 
	          <!-- <button type="button" class="w3-button w3-theme-d2 w3-margin-bottom"><i class="fa fa-comment"></i>  Comment</button>  -->
	          <button type="button" class="w3-button w3-theme-d2 w3-margin-bottom" 
	          			id="btnComment"+${st.index} name="btnComment" onclick="replyShow(${st.index})"><i class="fa fa-comment"></i>  Comment</button>
	          
	           <!-- 댓글 쓰는 부분 -->
	          
	          <form name="rf${st.index}" id="rf${st.index}" style="display: none" action="<%=myctx%>/user/replyWrite" method="post">
	          	<div class="row" style="margin:10px;">
						<div class="w3-col m8" style="margin-left: 70px">
							<input class="form-control input-xs" id="comment${st.index}" name="comment" type="text">
						</div>
						<div class="w3-col m2" style="margin-left: 10px">
							<button type="button" class="w3-button w3-right w3-theme mt-1" id="btnReplyInput${st.index}" onclick="replyInput(${boardAll.boardnum}, ${st.index})">
								<i class="fa fa-pencil"></i>댓글쓰기
							</button>
						</div>
						<input type="hidden" id="board_num" name="board_num" value="${boardAll.boardnum}">
						<input type="hidden" id="nick_name" name="nick_name" value="${loginUser.nick_name}">
					</div>
	          </form>
	          <!-- 댓글 보기 -->
	          <hr class="w3-clear" style="margin:10px">
	          <div id="replyList" class="replyList${boardAll.boardnum}">
	          </div>
	          <script>
	          	showReply('${boardAll.boardnum}');
	          </script>
	          
	          
	        </div>
	        </c:forEach>
	         <!-- 반복문 끝 -->
	    </c:if>
       
        <!-- ================================================================================================= -->
        
        
        
        
        
        
        
    </body>







<c:import url="/foot/"/>
 