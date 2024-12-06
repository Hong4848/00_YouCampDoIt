package com.kh.youcamp.cart.model.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.youcamp.cart.model.vo.Cart;
import com.kh.youcamp.member.model.vo.Member;

@Repository
public class CartDao {

	public ArrayList<Cart> selectList(SqlSessionTemplate sqlSession, Member m) {
		return (ArrayList)sqlSession.selectList("cartMapper.selectCartList");
	}

}
