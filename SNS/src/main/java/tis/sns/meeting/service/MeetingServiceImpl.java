package tis.sns.meeting.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import tis.sns.board.domain.BoardVO;
import tis.sns.meeting.domain.MeetingVO;
import tis.sns.meeting.domain.PagingVO;
import tis.sns.meeting.mapper.MeetingMapper;



@Service
public class MeetingServiceImpl implements MeetingService {

	@Inject
	private MeetingMapper meetingMapper;
	
	@Override
	public int insertMeeting(MeetingVO meeting) {
		return meetingMapper.insertMeeting(meeting);
	}

	@Override
	public List<MeetingVO> selectAllList(PagingVO paging) {
		return meetingMapper.selectAllList(paging);
	}

	@Override
	public MeetingVO selectOneList(int midx) {
		return meetingMapper.selectOneList(midx);
	}

	@Override
	public int getTotalCount(PagingVO paging) {
		return meetingMapper.getTotalCount(paging);
	}

	@Override
	public int updateMeeting(MeetingVO vo) {
		return meetingMapper.updateMeeting(vo);
	}

	@Override
	public int updateApply(int midx) {
		return meetingMapper.updateApply(midx);
	}

	@Override
	public int updateRstate(int midx) {
		return meetingMapper.updateRstate(midx);
	}
	
	@Override
	public int meetingClose(int midx) {
		return meetingMapper.meetingClose(midx);
	}
}
