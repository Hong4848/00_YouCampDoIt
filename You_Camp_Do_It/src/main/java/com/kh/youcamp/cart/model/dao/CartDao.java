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

	public int deleteCart(SqlSessionTemplate sqlSession, int cartNo) {
		return sqlSession.delete("cartMapper.deleteCart", cartNo);
	}

	public int updateCartQuantity(SqlSessionTemplate sqlSession, Cart cart) {
		return sqlSession.update("cartMapper.updateCartQuantity", cart);
	}

	public int deleteCartByOrderNo(SqlSessionTemplate sqlSession, int orderNo) {
		return sqlSession.delete("cartMapper.deleteCartByOrderNo", orderNo);
	}

	public int insertCart(SqlSessionTemplate sqlSession, Cart cart) {
		return sqlSession.insert("cartMapper.insertCart", cart);
	}

	public int selectCartCount(SqlSessionTemplate sqlSession, int goodsNo) {
		return sqlSession.selectOne("cartMapper.selectCartCount", goodsNo);
	}


}
