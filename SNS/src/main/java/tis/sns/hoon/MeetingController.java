package tis.sns.hoon;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

import javax.inject.Inject;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import lombok.extern.log4j.Log4j;
import tis.sns.board.domain.BoardVO;
import tis.sns.common.CommonUtil;
import tis.sns.meeting.domain.MeetingVO;
import tis.sns.meeting.domain.PagingVO;
import tis.sns.meeting.service.MainService;
import tis.sns.meeting.service.MeetingService;

@Controller
@RequestMapping("/meeting")
@Log4j
public class MeetingController {

	@Inject
	private CommonUtil util;
	
	@Inject
	private MeetingService meetingService;	
	
	@Inject 
	private MainService mainService;
	

	
	@RequestMapping("/list")
	public String meetForm(Model m, @ModelAttribute("paging") PagingVO paging) {
		
		log.info("paging="+paging);
		int totalCount=meetingService.getTotalCount(paging);
		paging.setTotalCount(totalCount);
		paging.setPageSize(5);
		paging.setPagingBlock(5);
		paging.init();
		System.out.println("totalCount="+totalCount);
		
		List<MeetingVO> meetingList=meetingService.selectAllList(paging);
		log.info("meetingList="+meetingList);
		
		String myctx="/myapp";
		String loc="meeting/list";
		String pageStr=paging.getPageNavi(myctx, loc);
		
		m.addAttribute("meetingList", meetingList);
		m.addAttribute("totalCount", totalCount);
		m.addAttribute("pageNavi", pageStr);
		m.addAttribute("paging", paging);
		
		return "meeting/meetingList";
	}
	
	@GetMapping("/write")
	public String meetWriteForm(Model m) {
		return "meeting/meetingInsert";
	}
	
	@PostMapping("/write")
	public String meetWrite(Model m, @RequestParam("mimage")MultipartFile mfilename,
											@ModelAttribute("meeting") MeetingVO meeting, 
											@RequestParam(defaultValue="") String mode, 
											@RequestParam(defaultValue="") String old_file,
											HttpServletRequest req) {
		ServletContext ctx=req.getServletContext();
		log.info("mode="+mode);
		log.info("meeting="+meeting);
		log.info("mfilename="+mfilename);
		log.info("ctx="+ctx);
		String upDir=ctx.getRealPath("/images");
		log.info("upDir="+upDir);
		
		File dir=new File(upDir);
		if(!dir.exists()) {
			dir.mkdirs();
		}
		
		if(!mfilename.isEmpty()) {
			String originImage=mfilename.getOriginalFilename();
			UUID uuid=UUID.randomUUID();
			String fname=uuid.toString()+"_"+originImage;
			
			log.info("fname="+fname);
			
			meeting.setOriginImage(originImage);
			meeting.setImage(fname);
			
			try {
				mfilename.transferTo(new File(upDir, fname));
			} catch (IOException e) {
				log.error("소모임 파일 업로드 시 오류 : "+e.getMessage());
			}
			
			if(mode.contentEquals("edit") && !old_file.isEmpty()) {
				File deleteFile=new File(upDir, old_file);
				boolean b=deleteFile.delete();
				log.info("old_file="+old_file+"삭제 처리="+b);
			}
		}
		
		int n=0;
		String msg="";
		if(mode.equals("write")) {
			n=meetingService.insertMeeting(meeting);
			msg="소모임 등록";
		}else if(mode.equals("edit")) {
			n=meetingService.updateMeeting(meeting);
			msg="소모임 정보 수정";
		}
		
		msg+=(n>0)?"이 완료되었습니다.":"이 실패했습니다.";
		String loc=(n>0)?"list":"javascript:history.back()";
		
		return util.addMsgLoc(m, msg, loc);
	}
	
	@GetMapping("/info")
	public String meetInfo(Model m, @RequestParam(defaultValue="0") int midx) {
		
		log.info("midx="+midx);
		
		if(midx==0) {
			return "redirect:list";
		}
		
		MeetingVO meetingInfo=meetingService.selectOneList(midx);
		m.addAttribute("meetingInfo", meetingInfo);
	
		return "meeting/meetingInfo_new";
	}
	
	@PostMapping("/update")
	public String meetUpdate(Model m, @RequestParam(defaultValue="0") int midx,
											@RequestParam(defaultValue="") String mpwd) {
		
		String msg, loc;
		if(midx==0||mpwd==""||mpwd.trim().isEmpty()) {
			msg="잘 못된 경로입니다.";
			loc="javascript:history.back()";
			return util.addMsgLoc(m, msg, loc);
		}
		
		MeetingVO dbMeeting=meetingService.selectOneList(midx);
		String dbPwd=dbMeeting.getMeetPwd();
		
		if(!dbPwd.equals(mpwd)) {
			msg="비밀번호가 일치하지 않습니다.";
			loc="javascript:history.back()";
			return util.addMsgLoc(m, msg, loc);
		}
				
		m.addAttribute("meeting", dbMeeting);
		
		return "meeting/meetingUpdate";
	}
	
	@PostMapping("/apply")
	public String meetApply(Model m, @RequestParam(defaultValue="0") int midx,
											@RequestParam(defaultValue="") String personnel,
											@RequestParam(defaultValue = "") String rpersonnel,
											@RequestParam(defaultValue = "") String rstatus) {
		
		log.info("신청할 소모임의 midx="+midx);
		if(midx==0||personnel==null||personnel.trim().isEmpty()||
			personnel==null||rpersonnel.trim().isEmpty()||rstatus==null||rstatus.trim().isEmpty()) {
			return "redirect:list";
		}
		
		MeetingVO meeting=meetingService.selectOneList(midx);
		
		String msg, loc;
		if(meeting.getRstatus()==2||meeting.getRpersonnel()==meeting.getPersonnel()) {
			msg="현재 모집이 완료된 모임입니다.";
			loc="javascript:history.back()";
			return util.addMsgLoc(m, msg, loc);
		}
		
		int n=this.meetingService.updateApply(midx);
		
		msg=(n>0)?"["+meeting.getMeetName()+"] 소모임 신청이 완료되었습니다.":"소모임 신청이 실패했습니다.";
		loc=(n>0)?"list":"javascript:history.back()";
		
		this.meetingService.updateRstate(midx);
		
		m.addAttribute("meetingInfo", meeting);
		
		return util.addMsgLoc(m, msg, loc);
	}
	
	@PostMapping("/close")
	   public String meetClose(Model m, @RequestParam("cmidx") int midx) {
	      log.info("모집완료할 소모임의 midx="+midx);
	      
	      if(midx==0) {
	         util.addMsgBack(m, "여기 온거면, 잘 못 되었다는 의미!!");
	         return "redirect:list";
	      }
	      int n=meetingService.meetingClose(midx);
	      
	      String msg=(n>0)?"모집완료로 변경되었습니다. ":"모집완료 변경이 실패했습니다.";
	      String loc=(n>0)?"list":"javascript:history.back()";
	      
	      return util.addMsgLoc(m, msg, loc);
	   }
	
}
