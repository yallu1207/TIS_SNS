package tis.sns.board.mapper;

import java.util.List;

import tis.sns.board.domain.BoardVO;
import tis.sns.board.domain.replyVO;


public interface BoardMapper {

	int insertBoard(BoardVO vo);
	
	int deleteBoard(String key);
	
	int updateBoard(BoardVO vo);
	
	List<BoardVO> listBoard(String title);
	
	List<BoardVO> list_all_Board();
	
	BoardVO selectOne(String key);
	
	int insertReply(replyVO vo);
	
	int deleteReply(String key);
	
	int totalBoard(String name);
	
	int total_all_Board();

	List<replyVO> getAllReply(String boardnum);

	
}
