package tis.sns.hoon;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class IndexController {

	@RequestMapping("/top")
	public void showTop() {
		
	}
	
	@RequestMapping("/foot")
	public void showFoot() {

	}
	
	@RequestMapping("/top_before")
	public void showTop_before() {
		
	}
	
	@RequestMapping("/foot_before")
	public void showFoot_before() {

	}
	
	
	@RequestMapping("/index")
	public String hello(Model m) {
		//m.addAttribute("msg","Annotation을 이용한 방식의 Spring");
		return "index";	//뷰 네임을 문자열로 반환
		// "WEB-INF/views/index.jsp"를 찾아감
	}
	
	@RequestMapping("/main")
	public String main(Model m) {
		
		return "main";	
		// "WEB-INF/views/index.jsp"를 찾아감
	}
	
}
