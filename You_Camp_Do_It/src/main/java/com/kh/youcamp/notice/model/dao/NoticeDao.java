package com.kh.youcamp.notice.model.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.youcamp.common.model.vo.PageInfo;
import com.kh.youcamp.notice.model.vo.Notice;

@Repository
public class NoticeDao {

	public int selectListCount(SqlSessionTemplate sqlSession, HashMap<String, String> searchMap) {
		// select(단일행) : selectOne 메소드
		return sqlSession.selectOne("noticeMapper.selectListCount", searchMap);
	}

	public ArrayList<Notice> selectList(SqlSessionTemplate sqlSession, PageInfo pi, HashMap<String, String> searchMap) {
		// select(여러행) : selectList 메소드
		
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit(); // 0 이 되게끔
		int limit = pi.getBoardLimit();								 // 100 으로
		
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		
		return (ArrayList) sqlSession.selectList("noticeMapper.selectList", searchMap, rowBounds);
	}

	public int increaseCount(SqlSessionTemplate sqlSession, int noticeNo) {
		// update문 : update 메소드
		return sqlSession.update("noticeMapper.increaseCount", noticeNo);
	}

	public Notice selectNotice(SqlSessionTemplate sqlSession, int noticeNo) {
		// select(단일행) : selectOne 메소드
		return sqlSession.selectOne("noticeMapper.selectNotice", noticeNo);
	}
	
	// 이전글 가져오기
    public Notice getPreviousNotice(SqlSessionTemplate sqlSession, int noticeNo) {
        return sqlSession.selectOne("noticeMapper.getPreviousNotice", noticeNo);
    }

    // 다음글 가져오기
    public Notice getNextNotice(SqlSessionTemplate sqlSession, int noticeNo) {
        return sqlSession.selectOne("noticeMapper.getNextNotice", noticeNo);
    }

    // 전체 공지사항 번호 가져오기 (옵션으로 유지)
    public List<Integer> getAllNoticeNumbers(SqlSessionTemplate sqlSession) {
        return sqlSession.selectList("noticeMapper.getAllNoticeNumbers");
    }

	public int insertNotice(SqlSessionTemplate sqlSession, Notice n) {
		// insert 구문 : insert 메소드
		return sqlSession.insert("noticeMapper.insertNotice", n);
	}

	public int deleteNotice(SqlSessionTemplate sqlSession, int noticeNo) {
		// update 문 : update 메소드
		return sqlSession.update("noticeMapper.deleteNotice", noticeNo);
		
	}

	public int updateNotice(SqlSessionTemplate sqlSession, Notice n) {
	    return sqlSession.update("noticeMapper.updateNotice", n);
	}
	
	

	public ArrayList<Notice> ajaxNoticeSelect(SqlSessionTemplate sqlSession, PageInfo pi, String state) {
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		int limit = pi.getBoardLimit();
		
		RowBounds rowBounds 
				= new RowBounds(offset, limit);
		
		return (ArrayList)sqlSession.selectList("noticeMapper.ajaxNoticeSelect", state, rowBounds);
	}

	public int ajaxSelectListCount(SqlSessionTemplate sqlSession, String state) {
		return sqlSession.selectOne("noticeMapper.ajaxSelectListCount", state);
	}

	public int totalCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("noticeMapper.totalCount");
	}

	public int exitCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("noticeMapper.exitCount");
	}

	public int activeCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("noticeMapper.activeCount");
	}
	


}
