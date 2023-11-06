package com.kh.recipe.member.controller;

import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.recipe.member.model.service.MemberService;
import com.kh.recipe.member.model.vo.Member;

@Controller
public class MemberController {
	
	@Autowired
	private MemberService memberService;
	
	// 로그인 창으로 이동
	@RequestMapping("yrloginForm.me")
	public String loginMemberForm() {
		return "member/memberLogin";
	}
	
	// 로그인 기능
	@RequestMapping("yrlogin.me")
	public String loginMember(Member m, Model model, HttpSession session) {
		
		Member loginMember = memberService.loginMember(m);
		
		if(loginMember != null) {
			session.setAttribute("loginMember", loginMember);
			return "redirect:/";
		} else {
			model.addAttribute("errorMsg", "로그인에 실패하셨습니다.");
			return "member/memberLogin";
		}
	}
	
	// 로그아웃 기능
	@RequestMapping("yrlogout.me")
	public String logoutMember(HttpSession session) {
		session.invalidate();
		return "redirect:/";
	}
	
	@RequestMapping("yrenrollForm.me")
	public String enrollFrom() {
		return "member/memberEnrollForm";
	}
	
	@RequestMapping("yrenroll.me")
	public String insertMember(Member m, Model model) {
		if(memberService.insertMember(m) > 0) {
			return "member/memberEnrollSuccess";
		} else {
			model.addAttribute("errorMsg", "회원가입에 실패하셨습니다.");
			return "member/memberEnrollForm.jsp";
		}
	}
	
	@ResponseBody
	@RequestMapping("yrcheckDupl.me")
	public String checkDupl(String checkVal, String columnName) {
		
		HashMap map = new HashMap();
		map.put("checkVal", checkVal);
		map.put("columnName", columnName);
		
		if(memberService.checkDupl(map) > 0) {
			return "NNNNN";
		} else {
			return "NNNNY";
		}
		
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	

}
