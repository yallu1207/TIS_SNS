package tis.sns.meeting.service;

import java.util.List;

import tis.sns.board.domain.BoardVO;
import tis.sns.meeting.domain.PagingVO;


public interface MainService {
	List<BoardVO> listBoardAll();
	
	List<BoardVO> listBoardAllPaging(PagingVO paging);
	int insertBoard(BoardVO vo);
	
	int getTotalCount(PagingVO paging);

}
