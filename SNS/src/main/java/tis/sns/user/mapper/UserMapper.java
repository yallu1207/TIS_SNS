package tis.sns.user.mapper;

import java.util.List;
import tis.sns.user.domain.NotUserException;
import tis.sns.user.domain.UserVO;



//DAO 영속성 계층. context-datasource.xml에 mybatis-spring:scan 에 
//	등록된 패키지의 Mapper인터페이스명과 Mapper.xml 파일의 네임스페이스명을 
//	반드시 동일하게 기술해야 한다.
// 	또한 인터페이스의 추상메소드 이름이 Mapper.xml의 id로 사용된다.
public interface UserMapper {
	

	int createUser(UserVO user);
	
	int updateUser(UserVO user);
	
	int getTotalCount();
	
	List<UserVO> getAllUserList(int start, int end);

	int idCheck(String userid);

	int nickCheck(String userid);
	
	UserVO findUserByIdx(String idx);
	
	UserVO findUserByUserid(String userid);
	
	UserVO isLoginOk(String userid, String pwd) throws NotUserException;
	
	String find_userid(UserVO user);
	
}
