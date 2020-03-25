package tis.sns.board.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import tis.sns.board.domain.BoardVO;
import tis.sns.board.domain.replyVO;
import tis.sns.board.mapper.BoardMapper;

@Service
public class BoardServiceImpl implements BoardService {
	
	@Inject
	private BoardMapper boardMapper;

	@Override
	public int insertBoard(BoardVO vo) {
		return this.boardMapper.insertBoard(vo);
	}

	@Override
	public int deleteBoard(String key) {
		return this.boardMapper.deleteBoard(key);
	}

	@Override
	public int updateBoard(BoardVO vo) {
		return this.boardMapper.updateBoard(vo);
	}

	@Override
	public List<BoardVO> listBoard(String title) {
		return this.boardMapper.listBoard(title);
	}
	
	@Override
	public List<BoardVO> list_all_Board(){
		return this.boardMapper.list_all_Board();
	}

	@Override
	public BoardVO selectOne(String key) {
		return this.boardMapper.selectOne(key);
	}

	@Override
	public int insertReply(replyVO vo) {
		return this.boardMapper.insertReply(vo);
	}

	@Override
	public int deleteReply(String key) {
		return this.boardMapper.deleteReply(key);
	}
	
	@Override
	public int totalBoard(String name) {
		return this.boardMapper.totalBoard(name);
	}
	
	@Override
	public int total_all_Board() {
		return this.boardMapper.total_all_Board();
	}
	
	@Override
	public List<replyVO> getAllReply(String boardnum){
		return this.boardMapper.getAllReply(boardnum);
	}

}
