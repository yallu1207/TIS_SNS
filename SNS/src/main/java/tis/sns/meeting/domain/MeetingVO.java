package tis.sns.meeting.domain;

import java.io.Serializable;
import java.util.Date;

import lombok.Data;

@Data
public class MeetingVO implements Serializable{

	private int idx;
	private int midx;
	private String category;
	private String meetName;
	private String meetContent;
	private Date mdate;
	private String mdateStr;
	private int personnel;
	private String leader;
	private String hp1;
	private String hp2;
	private String hp3;
	private String place;
	private String meetPwd;
	private String image;
	private String originImage;
	private String mtime;
	
	private int rstatus;
	private int rpersonnel;

}
