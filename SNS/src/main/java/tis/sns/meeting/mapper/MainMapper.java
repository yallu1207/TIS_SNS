package tis.sns.meeting.mapper;

import java.util.List;

import tis.sns.board.domain.BoardVO;
import tis.sns.meeting.domain.PagingVO;


public interface MainMapper {

	List<BoardVO> listBoardAllPaging(PagingVO paging);
	int insertBoard(BoardVO vo);
	int getTotalCount(PagingVO paging);
	List<BoardVO> listBoardAll();
	
	
}
