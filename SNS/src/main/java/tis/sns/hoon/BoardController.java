package tis.sns.hoon;

import java.awt.Graphics;
import java.awt.Image;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.util.Collections;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.imageio.ImageIO;
import javax.inject.Inject;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import lombok.extern.log4j.Log4j;
import tis.sns.board.domain.BoardVO;
import tis.sns.board.domain.replyVO;
import tis.sns.board.service.BoardService;
import tis.sns.common.CommonUtil;
import tis.sns.user.domain.UserVO;

@RequestMapping("/user")
@Log4j
@Controller
public class BoardController {
	
	@Inject
	private CommonUtil util;
	
	@Inject
	private BoardService boardSvc;
	
	@GetMapping("/upload")
	public String showForm() {
		return "board/upload";
	}
	
	//-----------------------------------------------------------------------------------1

/*<!-- fileupload를 위한 multipartResolver 빈 등록. 주의 : id는 반드시 multipartResolver로 등록해야 한다.
	다른 아이디를 주면 DispatcherServlet이 MultipartResolver로 인식하지 않는다.
 -->
#shop-context.xml에 아래 빈 등록==============================================
<beans:bean id="multipartResolver" class="org.springframework.web.multipart.commons.CommonsMultipartResolver">
	<beans:property name="maxUploadSize" value="-1" />
	<!-- 최대 업로드 용량 : -1을 주면 무제한 가능함 -->
	<beans:property name="defaultEncoding" value="UTF-8"/>
</beans:bean>
*/
//==========================================================================

	@PostMapping("/upload2")
	public String upload(Model m, 
			@RequestParam("mfile") MultipartFile mfilename, 
			HttpServletRequest req, HttpSession ses) 
	throws Exception
	{
		String filename=mfilename.getOriginalFilename();
		long fsize=mfilename.getSize();
		
		//System.out.println("원본파일명:"+filename+"//파일크기:"+fsize);
		
		ServletContext ctx = req.getServletContext();
		String origin=ctx.getRealPath("/origin");	
		String convert=ctx.getRealPath("/convert");	
		
		
		
		File dir1=new File(origin);
		File dir2=new File(convert);
		if(!dir1.exists()) { dir1.mkdirs(); }
		if(!dir2.exists()) { dir2.mkdirs(); }

		if(!mfilename.isEmpty()) {
			//원본 파일 업로드 하기
			try {
				mfilename.transferTo(new File(origin, filename));
				
				//사진 원하는 크기로 자르기-------------------------------------------------
				String originPath =dir1.getAbsolutePath()+"\\"+filename;
		
				System.out.println("originPath : "+originPath);
				//System.out.println("변경전 file명 : "+filename);
				
				Image image = ImageIO.read(new File(originPath));
				
				Image resize = image.getScaledInstance(180, 200, Image.SCALE_SMOOTH);
				//Image resize = image.getScaledInstance(250, 300, Image.SCALE_SMOOTH);
				
				BufferedImage result=new BufferedImage(180,200,BufferedImage.TYPE_INT_RGB);
				//BufferedImage result=new BufferedImage(250,300,BufferedImage.TYPE_INT_RGB);
				Graphics g = result.getGraphics();
				
			    g.drawImage(resize, 0, 0, null);
			    g.dispose();
			
			    UUID uuid=UUID.randomUUID();

				String fname=uuid.toString()+"_"+filename;
				//log.info("fname="+fname);
				//System.out.println("변경후 file명: "+fname);
			    
			    
				ImageIO.write(result, "jpg", new File(convert+File.separator+fname));
				//사진 원하는 크기로 자르기----------------------------------------------------
				
				UserVO user=(UserVO)ses.getAttribute("loginUser");
				String nick_name = user.getNick_name();
				
				m.addAttribute("file", fname);
				m.addAttribute("userName", nick_name);
			}
			catch(IOException e) {
				log.error("파일업로드 중 에러 : "+e.getMessage());
			}	
			
		}
		
		return "board/upload2";
	}//-----------------------------------------------------------------------------------2
	
	@RequestMapping("/upload3")
	public String upload2(
			@RequestParam("file") String file,  
			@RequestParam("content") String content,
			HttpSession ses, Model m)
	{
		UserVO user=(UserVO)ses.getAttribute("loginUser");
		String name = user.getName();
		//String pwd = user.getPwd();
		String nick_name = user.getNick_name();
		
		System.out.println("name = "+name);
		System.out.println("nick_name = "+nick_name);
		System.out.println("file = "+file);
		
		BoardVO vo = new BoardVO(null,file,name,content,nick_name,null); 
		
		int n = this.boardSvc.insertBoard(vo);
		
		String str=(n>0)?"글쓰기 성공":"글쓰기 실패";
		
		return util.addMsgLoc(m,str,"list?shownum=2");
	
	}//--------------------------------------------------------------------------------------3
	
	@RequestMapping("/list")
	public String list(Model m, HttpSession ses, @RequestParam("shownum") int shownum) {
		
		//System.out.println("shownum = "+shownum);
		List<BoardVO> boards=null;
		
		if(shownum==1) {		// 전체 게시글 가져오기
			boards=this.boardSvc.list_all_Board();
			Collections.reverse(boards);
		}
		else if(shownum==2) {	// 개인 게시글 가져오기
			UserVO user=(UserVO)ses.getAttribute("loginUser");
			boards=this.boardSvc.listBoard(user.getName());
			Collections.reverse(boards);
		}
		
		//m.addAttribute("total",this.boardSvc.totalBoard(user.getNick_name()));
		//m.addAttribute("id", user.getNick_name());
		m.addAttribute("boardlist", boards);
		
		return "/board/list";
		
	}//------------------------------------------------------------------------------------list

	
	@GetMapping(value="/detail", produces="application/json; charset=UTF-8")
	public @ResponseBody BoardVO detail(
			@RequestParam("boardnum") String boardnum,
			Model m
	) 
	{
		List<replyVO> replyArr=this.boardSvc.getAllReply(boardnum);
		
		BoardVO board=this.boardSvc.selectOne(boardnum);
			long time=board.getWdate().getTime();
			log.info("time=="+time);
			Date d=new Date(time);
			board.setWdate2(d);
		board.setReplyList(replyArr);
		
		return board;
	}
	
	@RequestMapping("/update")
	public String update(
			@RequestParam("filename") String filename,
			@RequestParam("boardnum") String boardnum,
			HttpSession ses, Model m) 
	{
		UserVO user=(UserVO)ses.getAttribute("loginUser");
		String nick_name = user.getNick_name();
		m.addAttribute("filename", filename);
		m.addAttribute("boardnum", boardnum);
		m.addAttribute("userName", nick_name);
		
		return "board/update";
	}
	
	@RequestMapping("/update2")
	public String update2(
			@RequestParam("file") MultipartFile filename,
			@RequestParam("content") String content,
			@RequestParam("boardnum") String boardnum,
			HttpServletRequest req,
			HttpSession ses,
			Model m)
	{
		String file=filename.getOriginalFilename();
		long fsize=filename.getSize();
		String fname=null;
		
		ServletContext ctx = req.getServletContext();
		String origin=ctx.getRealPath("/origin");	
		String convert=ctx.getRealPath("/convert");	
		
		File dir1=new File(origin);
		File dir2=new File(convert);
		if(!dir1.exists()) { dir1.mkdirs(); }
		if(!dir2.exists()) { dir2.mkdirs(); }

		if(!filename.isEmpty()) {
			//원본 파일 업로드 하기
			try {
				
				
				filename.transferTo(new File(origin, file));
				
				
				//사진 원하는 크기로 자르기-------------------------------------------------
				String originPath =dir1.getAbsolutePath()+"\\"+file;
				
				Image image = ImageIO.read(new File(originPath));
				
				Image resize = image.getScaledInstance(180, 200, Image.SCALE_SMOOTH);
				
				BufferedImage result=new BufferedImage(180,200,BufferedImage.TYPE_INT_RGB);
				Graphics g = result.getGraphics();
				
			    g.drawImage(resize, 0, 0, null);
			    g.dispose();
			
			    UUID uuid=UUID.randomUUID();

				fname=uuid.toString()+"_"+file;
			    
				ImageIO.write(result, "jpg", new File(convert+File.separator+fname));
				//사진 원하는 크기로 자르기----------------------------------------------------
				
				m.addAttribute("file", fname);
			}
			catch(IOException e) {
				log.error("파일업로드 중 에러 : "+e.getMessage());
			}	
			
		}
		
		UserVO user=(UserVO)ses.getAttribute("loginUser");
		String nick_name = user.getNick_name();
		
		BoardVO vo = new BoardVO(boardnum,fname,null,content,nick_name,null); 
		
		int n = this.boardSvc.updateBoard(vo);
		
		String str=(n>0)?"수정 성공":"수정 실패";
		
		return util.addMsgLoc(m,str,"list?shownum=2");
		
		
	}
	
	@RequestMapping("/delete")
	public String delete(@RequestParam("boardnum") String boardnum, Model m) {
		
		int n=this.boardSvc.deleteBoard(boardnum);
		
		String str=(n>0)?"삭제 성공":"삭제 실패";
		
		return util.addMsgLoc(m,str,"list?shownum=2");
		
	}
	
	@RequestMapping("/write_reply")
	public String write_reply(
			@RequestParam("boardnum") String boardnum,
			@RequestParam("reply") String reply,
			HttpSession ses, Model m)
	{
		UserVO muser=(UserVO)ses.getAttribute("loginUser");
		String name = muser.getName();
		String nick_name= muser.getNick_name();

		replyVO vo = new replyVO(null, boardnum, reply, nick_name, null);
	
		int n=this.boardSvc.insertReply(vo);
		
		String str=(n>0)?"댓글 작성이 완료되었습니다.":"댓글작성실패";
		
		return util.addMsgLoc(m,str,"list?shownum=1");
	}
	
	@RequestMapping("/delete_reply")
	public String write_reply(
			@RequestParam("reply_number") String reply_num, Model m)
	{
		int n=this.boardSvc.deleteReply(reply_num);
		
		//본인만 삭제할 수 있게...
		String str=(n>0)?"댓글이 삭제되었습니다.":"댓글삭제실패";
		
		return util.addMsgLoc(m,str,"list?shownum=1");
	}
	
}



















