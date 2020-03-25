<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String myctx = request.getContextPath();%>
<!-- 메인 컬럼 div 끝 -->
      </div>
      
      <!-- 오른쪽 배너 시작 -->
      <div class="w3-col m3">
      <!-- 오른쪽 배너 div 1 -->
        <div class="w3-card w3-round w3-white w3-center">
          <div class="w3-container">
            <p></p><br>
            
            <img src="https://t1.daumcdn.net/thumb/R720x0/?fname=http://t1.daumcdn.net/brunch/service/user/oaY/image/LEiOXUCqlODXQfpKLUv4FMugwvs.jpg" 
            		alt="Forest" style="width:100%;">
            		
            <p></p>
            <p><strong>소모임 정보 확인하세요~~</strong></p>
            <p><button class="w3-button w3-block w3-theme-l4" onclick="location.href='<%=myctx%>/meeting/list'">소모임 참여하기</button></p>
          </div>
        </div>
        <br>
        
         <!-- 오른쪽 배너 div 2 -->
        <div class="w3-card w3-round w3-white w3-center">
          <div class="w3-container">
          <br>
            <p>추천 친구</p>
            
            <img src="https://lh3.googleusercontent.com/proxy/pYUalic44uhcubxOHU0H5hYrF48ew999ODreZu_l290swdphHHA2Gj8Gf-bKAZyLk_GcC0Dvc16m2ov25KAkyp_LcrdXUHVomejhfYwzS_UdzfGVaZPj1A" 
                      alt="Avatar" style="width:50%"><br>
                      
            <span>안드로이드</span>
            <div class="w3-row w3-opacity">
              <div class="w3-half">
                <button class="w3-button w3-block w3-green w3-section" title="Accept"><i class="fa fa-check"></i></button>
              </div>
              <div class="w3-half">
                <button class="w3-button w3-block w3-red w3-section" title="Decline"><i class="fa fa-remove"></i></button>
              </div>
            </div>
          </div>
        </div>
        <br>
        
         <!-- 오른쪽 배너 div 3 -->
        <div class="w3-card w3-round w3-white w3-padding-16 w3-center">
          <p>구글 에드센스 광고 칸</p>
        </div>
        <br>
        
         <!-- 오른쪽 배너 div 4 -->
        <div class="w3-card w3-round w3-white w3-padding-32 w3-center">
          <p><i class="fa fa-bug w3-xxlarge"></i></p>
        </div>
        
      <!-- 오른쪽 베너 끝 -->
      </div>
      
    <!-- 메인 그리드 끝 -->
    </div>
    
  <!-- Page Container 끝 -->
  </div>
  <br>

  <!-- Footer -->
  <footer class="w3-container w3-padding-32 w3-dark-grey">
  <div class="w3-row-padding">
    <div class="w3-third col-md-12" align="center">
      <img src="<%=myctx%>/images/logo.png" style="width: 80px;height: 40px;align:center;margin:5px" alt="todayLogo">
      <p>Welcom to TODAY</p>
    </div>
  </div>
  </footer>
  <div class="w3-black w3-center w3-padding-24">TIS Information Technology Education Center</div>

<!-- !페이지 시작 div 끝! -->
</div>

<!-- 아코디언, 사이드바 액션 코드 -->
<script>
// Script to open and close sidebar
function w3_open() {
    document.getElementById("mySidebar").style.display = "block";
    document.getElementById("myOverlay").style.display = "block";
}
 
function w3_close() {
    document.getElementById("mySidebar").style.display = "none";
    document.getElementById("myOverlay").style.display = "none";
}
</script>

</body>
</html>