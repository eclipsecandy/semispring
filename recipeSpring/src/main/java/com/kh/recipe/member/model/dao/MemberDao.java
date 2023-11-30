package com.kh.recipe.member.model.dao;

import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.recipe.member.model.vo.Cert;
import com.kh.recipe.member.model.vo.Member;

@Repository
public class MemberDao {

	public Member loginMember(SqlSessionTemplate sqlSession, Member m) {
		return sqlSession.selectOne("memberMapper.loginMember", m);
	}

	public int insertMember(SqlSessionTemplate sqlSession, Member m) {
		return sqlSession.insert("memberMapper.insertMember", m);
	}

	public int checkDupl(SqlSessionTemplate sqlSession, HashMap<String, String> map) {
		return sqlSession.selectOne("memberMapper.checkDupl", map);
	}
	
	public int sendCode(SqlSessionTemplate sqlSession, Cert cert) {
		return sqlSession.insert("memberMapper.sendCode", cert);
	}
	
	public boolean validate(SqlSessionTemplate sqlSession, Cert cert) {
		return sqlSession.selectOne("memberMapper.validate", cert) != null;
	}
	
	public int deleteCode(SqlSessionTemplate sqlSession, Cert cert) {
		return sqlSession.delete("memberMapper.deleteCode", cert);
	}
	
	public Member searchMemberId(SqlSessionTemplate sqlSession, Member m) {
		return sqlSession.selectOne("memberMapper.searchMemberId", m);
	}



}
