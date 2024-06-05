package com.unknown.service;

import com.unknown.model.MemberVO;

public interface MemberService {

	// 회원가입
	public void memberJoin(MemberVO member) throws Exception;

	// 아이디 중복 검사
	public int idCheck(String memberId) throws Exception;
	
	 // 로그인
    public MemberVO memberLogin(MemberVO member) throws Exception; 
    
    //회원 정보 수정
    public void memberUpdate(MemberVO member) throws Exception;
    
    //주문자 정보
	public MemberVO getMemberInfo(String memberId);

}
