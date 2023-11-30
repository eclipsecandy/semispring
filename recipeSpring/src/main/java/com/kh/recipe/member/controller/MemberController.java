package com.kh.recipe.member.controller;

import java.text.DecimalFormat;
import java.util.HashMap;
import java.util.Random;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.recipe.member.model.service.MemberService;
import com.kh.recipe.member.model.vo.Cert;
import com.kh.recipe.member.model.vo.Member;

@Controller
public class MemberController {
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private BCryptPasswordEncoder bcryptPasswordEncoder;
	
	@Autowired
	private JavaMailSender sender;
	
	// 로그인 창으로 이동
	@RequestMapping("yrloginForm.me")
	public String loginMemberForm() {
		return "member/memberLogin";
	}
	
	// 로그인 기능
	@RequestMapping("yrlogin.me")
	public String loginMember(Member m, HttpSession session, String saveId, HttpServletResponse response) {
		
		Member loginMember = memberService.loginMember(m);
		
		Cookie cookieId = new Cookie("saveId", m.getMemId());
		// 아이디 저장
		if(saveId != null) {
			cookieId.setMaxAge(60 * 60 * 24 * 28);
			response.addCookie(cookieId);
		} else {
			cookieId.setMaxAge(0);
			response.addCookie(cookieId);
		}
		
		if(loginMember != null && bcryptPasswordEncoder.matches(m.getMemPwd(), loginMember.getMemPwd())) {
			session.setAttribute("loginMember", loginMember);
			return "redirect:/";
		} else {
			// 쿠키때문에 redirect로 보냄 => session에 담아야 함
			session.setAttribute("errorMsg", "로그인에 실패하셨습니다.");
			return "redirect:/yrloginForm.me";
		}
	}
	
	// 로그아웃 기능
	@RequestMapping("yrlogout.me")
	public String logoutMember(HttpSession session) {
		session.invalidate();
		return "redirect:/";
	}
	
	// 회원가입 창으로 이동
	@RequestMapping("yrenrollForm.me")
	public String enrollFrom() {
		return "member/memberEnrollForm";
	}
	
	// 회원가입
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
	
	// 중복체크
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
	
	// 이메일 인증 코드 발송
	@ResponseBody
	@RequestMapping("yrsendCode.me")
	public String sendCode(String recipient, HttpServletRequest request) throws MessagingException {
		System.out.println("여긴 컨트롤러");
		MimeMessage message = sender.createMimeMessage();
		MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");
		
		// String ip = request.getRemoteAddr();
		// System.out.println(ip);
		
		int num = new Random().nextInt(100000);
		String code = new DecimalFormat("000000").format(num);
		System.out.println(code);
		
		// ip주소 request.getRemoteAddr() 안넣고 이메일 넣을거임
		Cert cert = Cert.builder().recipient(recipient)
								  .code(code).build();
		
		if(memberService.sendCode(cert) > 0) {
			helper.setTo(recipient);
			helper.setSubject("인증번호를 보내드립니다 - Re See Recipe");
			helper.setText("인증번호 : " + code);
			
			sender.send(message);
			
			return "NNNNY";
		} else {
			return "NNNNN";
		}
	}
	
	// 이메일 인증 코드 검증
	@ResponseBody
	@RequestMapping("yrvalidate.me")
	public String validate(Cert cert, HttpServletRequest request) {
		
//		Cert cert = Cert.builder().recipient(recipient)
//								  .code(code).build();
		return String.valueOf(memberService.validate(cert));
	}
	
	// 아이디 찾기 창으로 이동
	@RequestMapping("yrsearchMemberIdForm.me")
	public String searchMemberIdForm() {
		return "member/searchMemberIdForm";
	}
	
	// 아이디 찾기
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
