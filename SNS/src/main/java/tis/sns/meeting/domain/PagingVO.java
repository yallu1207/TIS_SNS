package tis.sns.meeting.domain;

import lombok.Data;

@Data
public class PagingVO {
	//페이징 처리관련 프로퍼티 선언
	private int cpage=1;//현재 보여줄 페이지 번호(디폴트 1페이지)
	private int pageSize=5; //한 페이지 당 보여줄 목록 갯수
	private int totalCount;//총 게시글 수
	private int pageCount;//페이지 수
	
	//DB에서 레코드를 끊어 가져오기 위한 시작값과 끝값 프로퍼티
	private int start;
	private int end;
	
	//페이징 블럭 처리를 위한 프로퍼티
	private int pagingBlock=5; //한 블럭당 보여줄 페이지 갯수(디폴트 5개)
	private int prevBlock; //이전 5개
	private int nextBlock; //이후 5개
	
	//검색 관련 프로퍼티 선언
	private String searchType; //검색유형
	private String keyword; //검색어
	
	public PagingVO() {
		
	}
	
	public PagingVO(int cpage, int pageSize, int totalCount, int pagingBlock) {
		this.cpage=cpage;
		this.pageSize=pageSize;
		this.totalCount=totalCount;
		this.pagingBlock=pagingBlock;
		//페이징 처리 관련 연산을 수행하는 메소드 호출
		init();
		//////////////////////////////////////////////
	}

	/** 페이징 처리 관련 연산을 수행하는 사용자 정의 메소드 */
	public void init() {
		pageCount=(totalCount-1)/pageSize +1;
		if(cpage<1) {
			cpage=1;//cpage값이 1보다 작을 때는 1페이지로 디폴트
		}
		if(cpage>pageCount) {
			cpage=pageCount;//cpage의 값이 더 클 때는 마지막 페이지로 설정
		}
		
		end=cpage*pageSize;
		start=end-(pageSize-1);
		
		//페이징블럭 : 이전 5개, 이후 5개 구하는 로직
		prevBlock=(cpage-1)/pagingBlock*pagingBlock;
		nextBlock=prevBlock + (pagingBlock+1);
		
	}//init()------------------------------------------

	/*	 <페이징블럭 구조>
	 * [1][2][3][4][5]	|	[6][7][8][9][10]	|	[11][12][13][14][15]	|	[16]...
	 *  
	 * 	cpage					pagingBlock			prevBlock			nextBlock
	 * 1,2,3,4,5					5							0						6
	 *	6,7,8,9,10					5							5						11
	 *	11,12,13,14,15			5							10						16
	 *	
	 *	prevBlock=(cpage-1)/pagingBlock*pagingBlock;
	 *	nextBlock=prevBlock + (pagingBlock+1);
	 * */
	
	/**페이징 네비게이션 문자열을 반환하는 메소드*/
	public String getPageNavi(String myctx, String loc) {
		//myctx: 컨텍스트명. Spring03Web
		//loc : 경로   /board/list
		//qStr: query string (검색시 필요-검색유형, 키워드)
		searchType=(searchType==null)?"":searchType;
		keyword=(keyword==null)?"":keyword;
		
		String qStr="?searchType="+searchType+"&keyword="+keyword;
		//String의 불변성 때문에 StringBuffer 또는 StringBuilder를 
		//이용하자.
		StringBuffer buf=new StringBuffer()  //문자열 편집하는 클래스
		.append("<ul class='pagination pagination-sm'>");
		
		if(prevBlock>0) {//이전 5개
			buf.append("<li><a href='"+myctx+"/"+loc+qStr+"&cpage="+prevBlock+"'>");
			buf.append("Prev</a></li>");
		}
		for(int i=prevBlock+1;i<=nextBlock-1 && i<=pageCount ;i++) {
			
			if(i==cpage) {
			buf.append("<li class='active'><a href='#'>")
				.append(i+"</a></li>");
			}else {
			buf.append("<li><a href='"+myctx+"/"+loc+qStr+"&cpage="+i+"'>");
			buf.append(i+"</a></li>");
			}
			
		}
		if(nextBlock<=pageCount) {//이후 5개
			buf.append("<li><a href='"+myctx+"/"+loc+qStr+"&cpage="+nextBlock+"'>");
			buf.append("Next</a></li>");
		}
		
		buf.append("</ul>");
		String str=buf.toString();
		//System.out.println(str);
		return str;
	}//getPageNavi()------------------------------------------
	
}
