package com.kh.youcamp.lost.model.dao;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.youcamp.common.model.vo.PageInfo;
import com.kh.youcamp.lost.model.vo.Lost;
import com.kh.youcamp.lost.model.vo.LostAttachment;

@Repository
public class LostDao {

	public Lost selectLost(SqlSessionTemplate sqlSession, int lostNo) {
		// select문 (단일행) : selectOne 메소드
		return sqlSession.selectOne("lostMapper.selectLost", lostNo);
	}

	public ArrayList<LostAttachment> selectLostAttachment(SqlSessionTemplate sqlSession, int lostNo) {
		// select문(여러행) selectList 메소드
		return (ArrayList)sqlSession.selectList("lostMapper.selectLostAttachment", lostNo);
	}

	public int selectCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("lostMapper.selectCount");
	}

	public List<Lost> selectLostList(SqlSessionTemplate sqlSession, PageInfo pi) {
		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage()-1)*limit;
		RowBounds rowBounds = new RowBounds(offset, limit);
		return (List)sqlSession.selectList("lostMapper.selectLostList", null, rowBounds);
	}

	public int insertLost(SqlSessionTemplate sqlSession, Lost lost) {
		return sqlSession.insert("lostMapper.insertLost", lost);
	}

	public int insertLostAttachment(SqlSessionTemplate sqlSession, LostAttachment attachment) {
		return sqlSession.insert("lostMapper.insertLostAttachment", attachment);
	}

}
