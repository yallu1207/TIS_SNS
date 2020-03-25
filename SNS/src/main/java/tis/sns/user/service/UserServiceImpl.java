package tis.sns.user.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import lombok.extern.log4j.Log4j;
import tis.sns.user.domain.NotUserException;
import tis.sns.user.domain.UserVO;
import tis.sns.user.mapper.UserMapper;

@Service
@Log4j
public class UserServiceImpl implements UserService {

	@Inject
	private UserMapper userMapper;
	
	@Override
	public int createUser(UserVO user) {
		return this.userMapper.createUser(user);
	}
	
	@Override
	public int updateUser(UserVO user) {
		return this.userMapper.updateUser(user);
	}

	@Override
	public int getTotalCount() {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<UserVO> getAllUserList(int start, int end) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public boolean idCheck(String userid) {
		int cnt=this.userMapper.idCheck(userid);
		return (cnt>0)?false:true;
	}
	
	@Override
	public boolean nickCheck(String userid) {
		int cnt=this.userMapper.nickCheck(userid);
		return (cnt>0)?false:true;
	}

	@Override
	public UserVO findUserByIdx(String idx) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public UserVO findUserByUserid(String userid) {
		return this.userMapper.findUserByUserid(userid);
	}

	@Override
	public UserVO isLoginOk(String userid, String pwd) throws NotUserException {
		
		
		UserVO dbUser=this.findUserByUserid(userid);
		
		if(dbUser==null) { throw new NotUserException("존재하지 않는 아이디에요"); }
		
		
		if(!dbUser.getPwd().equals(pwd)) {
			throw new NotUserException("비밀번호가 일치하지 않아요");
		}
		return dbUser;
	}
	
	@Override
	public String find_userid(UserVO user) {
		
		String userid=this.userMapper.find_userid(user);
		System.out.println("Mapper 호출 직후 userid = "+userid);
		
		return userid;
	}

}











