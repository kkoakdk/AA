package com.hsc.pf.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

/**
 * 
 * @author user
 *
 */
@Controller //annotation
public class IndexController {
	/*
	@RequestMapping("/home.do")  //index에서 
	public String home() {		// 화면이 바로 열림
		return "/home.jsp";    //페이지만 열어야할때가 있음. jsp표시만 해라 그럴때 String으로 처리를 한다. 	
														//데이터도 넣어주고 이것저것 하면 ModelAndView를 사용한다.
	} 옛날꺼
	 */

	//spring beans에서 이어서 보면 주소가 있기 때문에 (/ㅁㅁㅁ.jsp를 쓰지 않는다.)
	@RequestMapping("/home.do")
	public String home() {
		return "home";
	}


	@RequestMapping("/member/goLogin.do")
	public ModelAndView goLogin(HttpSession session) {
		ModelAndView mv = new ModelAndView();
		if(session.getAttribute("memberid") != null ) {
			RedirectView rv = new RedirectView("/portfolio/index.do");
			mv.setView(rv);
		}else {
			mv.setViewName("login");
		}
		return mv;
	}

	@RequestMapping("/board.do")
	public String board() {
		return "board";
	}

	
	@RequestMapping("/devNotes.do")
	public String devNotes() {	
		return "devNotes";
	}

	@RequestMapping("/index.do")
	public String index() {
		return "index";
	}

}
