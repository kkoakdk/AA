package com.hsc.pf.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import com.hsc.pf.dto.Member;
import com.hsc.pf.exception.MemberNotFoundException;
import com.hsc.pf.exception.PasswordMissmatchException;
import com.hsc.pf.service.MemberService;

@Controller
public class MemberController {
	private Logger logger = Logger.getLogger(BoardController.class);
	
	@Value("#{config['project.context.path']}")
	private String contextRoot;
	
	// Service DI 구현 코드
	@Autowired private MemberService mService;
	private int memberIdx;
	

	@RequestMapping("/member/join.do")
	public ModelAndView join(@RequestParam HashMap<String, Object> memberInfo ) {

		String msg = (mService.join(memberInfo) == 1) ? "회원가입 성공!!" : "회원가입 실패!!";

		
		ModelAndView mv = new ModelAndView();
		RedirectView rv = new RedirectView(contextRoot +"/member/goLogin.do");

		//mv.setViewName("/login");
		mv.setView(rv);
		mv.addObject("msg", msg);
		
		return mv;
	}
	



	@RequestMapping("/member/delMember.do")
	@ResponseBody
	public HashMap<String, String> delMember(@RequestParam HashMap<String, Object> params ) {
		logger.debug("###########/member/delMember.do params" + params);
		HashMap<String, String> map = new HashMap<String, String>();
		int cnt = mService.delMember(params);
		map.put("msg", (cnt==1)?"삭제 되었습니다." : "삭제 실패!");
		map.put("result", String.valueOf(cnt));
		return map;
	}	


	@RequestMapping("/member/go.do")
	public ModelAndView go(@RequestParam HashMap<String, Object> memberInfo ) {

		ModelAndView mv = new ModelAndView();
		mv.setViewName("/mList");

		return mv;
	}

	@RequestMapping("/mList.do")
	@ResponseBody
	public HashMap<String, Object> mList(@RequestParam HashMap<String, Object> params ) {
		logger.debug("##################//mList.do : " + params);
		ModelAndView mv = new ModelAndView();
		//한 페이지에 보여줄 게시글 수
		int rows = Integer.parseInt(String.valueOf(params.get("rows")));

		//현재 페이지
		int currentPage = Integer.parseInt(String.valueOf(params.get("page")));

		//전체 회원 수 구하기
		int totalMember = mService.mListCount(params);

		//시작 인덱스 : (현재 페이지 -1) * 
		int start = (currentPage - 1) * rows;

		//총페이지
		int totalPage = (int) Math.ceil( totalMember/(double) rows);

		params.put("start",start);


		ArrayList<HashMap<String, Object>> list = mService.mList(params);
		HashMap<String, Object> result = new HashMap<String, Object>();
		result.put("page", params.get("page")); // 현재 페이지
		result.put("total", totalPage); //총 페이지수 
		result.put("rows", list); // 데이터 (목록)
		result.put("records", totalMember); //총 회원수
		return result;
	}

	@RequestMapping("/member/logout.do")
	public ModelAndView logout(HttpSession session) {
		session.invalidate(); //세션 무효화 하기.
		ModelAndView mv = new ModelAndView();
		RedirectView rv = new RedirectView("/portfolio/index.do");
		mv.setView(rv);

		return mv;
	}

	@RequestMapping("/member/login.do")
	public ModelAndView login(String userId, String userPw, HttpSession session) {
		logger.debug("pw : " + userPw + " id " + userId);

		ModelAndView mv = new ModelAndView();
		String page = "login";
		String msg = "시스템에러";


		Member member = null;


		try {
			member= mService.login(userId, userPw);
			session.setAttribute("memberId", member.getMemberId());
			session.setAttribute("memberName", member.getMemberName());
			session.setAttribute("memberNick", member.getMemberNick());
			session.setAttribute("typeSeq", member.getTypeSeq());
			session.setAttribute("memberIdx", member.getMemberIdx());
			RedirectView rv = new RedirectView("/portfolio/index.do");
			mv.setView(rv);
			return mv;

		}catch (PasswordMissmatchException pme) {
			msg = pme.getMessage();
		}catch (MemberNotFoundException mnfe) {
			msg = mnfe.getMessage();
		} catch (Exception e) {
			e.printStackTrace();
		}
		mv.setViewName(page);
		mv.addObject("msg", msg);

		return mv;
	}
	@RequestMapping("/member/checkId.do") 
	@ResponseBody
	public int checkId(@RequestParam HashMap<String, String> params) {
		logger.debug("/member/checkId.do params " + params);

		return mService.checkId(params.get( "memberId"));
	}
}
