package tis.sns.common.interceptor;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import tis.sns.user.domain.UserVO;

import lombok.extern.log4j.Log4j;

/*
 * Interceptor
 * 	- 컨트롤러가 실행되기 전에 사전 처리할 일이 있으면 스프링에서는 인터셉터에서 구현한다.
 * 	- 1. 구현방법
 * 		[1] HandlerInterceptor 인터페이스를 상속받는 방법
 * 		[2] HandlerInterceptorAdapter 추상클래스를 상속받는 방법
 * 
 * 	- 2. 인터셉터 등록 -> shop-context.xml 에서 등록 -> shop-context.xml에서 등록하고 매핑정보를 설정 
 * <!-- interceptor 설정================================================== -->
	<interceptors>
		<interceptor>
			<mapping path="/user"/>
			<mapping path="/admin"/>
			<beans:bean class="com.tis.common.interceptor.LoginCheckInterceptor" />
		</interceptor>
	</interceptors>
	<!-- ================================================================= -->
 * 
 * */
@Log4j
public class LoginCheckInterceptor implements HandlerInterceptor {

	//컨트롤러를 실행하기 전에 호출되는 메소드
	@Override
	public boolean preHandle(HttpServletRequest req, HttpServletResponse response, Object handler)
			throws Exception {
		
		//System.out.println("sys - preHandle() 호출");
		log.info("preHandle() 호출");
		HttpSession ses=req.getSession();
		UserVO user=(UserVO)ses.getAttribute("loginUser");
		if(user!=null) { return true; }	
		
		req.setAttribute("msg", "로그인 해야 이용 가능합니다.");
		req.setAttribute("loc", req.getContextPath()+"/index");
		
		String viewName="/WEB-INF/views/message.jsp";
		RequestDispatcher disp=req.getRequestDispatcher(viewName);
		disp.forward(req, response);
		
		return false;
		//false를 반환하면 Controller까지 못간다.
		
		//return HandlerInterceptor.super.preHandle(request, response, handler);
	}
	
	//컨트롤러를 실행한 후 , 아직 뷰를 실행하기는 전 호출되는 메소드
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		
		//System.out.println("sys - postHandle() 호출");
		log.info("postHandle() 호출");
		
		HandlerInterceptor.super.postHandle(request, response, handler, modelAndView);
	}

	//컨트롤러를 실행하고 뷰를 실행한 후에 호출되는 메소드
	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {

		//System.out.println("sys - afterCompletion() 호출");
		log.info("afterCompletion() 호출");
		
		HandlerInterceptor.super.afterCompletion(request, response, handler, ex);
	}
	
	
	
	
	
}
