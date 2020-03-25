package tis.sns.user.service;

import java.util.List;

import tis.sns.user.domain.NotUserException;
import tis.sns.user.domain.UserVO;

public interface UserService {
	
	int createUser(UserVO user);
	
	int updateUser(UserVO user);
	
	int getTotalCount();
	
	List<UserVO> getAllUserList(int start, int end);
	
	boolean idCheck(String userid);
	
	boolean nickCheck(String userid);
	
	UserVO findUserByIdx(String idx);
	
	UserVO findUserByUserid(String userid);
	
	UserVO isLoginOk(String userid, String pwd) throws NotUserException;
	
	String find_userid(UserVO user);


}
 