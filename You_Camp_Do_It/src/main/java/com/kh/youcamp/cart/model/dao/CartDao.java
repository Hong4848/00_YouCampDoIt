package com.kh.youcamp.cart.model.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.youcamp.cart.model.vo.Cart;
import com.kh.youcamp.member.model.vo.Member;

@Repository
public class CartDao {

	public ArrayList<Cart> selectList(SqlSessionTemplate sqlSession, int memberNo) {
	    return (ArrayList) sqlSession.selectList("cartMapper.selectList", memberNo);
	}

//	public int deleteCart(SqlSessionTemplate sqlSession, String[] cartNoList) {
//		return sqlSession.delete("cartMapper.deleteCart", cartNoList);
//	}
	public int deleteCart(SqlSessionTemplate sqlSession, String cartNos) {
		return sqlSession.delete("cartMapper.deleteCart", cartNos);
	}


}
