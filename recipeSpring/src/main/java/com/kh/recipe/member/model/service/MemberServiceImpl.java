package com.kh.recipe.member.model.service;

import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.recipe.member.model.dao.MemberDao;
import com.kh.recipe.member.model.vo.Cert;
import com.kh.recipe.member.model.vo.Member;

@Service
public class MemberServiceImpl implements MemberService {
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Autowired
	private MemberDao memberDao;

	@Override
	public Member loginMember(Member m) {
		return memberDao.loginMember(sqlSession, m);
	}

	@Override
	public int insertMember(Member m) {
		return memberDao.insertMember(sqlSession, m);
	}

	@Override
	public int checkDupl(HashMap<String, String> map) {
		return memberDao.checkDupl(sqlSession, map);
	}

	@Override
	public int sendCode(Cert cert) {
		return memberDao.sendCode(sqlSession, cert);
	}
	
	@Override
	public boolean validate(Cert cert) {
		boolean result = memberDao.validate(sqlSession, cert);
		if(result != false) {
			memberDao.deleteCode(sqlSession, cert);
		}
		return result;
	}
	
	@Override
	public Member searchMemberId(Member m) {
		return memberDao.searchMemberId(sqlSession, m);
	}

	@Override
	public int searchMemberPwd(Member m) {
		return 0;
	}

	@Override
	public int updateMember(Member m) {
		return 0;
	}

	@Override
	public int updateMemberPwd(Member m) {
		return 0;
	}

	@Override
	public int deleteMember(int memberNo) {
		return 0;
	}


}
