<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!--  top -->
<jsp:include page="../top.jsp" />
<!--  top -->
<script>
$(function(){
	$('#btnUpdate').click(function(e){
		e.preventDefault();
		var category=$('#category>option:selected').val();
		if(!category){
			alert('관심분야를 선택해주세요.');
			$('#category').focus();
			return;
		}
		var meetingName=$('#meetName').val();
		if(!meetingName){
			alert('모임명을 작성해 주세요.');
			return;
		}
		var leader=$('#leader').val();
		if(!leader){
			alert('모임장의 닉네임을 작성해 주세요.');
			$('leader').focus();
			return;
		}

		//오늘날짜
		var today=new Date();
		var dd=today.getDate();
		var mm=today.getMonth()+1;
		var yyyy=today.getFullYear();
		if(mm<10){
			mm="0"+mm;
		}
		if(dd<10){
			dd="0"+dd;
		}
		var day=""+yyyy+mm+dd;
		//입력받은 날짜
		var mdate=$('#mdate').val();
		var dateO=mdate.split('-');
		var date=dateO[0]+dateO[1]+dateO[2];
		//오늘날짜보다 입력받은 날짜가 작으면 입력불가
		//alert(day+"/"+date);
		if(date<day){
			alert('오늘 날짜보다 이전의 날짜입니다. 다시 선택해 주세요.');
			return;
		}
		if(!$('#mdate').val()){
			alert('모임날짜를 입력해주세요.');
			return;
		}
		
		var hp1=$('#hp1').val();
		var hp2=$('#hp2').val();
		var hp3=$('#hp3').val();
			if(!hp1||!hp2||!hp3){
				alert('연락처를 작성해 주세요.');
				return;
			}
		if(!$('#meetPwd').val()){
			alert('비밀번호를 작성해 주세요.');
			return;
		}
		//alert($('#mf').attr('action'));
		$('#mf').submit();
	})
});
</script>
<!-- 주소 검색 API -->
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js" ></script>
<script>
    function pSearch() {
        new daum.Postcode({
            oncomplete: function(data) {
            	var roadAddr = data.roadAddress; // 도로명 주소 변수
                $('#place').val(roadAddr);
            }
        }).open();
    }
</script>
    <!-- Input Your JSP Code Start-->
	<h1 align="center">소모임 정보 수정</h1>
            <form class="form-horizontal" role="form"  id="mf"  name="mf" action="write" method="post"  enctype="multipart/form-data">
            <input type="hidden" name="idx" value="${meeting.idx}">
            <input type="hidden" name="mode" value="edit">
              <div class="form-group">
                <div class="col-sm-3">
                  <label for="input" class="control-label">글번호</label>
                </div>
                <div class="col-sm-6">
                  <input type="text" class="form-control" value="${meeting.midx}" id="midx" name="midx" readonly>
                </div>
              </div>
              <div class="form-group">
                <div class="col-sm-3">
                  <label for="inputEmail3" class="control-label">관심분야</label>
                </div>
                <div class="col-sm-6">
                  <select class="form-control" name="category" id="category" name="category">
                    <option value="">========== 모집 분야 ==========</option>
                    <option value="book">독서/토론</option>
                    <option value="outdoor">아웃도어/운동</option>
                    <option value="study">공부</option>
                    <option value="culture">예술/대중문화</option>
                    <option value="language">어학</option>
                    <option value="computer">전자/컴퓨터</option>
                    <option value="health">건강/의학</option>
                    <option value="history">역사/문화</option>
                    <option value="productions">수집/제작</option>
                    <option value="music">음악/연주</option>
                  </select>
                </div>
              </div>
              <div class="form-group">
                <div class="col-sm-3">
                  <label for="inputEmail3" class="control-label">모임명</label>
                </div>
                <div class="col-sm-6">
                  <input type="text" class="form-control" id="meetName" name="meetName" value="${meeting.meetName}">
                </div>
              </div>
              <div class="form-group">
                <div class="col-sm-3">
                  <label for="inputEmail3" class="control-label"></label>
                </div>
                <div class="col-sm-6">
                  <img src="../images/${meeting.image}" class="img img-responsive" style="width:340px;height:340px" id="image" name="image">
                  <input type="hidden" name="old_file" value="${meeting.image}">
                  <input type="hidden" name="old_originfile" value="${meeting.originImage}">
                  <input type="file" id="image" name="mimage">
                </div>
              </div>
              <div class="form-group">
                <div class="col-sm-3">
                  <label for="inputEmail3" class="control-label">모임내용</label>
                </div>
                <div class="col-sm-6">
                  <input type="text" class="form-control" id="meetContent" name="meetContent" value="${meeting.meetContent}" style="word-break:break-all">
                </div>
              </div>
              <div class="form-group">
                <div class="col-sm-3">
                  <label for="inputEmail3" class="control-label">모임날짜</label>
                </div>
                <div class="col-sm-3">
                  <input type="date" class="form-control" id="mdate" name="mdateStr" placeholder="">
                </div>
                <div class="col-sm-3">
                  <input type="text" class="form-control" id="mtime" name="mtime" value="${meeting.mtime}" placeholder="">
                </div>
              </div>
              <div class="form-group">
                <div class="col-sm-3">
                  <label for="text" class="control-label">모집인원</label>
                </div>
                <div class="col-sm-6">
                  <input type="text" class="form-control" id="personnel" name="personnel" value="${meeting.personnel}" placeholder="최소 2명 ~ 최대 999명">
                </div>
              </div>
              <div class="form-group">
                <div class="col-sm-3">
                  <label for="text" class="control-label">모임장</label>
                </div>
                <div class="col-sm-6">
                  <input type="text" class="form-control" id="leader"  name="leader" value="${meeting.leader}" readonly>
                </div>
              </div>
              <div class="form-group">
                <div class="col-sm-3">
                  <label for="text" class="control-label">연락처</label>
                </div>
                <div class="col-sm-2">
                  <input type="text" class="form-control" id="hp1" name="hp1" placeholder="000" value="${meeting.hp1}">
                </div>
                <div class="col-sm-2">
                  <input type="text" class="form-control" id="hp2" name="hp2" placeholder="0000" value="${meeting.hp2}">
                </div>
                <div class="col-sm-2">
                  <input type="text" class="form-control" id="hp3" name="hp3" placeholder="0000" value="${meeting.hp3}">
                </div>
              </div>
              <div class="form-group">
                <div class="col-sm-3">
                  <label for="text" class="control-label">장소</label>
                </div>
                <div class="col-sm-4">
                  <input type="text" class="form-control" id="place" name="place" value="${meeting.place}">
                </div>
                <div class="col-sm-2">
                 <button type="button" class="btn btn-primary" id="btnSearch" name="place" onclick="pSearch()">찾기</button>
                </div>
              </div>
              <div class="form-group">
                <div class="col-sm-3">
                  <label for="inputPassword3" class="control-label">비밀번호</label>
                </div>
                <div class="col-sm-6">
                  <input type="password" class="form-control" id="meetPwd" name="meetPwd" required>
                </div>
              </div>
              <div class="form-group">
                <div class="col-sm-4">
                  <button type="button" class="btn btn-default" onclick="location.href='list'">목록으로</button>
                  <button type="button" class="btn btn-primary" id="btnUpdate">수정하기</button>
                </div>
              </div>
            </form>

    <!-- Input Your JSP Code End-->
<!--  foot -->
<jsp:include page="../foot.jsp" />
<!--  foot -->