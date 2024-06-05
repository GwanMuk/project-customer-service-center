package com.unknown.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.unknown.mapper.MemberMapper;
import com.unknown.model.MemberVO;

@Service
public class MemberServiceImpl  implements MemberService{

	@Autowired
	private MemberMapper membermapper;
	

	/* 회원가입*/
	@Override
	public void memberJoin(MemberVO member) throws Exception {
		
		membermapper.memberJoin(member);
		
	}
	
	/* 아이디 중복 검사 */
	@Override
	public int idCheck(String memberId) throws Exception {
		
		return membermapper.idCheck(memberId);
	}
	
	/* 로그인 */
    @Override
    public MemberVO memberLogin(MemberVO member) throws Exception {
        
        return membermapper.memberLogin(member);
    }
    
    /* 회원 정보 수정 */
    @Override
    @Transactional
    public void memberUpdate(MemberVO member) throws Exception {
        membermapper.memberUpdate(member);
    }
    
    /* 주문자 정보 */
	@Override
	public MemberVO getMemberInfo(String memberId) {
		
		return membermapper.getMemberInfo(memberId);
		
	}
	
}
