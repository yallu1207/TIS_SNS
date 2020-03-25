package tis.sns.meeting.mapper;

import java.util.List;

import tis.sns.meeting.domain.MeetingVO;
import tis.sns.meeting.domain.PagingVO;



public interface MeetingMapper {
	
	int insertMeeting(MeetingVO meeting);
	List<MeetingVO> selectAllList(PagingVO paging);
	MeetingVO selectOneList(int midx);
	int getTotalCount(PagingVO paging);
	int updateMeeting(MeetingVO vo);
	int updateApply(int midx);
	int updateRstate(int midx);
	int meetingClose(int midx);
	
}
