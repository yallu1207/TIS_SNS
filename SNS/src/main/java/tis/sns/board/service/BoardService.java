package tis.sns.board.service;

import java.util.List;

import tis.sns.board.domain.BoardVO;
import tis.sns.board.domain.replyVO;

public interface BoardService {
	
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
