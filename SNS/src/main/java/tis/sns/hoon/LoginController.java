package tis.sns.hoon;

import java.util.Collections;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import lombok.extern.log4j.Log4j;
import tis.sns.board.domain.BoardVO;
import tis.sns.board.service.BoardService;
import tis.sns.common.CommonUtil;
import tis.sns.meeting.service.MainService;
import tis.sns.user.domain.NotUserException;
import tis.sns.user.domain.UserVO;
import tis.sns.user.service.UserService;

@Controller
@Log4j  
public class LoginController {
	
	@Autowired
	private CommonUtil util;
	
	@Inject
	private UserService userService;
	
	@Inject 
	private MainService mainService;
	
	
	@Inject
	private BoardService boardSvc;

	@RequestMapping(value="/login", method=RequestMethod.POST)
	public String loginCheck(
			@RequestParam(name="userid",defaultValue="") String userid,
			@RequestParam(defaultValue="") String pwd, 
			@RequestParam(defaultValue="false") boolean customCheck,
			Model model, HttpSession ses, HttpServletResponse res
			) throws NotUserException {
		
			//log.info("userid="+userid+", pwd="+pwd+", customCheck="+customCheck);
			
			//1. 유효성 체크
			if(userid.trim().isEmpty()||pwd.isEmpty()) {
				return "redirect:index";
			}
			
			System.out.println("userid : "+userid);
			System.out.println("pwd : "+pwd);
			
			//2. 로그인 인증처리 메소드 호출 
			UserVO loginUser=userService.isLoginOk(userid,pwd);
			
			if(loginUser != null) {
				ses.setAttribute("loginUser",loginUser);
			/*
			 * ses.setAttribute("loginUser", loginUser.getNick_name());
			 * ses.setAttribute("userMode", loginUser.getM_state());
			 */
				Cookie ck=new Cookie("uid",loginUser.getUserid());
				
				//아이디 저장에 체크했다면
				if(customCheck) {
					ck.setMaxAge(7*24*60*60);	//7일간 유효
				}
				else {
					ck.setMaxAge(0);
				}
				ck.setPath("/");
				//response에 쿠키 추가
				res.addCookie(ck);
			}//---------------------------------------------
			
			//return "redirect:main";
			
			//List<BoardVO> boards=this.boardSvc.list_all_Board();
			//Collections.reverse(boards);
			
			
			//model.addAttribute("boardlist", boards);
			
			List<BoardVO> boards=this.mainService.listBoardAll();
			Collections.reverse(boards);
			
			model.addAttribute("boardlist", boards);
			
			return "/main";

	}//-----------------------------------------------------------------------
	
	@RequestMapping("/logout")
	public String logout(HttpSession ses) {
		ses.invalidate();
		return "redirect:index";
	}
	
}
