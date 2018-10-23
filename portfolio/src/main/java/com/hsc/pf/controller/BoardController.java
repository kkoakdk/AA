package com.hsc.pf.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import com.hsc.pf.service.BoardService;

@Controller
public class BoardController {
	private Logger logger = Logger.getLogger(BoardController.class);
	@Value("#{config['project.context.path']}")
	private String contextRoot;
	@Autowired private BoardService bService;


	//자유게시판
	@RequestMapping("/board/list.do")
	public ModelAndView list(@RequestParam HashMap<String, String> params) {
		logger.debug(  "list params "  + params);
		ModelAndView mv = new ModelAndView();
		mv.setViewName("/board/list");

		if(params.containsKey("msg")) {
			mv.addObject("msg", params.get("msg"));
		}

		//페이징 처리
		//현재 페이지
		int currentPage = params.containsKey("currentPage") ? Integer.parseInt(params.get("currentPage")) : 1;
		//보여줄 게시글 수
		int pageArticleSize = params.containsKey("pageArticleSize") ?  Integer.parseInt(params.get("pageArticleSize")) : 10;;
		//총 게시글 수
		int totalArticleCnt = bService.getTotalCount(params);
		//총 페이지수 : Math.ceil(총 게시글 수 / 보여줄 게시글)
		int totalPages = (int) Math.ceil(totalArticleCnt / (double) pageArticleSize);
		// 시작 인덱스 : (현재 페이지 -1) * 게시글 수 +1
		int startIdx = (currentPage - 1) *  pageArticleSize;
		// 끝 인덱스 : 현재페이지  * 게시글 수					- endIdx
		int endIdx = currentPage * pageArticleSize;
		//블록
		int block = 10;
		//시작 : (현재-1) /블럭수 * 블럭수 + 1				start
		int start = (currentPage - 1) /  block * block + 1;
		//종료 : (현재-1) /블럭수 * 블럭수 + 블럭 수
		int end = (currentPage - 1) /  block * block + block;
		end = (end >= totalPages) ? totalPages : end ;
		params.put("startIdx", String.valueOf(startIdx)) ;
		params.put("pageArticleSize", String.valueOf(pageArticleSize));
		//게시글 전체를 가져온다.
		List<Map<String, Object>> list = bService.list(params);  //ArrayList는 
		System.out.println("갯수" + list.size());
		mv.addObject("list", list); //담는다아서 list라는 이름으로 쓰겠다.
		mv.addObject("currentPage", currentPage);
		mv.addObject("start", start);
		mv.addObject("end", end);
		mv.addObject("totalPages", totalPages);
		mv.addObject("searchText", params.get("searchText"));
		mv.addObject("searchType", params.get("searchType"));
		// jsp로 보내기 위한 이름


		return mv;
	}


	
	

	@RequestMapping("/board/goWritePage.do")		//요청을 1대1로 매핑한다.
	public ModelAndView goWritePage() {				//반환타입 ModelAndView에 goWritPage 객체를 생성한다.
		ModelAndView mv = new ModelAndView();		//mv이름으로 쓴다..

		mv.setViewName("/board/write");				//write페이지로 이동 시킨다.
		
		return mv;									//mv리턴
	}
	
	
	
	

	

	@RequestMapping("/board/write.do")
	public ModelAndView write(@RequestParam HashMap<String, Object> params) {
		logger.debug("/board/write.do params - "+ params); // 로그에 데이터들어갔는지 출력

		ModelAndView mv = new ModelAndView();
		RedirectView rv = new RedirectView(contextRoot +"/board/list.do");

		mv.setView(rv);
		bService.writing(params);

		return mv;
	}


	@RequestMapping("/board/read.do")
	public ModelAndView read(@RequestParam HashMap<String, String > params) {
		ModelAndView mv = new ModelAndView();

		Map<String, Object> readAtcl = bService.readAtcl(Integer.parseInt(params.get("boardSeq")) , Integer.parseInt(params.get("typeSeq")));


		String msg = params.get("msg");
		if(msg != null) {
			mv.addObject("msg", msg);
		}

		mv.addObject("readAtcl", readAtcl);
		mv.setViewName("board/read");



		return mv;
	}



	//삭제
	@RequestMapping("/board/del.do") //url나오면 메서드
	public ModelAndView del(@RequestParam int boardSeq, @RequestParam int typeSeq,	HttpSession session) {

		ModelAndView mv = new ModelAndView();

		if(session.getAttribute("memberId") != null) {

			int del = bService.del(boardSeq ,  typeSeq);
			System.out.println("삭제" + del);

			if(del != 1) {
				String url = contextRoot +"/board/read.do?boardSeq=";
				url += boardSeq + "&typeSeq=" + typeSeq;
				RedirectView rv = new RedirectView(url);
				mv.setView(rv);
				mv.addObject("msg", "삭제 실패! 오류가 있습니다.");

			}else {
				RedirectView rv = new RedirectView(contextRoot +"/board/list.do");
				mv.addObject("msg", "삭제 성공");
				mv.setView(rv);
			}
		}else {         //로그인이 안된 상태
			mv.addObject("msg", "로그인 하세요");
			mv.addObject("nextLocation", "/index.do");
			mv.setViewName("common/error");
		}

		return mv;

	}
	
	//수정
	@RequestMapping("/board/goUpd.do")
	public ModelAndView upd(@RequestParam int boardSeq, @RequestParam int typeSeq, HttpSession session) {
		ModelAndView mv = new ModelAndView();
		System.out.println("수정 파라미터 : " + typeSeq + " " +  boardSeq);

		
		if(session.getAttribute("memberId") != null) { //로그인을 했을떄. 
			Map<String, Object> upd = bService.readAtcl(boardSeq, typeSeq);
			String id = (String) session.getAttribute("memberId"); //아이디는 로그인된 아이디
			String id1 = (String) upd.get("member_id");
			if(id.equals(id1)) {
				mv.addObject("upd", upd);
				mv.setViewName("/board/update");

			}else {
				mv.addObject("msg", "작성한 회원이 아닙니다.");
			}
		}
		return mv;
	}
	
	
	//수정 후 저장할 때
	@RequestMapping("/board/doUpd.do")
	public ModelAndView upd (@RequestParam HashMap<String, Object> params, HttpSession session) {
		ModelAndView mv = new ModelAndView();
		//System.out.println("보낸 데이터 (doUpd) :"+ params);
		//logger.debug("보낸 데이터 (doUpd) :"+ params);
		
		if(session.getAttribute("memberId") != null) {//로그인 유효성 검사
		int upd = bService.upd(params);

				mv.addObject("upd", upd);
				RedirectView rv = new RedirectView(contextRoot +"/board/read.do?boardSeq="+ params.get("boardSeq") + "&typeSeq=" + params.get("typeSeq") );
				mv.setView(rv);
				
			}else {
				mv.addObject("msg", "작성한 회원이 아닙니다.");
				mv.setViewName("/board/list");

			}
		//}
		return mv;
		
	}
	

	
}
				
			 
			
		
		
