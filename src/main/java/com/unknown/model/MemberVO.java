package com.unknown.model;

import java.util.Date;
import lombok.Data;

@Data
public class MemberVO {

    private String memberId;
    private String memberPw;
    private String memberName;
    private String memberPhone;
    private String memberMail;
    private String memberAddr1;
    private String memberAddr2;
    private String memberAddr3;
    private int adminCk;
    private Date regDate;  // Date 타입으로 변경
    private int point;
    private String suspended;
    private String withdrawal;
}
