package tis.sns.board.domain;

import java.sql.Timestamp;

import lombok.Data;
@Data
public class replyVO {
	private String reply_num;
	private String board_num;
	private String content;
	private String author;
	private java.sql.Timestamp wdate;
	
	
	public replyVO() {}
	
	public replyVO(String reply_num, String board_num, String content, String author, Timestamp wdate) {
		super();
		this.reply_num = reply_num;
		this.board_num = board_num;
		this.content = content;
		this.author = author;
		this.wdate = wdate;
	}
	

}
