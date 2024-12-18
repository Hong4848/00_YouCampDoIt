package com.kh.youcamp.reserve.model.service;

import java.util.ArrayList;
import java.util.Map;

import com.kh.youcamp.reserve.model.vo.Reserve;
import com.kh.youcamp.reserve.model.vo.RestSite;

public interface ReserveService {
	
	// 24.12.18 정성민 
	// 예약 관련 서비스 메소드

	// 남은 자리 조회용 서비스 메소드
	ArrayList<RestSite> selectRestSite(Reserve r);
	
	
}
