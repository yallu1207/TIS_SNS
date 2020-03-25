package tis.sns.meeting.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import tis.sns.board.domain.BoardVO;
import tis.sns.meeting.domain.PagingVO;
import tis.sns.meeting.mapper.MainMapper;



@Service("mainServiceImpl")
public class MainServiceImpl implements MainService {

	@Inject
	private MainMapper mainMapper;
	
	@Override
	public List<BoardVO> listBoardAllPaging(PagingVO paging) {
		return mainMapper.listBoardAllPaging(paging);
	}

	@Override
	public List<BoardVO> listBoardAll(){
		return mainMapper.listBoardAll();
	}
	
	@Override
	public int insertBoard(BoardVO vo) {
		return mainMapper.insertBoard(vo);
	}

	@Override
	public int getTotalCount(PagingVO paging) {
		return mainMapper.getTotalCount(paging);
	}

}
