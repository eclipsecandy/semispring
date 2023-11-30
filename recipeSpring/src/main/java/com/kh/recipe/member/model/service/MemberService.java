package com.kh.recipe.member.model.service;

import java.util.HashMap;

import com.kh.recipe.member.model.vo.Cert;
import com.kh.recipe.member.model.vo.Member;

public interface MemberService {
	
	Member loginMember(Member m); // 로그인
	
	int insertMember(Member m); // 회원가입
	
	int checkDupl(HashMap<String, String> map); // 중복체크
	
	int sendCode(Cert cert); // 인증번호 전송
	
	boolean validate(Cert cert); // 인증번호 검증
	
	Member searchMemberId(Member m); // 아이디 찾기
	
	int searchMemberPwd(Member m); // 비밀번호 찾기
	
	int updateMember(Member m); // 회원정보변경
	
	int updateMemberPwd(Member m); // 회원 비밀번호 변경
	
	int deleteMember(int memberNo); // 회원탈퇴(삭제)
	

}
