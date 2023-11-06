package com.kh.recipe.member.model.vo;

import java.sql.Date;

import lombok.Data;

@Data
public class Member {
	
	private int memNo;
	private String memId;
	private String memPwd;
	private String memName;
	private String memNickname;
	private String memEmail;
	private String memStatus;
	private Date enrollDate;
	private Date modifyDate;
	private Date deleteDate;
	private String memPicture;
	private int memGrade;
	private String memGradeName;
	private int memReward;
	private String memUpdateWhyCon;
	private int memCouponCount;

}
