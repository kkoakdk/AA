package com.hsc.pf.controller;

import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class RecommendController {
	
	@RequestMapping("/goRecommend.do")
	public ModelAndView goRecommend(@RequestParam int boardSeq, HttpSession session) {
		ModelAndView mv = new ModelAndView();
		
		if(session.getAttribute("memberId") == null) {
			mv.addObject("msg", "로그인한 회원만 추천 가능합니다.");
		}else {
			
			mv.setViewName("/");
		}
		
		return mv;
	}
	
	@RequestMapping("/recommend.do")
	public ModelAndView recommend(@RequestParam HashMap<String, Object> params) {
		System.out.println("####################추천  :" + params);
		
		
		return null;
	}

}
