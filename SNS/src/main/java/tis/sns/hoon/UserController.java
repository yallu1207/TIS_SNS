package tis.sns.hoon;

import java.awt.Graphics;
import java.awt.Image;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import javax.imageio.ImageIO;
import javax.inject.Inject;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import lombok.extern.log4j.Log4j;
import tis.sns.common.CommonUtil;
import tis.sns.user.domain.UserVO;
import tis.sns.user.service.UserService;

@Controller
@Log4j
public class UserController {
	
	@Inject
	private CommonUtil util;
	
	@Inject
	private UserService userSvc;
	
	
	@RequestMapping("/register")
	public String register() {
		
		return "/member/register";
	}
	
	@RequestMapping("/idCheck")
	public String idCheck_Form() {
	
		return "/member/idCheck";
	}
	
	@RequestMapping("/nickCheck")
	public String nickCheck_Form() {
	
		return "/member/nick_check";
	}
	
	
	  @GetMapping(value="/id_check", produces="application/json; cahrset=UTF-8")
	  public @ResponseBody Map<String, Integer> id_check(
	  @RequestParam("userid") String userid ) 
	  {
	  
	  //log.info("id_check Controller ==="+userid);
	  //System.out.println("id_check Controller ==="+userid); 
	  
		  boolean canUse=this.userSvc.idCheck(userid); 
		  
		  int n=(canUse)?1:-1; 
		  
		  Map<String,Integer> map=new HashMap<>(); 
		  map.put("canUse",n);
		  
		  return map;
	  
	  }//----------id-------------------------
	
	
	  @GetMapping(value="/nick_check", produces="application/json; cahrset=UTF-8")
	  public @ResponseBody Map<String, Integer> nick_check(
	  @RequestParam("userid") String userid ) 
	  {
	  
		  boolean canUse=this.userSvc.nickCheck(userid); 
		  
		  int n=(canUse)?1:-1; 
		  
		  Map<String,Integer> map=new HashMap<>(); 
		  map.put("canUse",n);
		  
		  return map;
	  
	  }//-------------nick--------------------------
	  
	  @GetMapping("/rgCheck")
	  public String rgCheck() {
		  return "member/rgCheck";
	  }
	  
	  //@RequestMapping(value="/registerEnd", method=RequestMethod.POST)
	  @PostMapping("/registerEnd")	//Multi-part 일때는 반드시 postMapping
	  public String userJoin(
			  @ModelAttribute UserVO user, 
			  @RequestParam("file") MultipartFile mfilename, 
			  HttpServletRequest req, Model model) {
			
		  //=================
		  
		 
		  	String filename=mfilename.getOriginalFilename();
			long fsize=mfilename.getSize();
			String fname="";
			
			//System.out.println("원본파일명:"+filename+"//파일크기:"+fsize);
			
			ServletContext ctx = req.getServletContext();
			String profile_origin=ctx.getRealPath("/profile_origin");	
			String profile_convert=ctx.getRealPath("/profile_convert");	
			
			File dir1=new File(profile_origin);
			File dir2=new File(profile_convert);
			if(!dir1.exists()) { dir1.mkdirs(); }
			if(!dir2.exists()) { dir2.mkdirs(); }

			if(!mfilename.isEmpty()) {
				//원본 파일 업로드 하기
				try {
					mfilename.transferTo(new File(profile_origin, filename));
					
					//사진 원하는 크기로 자르기-------------------------------------------------
					String originPath =dir1.getAbsolutePath()+"\\"+filename;
					
					System.out.println("profile= "+originPath);

					Image image = ImageIO.read(new File(originPath));
					
					Image resize = image.getScaledInstance(180, 200, Image.SCALE_SMOOTH);
					//Image resize = image.getScaledInstance(250, 300, Image.SCALE_SMOOTH);
					
					BufferedImage result=new BufferedImage(180,200,BufferedImage.TYPE_INT_RGB);
					//BufferedImage result=new BufferedImage(250,300,BufferedImage.TYPE_INT_RGB);
					Graphics g = result.getGraphics();
					
				    g.drawImage(resize, 0, 0, null);
				    g.dispose();
				
				    UUID uuid=UUID.randomUUID();
				    
					fname=uuid.toString()+"_"+filename;
				
					ImageIO.write(result, "jpg", new File(profile_convert+File.separator+fname));
					//사진 원하는 크기로 자르기----------------------------------------------------
					
				
				}
				catch(IOException e) {
					log.error("파일업로드 중 에러 : "+e.getMessage());
				}	
				
			}
		  
		  //==================
			user.setProfile(fname);
			log.info("profile()="+user.getProfile());
			int n=0;
		
			n=this.userSvc.createUser(user);
			
			String str=(n>0)?"회원가입 성공":"회원가입 실패";
			String loc=(n>0)?"index":"javascript:history.back()";

			
			model.addAttribute("msg",str);
			model.addAttribute("loc",loc);
			return "message";
	  }//--------------------------------------------------------------------
	
	  @RequestMapping("/user/myPage")
	  public String myPage(HttpSession ses, Model m) {
		  
		  UserVO user=(UserVO)ses.getAttribute("loginUser");
		  m.addAttribute("loginUser", user);
		  
		  return "/member/myPage";
	  }//-----------------------------------------------------------------------
	  
	  
	  //=======#######################
	  
	  @PostMapping("/user/myPageEnd")
	  public String myPageEnd(
			  @ModelAttribute UserVO user, 
			  @RequestParam("file") MultipartFile mfilename, 
			  @RequestParam("idx") Integer idx,
			  HttpServletRequest req, Model model, HttpSession ses)
	  {
		  //-------파일업로드---------------
		  String filename=mfilename.getOriginalFilename();
			long fsize=mfilename.getSize();
			String fname="";

			//System.out.println("원본파일명:"+filename+"//파일크기:"+fsize);
			
			ServletContext ctx = req.getServletContext();
			String profile_origin=ctx.getRealPath("/profile_origin");	
			String profile_convert=ctx.getRealPath("/profile_convert");	
			
			File dir1=new File(profile_origin);
			File dir2=new File(profile_convert);
			if(!dir1.exists()) { dir1.mkdirs(); }
			if(!dir2.exists()) { dir2.mkdirs(); }

			if(!mfilename.isEmpty()) {
				//원본 파일 업로드 하기
				try {
					mfilename.transferTo(new File(profile_origin, filename));
					
					//사진 원하는 크기로 자르기-------------------------------------------------
					String originPath =dir1.getAbsolutePath()+"\\"+filename;
					
					System.out.println("profile= "+originPath);

					Image image = ImageIO.read(new File(originPath));
					
					Image resize = image.getScaledInstance(180, 200, Image.SCALE_SMOOTH);
					//Image resize = image.getScaledInstance(250, 300, Image.SCALE_SMOOTH);
					
					BufferedImage result=new BufferedImage(180,200,BufferedImage.TYPE_INT_RGB);
					//BufferedImage result=new BufferedImage(250,300,BufferedImage.TYPE_INT_RGB);
					Graphics g = result.getGraphics();
					
				    g.drawImage(resize, 0, 0, null);
				    g.dispose();
				
				    UUID uuid=UUID.randomUUID();
				    
					fname=uuid.toString()+"_"+filename;
				
					ImageIO.write(result, "jpg", new File(profile_convert+File.separator+fname));
					//사진 원하는 크기로 자르기----------------------------------------------------
					
				
				}
				catch(IOException e) {
					log.error("파일업로드 중 에러 : "+e.getMessage());
				}	
				
			}
		  
		  //-----------------------------
			
			UserVO uservo=(UserVO)ses.getAttribute("loginUser");
			user.setProfile(fname);
			user.setIdx(idx);
			user.setName(uservo.getName());
			//user.setIdx(Integer.parseInt(idx));
			//log.info("profile()="+user.getProfile());
			int n=0;
			//=============================
			System.out.println("############################################");
			System.out.println("myPageEnd 에서 Value : "+
								"parameter idx : "+idx+" / "+
								"getidx : "+user.getIdx()+" / "+
								"getName : "+user.getName()+" / "+
								"getNick_name : "+user.getNick_name()+" / "+
								"getProfile : "+user.getProfile()+" / "+
								"getUserid : "+user.getUserid()+" / "+
								"getPwd : "+user.getPwd()+" / "+
								"getEmail : "+user.getEmail()+" / "+
								"getBirth : "+user.getBirth()+" / "+
								"getHp1 : "+user.getHp1()+" / "+
								"getHp2 : "+user.getHp2()+" / "+
								"getHp3 : "+user.getHp3()+" / "+
								"getPost : "+user.getPost()+" / "+
								"getAddr1 : "+user.getAddr1()+" / "+
								"getAddr2: "+user.getAddr2()+" / ");
			System.out.println("############################################");
			//======================================
			n=this.userSvc.updateUser(user);
			
			System.out.println("#### n = "+n);
			
			String str=(n>0)?"수정 성공":"수정 실패";
			String loc=(n>0)?"main":"javascript:history.back()";

			
			model.addAttribute("msg",str);
			model.addAttribute("loc",loc);
			return "message";
			
	  }//-----------------------------------------------------------------------
	  
	  @RequestMapping("/find")
	  public String find() {
		  
		  return "/member/find";
	  }//-----------------------------------------------------------------------------
	  
	  
	  @GetMapping(value="/find_userid", produces="application/json; cahrset=UTF-8")
	  public @ResponseBody Map<String, String> find_userid(
			  @RequestParam("name") String name,
		  	  @RequestParam("birth") String birth,
		  	  HttpSession ses
		  	  ) 
	  {
		  
		  
		  System.out.println("name="+name);
		  System.out.println("birth="+birth);
		  
		  UserVO user=new UserVO();
		  
		  user.setName(name);
		  user.setBirth(birth);
		  
		  String userid = this.userSvc.find_userid(user);
		  System.out.println("컨트롤러에서 userid = "+userid);
		  
		  Map<String, String> map=new HashMap<>();
		  map.put("find", userid);
		  System.out.println("map에 저장된 값 : "+map.get("find"));
		  
		  return map;
	  }
	

}
