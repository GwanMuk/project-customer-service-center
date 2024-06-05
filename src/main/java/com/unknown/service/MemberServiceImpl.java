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
	

	/* ȸ������*/
	@Override
	public void memberJoin(MemberVO member) throws Exception {
		
		membermapper.memberJoin(member);
		
	}
	
	/* ���̵� �ߺ� �˻� */
	@Override
	public int idCheck(String memberId) throws Exception {
		
		return membermapper.idCheck(memberId);
	}
	
	/* �α��� */
    @Override
    public MemberVO memberLogin(MemberVO member) throws Exception {
        
        return membermapper.memberLogin(member);
    }
    
    /* ȸ�� ���� ���� */
    @Override
    @Transactional
    public void memberUpdate(MemberVO member) throws Exception {
        membermapper.memberUpdate(member);
    }
    
    /* �ֹ��� ���� */
	@Override
	public MemberVO getMemberInfo(String memberId) {
		
		return membermapper.getMemberInfo(memberId);
		
	}
	
}
