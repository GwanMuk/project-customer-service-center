package com.unknown.service;

import com.unknown.model.MemberVO;

public interface MemberService {

	// ȸ������
	public void memberJoin(MemberVO member) throws Exception;

	// ���̵� �ߺ� �˻�
	public int idCheck(String memberId) throws Exception;
	
	 // �α���
    public MemberVO memberLogin(MemberVO member) throws Exception; 
    
    //ȸ�� ���� ����
    public void memberUpdate(MemberVO member) throws Exception;
    
    //�ֹ��� ����
	public MemberVO getMemberInfo(String memberId);

}