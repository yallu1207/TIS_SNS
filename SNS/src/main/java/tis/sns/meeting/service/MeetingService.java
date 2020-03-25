package tis.sns.meeting.service;

import java.util.List;

import tis.sns.board.domain.BoardVO;
import tis.sns.meeting.domain.MeetingVO;
import tis.sns.meeting.domain.PagingVO;

public interface MeetingService {
	
	int insertMeeting(MeetingVO meeting);
	List<MeetingVO> selectAllList(PagingVO paging);
	MeetingVO selectOneList(int midx);
	int updateMeeting(MeetingVO vo);
	int updateApply(int midx);
	int updateRstate(int midx);
	int getTotalCount(PagingVO paging);
	int meetingClose(int midx);
	
}
