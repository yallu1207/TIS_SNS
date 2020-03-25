package tis.sns.user.domain;

import java.io.Serializable;

import lombok.Data;
// DB의 MEMBER 테이블 VO 입니다.

@Data
public class UserVO implements Serializable {
	
	private int idx;
	private String name;
	private String nick_name;
	private String userid;
	private String email;
	private String pwd;
	private String birth;
	private String hp1;
	private String hp2;
	private String hp3;
	private String post;
	private String addr1;
	private String addr2;
	private java.sql.Date indate;
	private int mileage;
	private int m_state;
	private String profile;

	
}
