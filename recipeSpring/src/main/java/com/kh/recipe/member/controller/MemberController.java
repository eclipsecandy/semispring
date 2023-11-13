package com.kh.recipe.member.controller;

import java.util.HashMap;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
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
	
	@Autowired
	private BCryptPasswordEncoder bcryptPasswordEncoder;
	
	// 로그인 창으로 이동
	@RequestMapping("yrloginForm.me")
	public String loginMemberForm() {
		return "member/memberLogin";
	}
	
	// 로그인 기능
	@RequestMapping("yrlogin.me")
	public String loginMember(Member m, Model model, HttpSession session, String saveId, HttpServletResponse response) {
		
		Member loginMember = memberService.loginMember(m);
		
		Cookie cookieId = new Cookie("saveId", m.getMemId());
		// 아이디 저장
		if(saveId != null) {
			cookieId.setMaxAge(60 * 60* 24* 28);
			response.addCookie(cookieId);
		} else {
			cookieId.setMaxAge(0);
			response.addCookie(cookieId);
		}
		
		if(loginMember != null && bcryptPasswordEncoder.matches(m.getMemPwd(), loginMember.getMemPwd())) {
			session.setAttribute("loginMember", loginMember);
			return "redirect:/";
		} else {
			model.addAttribute("errorMsg", "로그인에 실패하셨습니다.");
			return "member/memberLogin";
		}
	}
	
	// 로그인 시 아이디 저장
	
	// 로그인 시 아이디 저장 해제
	
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
		
		// 복호화
		m.setMemPwd(bcryptPasswordEncoder.encode(m.getMemPwd()));
		System.out.println(m);
		
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
	
	@RequestMapping("yrsearchMemberIdForm.me")
	public String searchMemberIdForm() {
		return "member/searchMemberIdForm";
	}
	
	@ResponseBody
	@RequestMapping(value="yrsearchMemberId.me", produces="application/json; charset=UTF-8")
	public String searchMemberId(Member m) {
		System.out.println("컨트롤러");
		System.out.println(m);
		Member searchMember = memberService.searchMemberId(m);
		System.out.println(searchMember);
		
		if(searchMember != null) {
			JSONObject jObj = new JSONObject();
			jObj.put("memId", searchMember.getMemId());
			jObj.put("memStatus", searchMember.getMemStatus());
			// jObj.put("searchMember", searchMember); 이렇게는 안됨
			return jObj.toJSONString();
		} else {
			return "null"; // ????????????????????????????????왜 문자열 null로 보냈는데 null로 받지
		}
		
		 
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

}
