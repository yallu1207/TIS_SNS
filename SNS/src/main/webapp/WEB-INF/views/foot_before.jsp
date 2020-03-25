<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <% String myctx = request.getContextPath();%>

      <!-- 메인 컬럼 div 끝 -->
      </div>
      
      <!-- 오른쪽 배너 시작 -->
      <div class="w3-col m2 d-none d-xl-block">
        
        <!-- 오른쪽 배너 div 1 -->
        <div class="w3-card w3-round w3-white w3-padding-16 w3-center">
          <img src="https://modo-phinf.pstatic.net/20200102_22/1577944179008MGII3_GIF/mosaSqPQt1.gif?type=w556" style="width:100%;">
        </div>
        <br>
        오른쪽 배너 div 2
        <div class="w3-card w3-round w3-white w3-padding-16 w3-center">
          <img src="https://modo-phinf.pstatic.net/20191030_168/1572415465932AjaBn_GIF/mosad6fBrG.gif?type=w556" style="width:100%;">
        </div>
        <br>
        
      <!-- 오른쪽 베너 끝 -->
      </div>
      
    <!-- 메인 그리드 끝 -->
    </div>
    
  <!-- Page Container 끝 -->
  </div>
  <br>
  
  
  
  
<%--  <%@ include file="/WEB-INF/views/member/loginModal.jsp" %>
  --%>
 
 
  <!-- Footer -->
<!--   <footer class="w3-col w3-container w3-padding-12 w3-dark-grey">
  <div class="w3-row-padding">
    <div class="w3-third">
      <h3>FOOTER</h3>
      <p> Made By - TIS Project Group </p>
    </div>
  </div>
  </footer> -->
  
   <footer class="w3-container w3-padding-32 w3-dark-grey">
  <div class="w3-row-padding">
    <div class="w3-third col-md-12" align="center">
      <img src="<%=myctx%>/images/logo.png" style="width: 80px;height: 40px;align:center;margin:5px" alt="todayLogo">
      <p>Welcom to TODAY</p>
    </div>
  </div>
  </footer>
   <div class="w3-black w3-center w3-padding-24">TIS Information Technology Education Center</div>
  
<!--  <div class="w3-black w3-center w3-padding-24">TIS SNS Test Page</div> -->
  <!-- Footer -->
  
 


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