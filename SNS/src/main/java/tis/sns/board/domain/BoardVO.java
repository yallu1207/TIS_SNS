package tis.sns.board.domain;

import java.io.Serializable;
import java.util.List;

import lombok.Data;

@Data
public class BoardVO implements Serializable {
	private String boardnum;
	private String addr;
	private String title;
	private String content;
	private String author;
	private java.sql.Timestamp wdate;
	private java.util.Date wdate2;
	private List<replyVO> replyList;
	private String profile;
	
	public BoardVO() {
		
	}
	
	public BoardVO(String boardnum, String addr, String title, String content, String author, java.sql.Timestamp indate) {
		super();
		this.boardnum = boardnum;
		this.addr = addr;
		this.title = title;
		this.content = content;
		this.author = author;
		this.wdate = indate;
	}
	
	



}////////////////////////////////////////
