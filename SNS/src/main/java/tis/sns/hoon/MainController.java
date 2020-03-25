package tis.sns.hoon;

import java.util.Collections;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;

import lombok.extern.log4j.Log4j;
import tis.sns.board.domain.BoardVO;
import tis.sns.board.domain.replyVO;
import tis.sns.board.service.BoardService;
import tis.sns.common.CommonUtil;
import tis.sns.meeting.service.MainService;
import tis.sns.meeting.service.MeetingService;

@Log4j
@Controller
@RequestMapping("/user")
public class MainController {
	
	@Inject
	private CommonUtil util;
	
	@Inject
	private BoardService boardSvc;
	
	@Inject
	private MeetingService meetingService;	
	
	@Inject 
	private MainService mainService;
	
	

	@RequestMapping("/main")
	public String list(Model m) {
	
		
		List<BoardVO> boards=this.mainService.listBoardAll();
		Collections.reverse(boards);
		
		m.addAttribute("boardlist", boards);
		
		return "/main";
		
	}//------------------------------------------------------------------------------------list
	
	@RequestMapping(value="/mainInput", method=RequestMethod.POST)
	public String boardInput(@ModelAttribute BoardVO vo, Model model) {
	
		int n=this.mainService.insertBoard(vo);
		
		
		String msg=(n>0)?"글쓰기 성공":"글쓰기 실패";
		String loc=(n>0)?"main":"javascript:history.go(-1)";
		
		model.addAttribute("msg", msg);
		model.addAttribute("loc", loc);
		
		return "message";
	}
	
	// replyWrite
		@RequestMapping("/replyWrite")
		public String replyWrite(Model m, HttpSession ses, @RequestParam("board_num") String board_num,
				@RequestParam("nick_name") String nick_name, @RequestParam("comment") String rcontent) {

			log.info("rcontent>>>>>" + rcontent);
			replyVO reply = new replyVO("0", board_num, rcontent, nick_name, null);
			log.info("reply>>>>>" + reply);
			int n = boardSvc.insertReply(reply);

			String msg = (n > 0) ? "댓글이 작성되었습니다." : "댓글 작성에 실패했습니다.";

			return util.addMsgBack(m, msg);
		}
		
		@RequestMapping(value = "/mainReply", method = RequestMethod.POST, produces = "text/plain;charset=UTF-8")
		@ResponseBody
		public String replyList(Model model, String []idx) {
			
			 List<replyVO> replyList=boardSvc.getAllReply(idx[0]);
			 Gson gson = new Gson();
			 if(replyList.isEmpty()) {
				 return "-1";
			 }
			String tmp= gson.toJson(replyList);
			//log.info("idx값 가져오냐>>"+tmp);
			  
			 //model.addAttribute("replyList", replyList);
			 
			 return tmp;

		}
		
		
	
}
