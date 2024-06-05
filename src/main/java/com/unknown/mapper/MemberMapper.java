package com.unknown.mapper;

import com.unknown.model.MemberVO;

public interface MemberMapper {

	// ȸ������
	public void memberJoin(MemberVO member);

	// ���̵� �ߺ� �˻�
	public int idCheck(String memberId);
	
	// �α���
    public MemberVO memberLogin(MemberVO member);
    
    // ȸ�� ���� ����
    public void memberUpdate(MemberVO member);

    // �ֹ��� �ּ� ���� 
	public MemberVO getMemberInfo(String memberId);

}
