package com.kh.youcamp.order.util;

import java.security.MessageDigest;

import org.apache.commons.codec.binary.Hex;

/*
 * 
 * SHA-256 해시 생성을 처리하여 결제 요청의 위변조를 방지
 * 나이스페이 결제 API에서 요구하는 서명 데이터(SignData)를 생성
 * 
 */
public class DataEncrypt {
	
	MessageDigest md;
	String strSRCData = "";
	String strENCData = "";
	String strOUTData = "";
	
	public DataEncrypt(){ }
	public String encrypt(String strData){
		String passACL = null;
		MessageDigest md = null;
		try{
			md = MessageDigest.getInstance("SHA-256");
			md.reset();
			md.update(strData.getBytes());
			byte[] raw = md.digest();
			passACL = encodeHex(raw);
		}catch(Exception e){
			System.out.print("암호화 에러" + e.toString());
		}
		return passACL;
	}
	
	public String encodeHex(byte [] b){
		char [] c = Hex.encodeHex(b);
		return new String(c);
	}
}
