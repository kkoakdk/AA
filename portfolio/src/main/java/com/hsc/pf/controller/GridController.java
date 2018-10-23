package com.hsc.pf.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.hsc.pf.service.BoardService;

@Controller
public class GridController {
	@Autowired private BoardService bService;

	@RequestMapping("/board/goList.do")
	public ModelAndView go(@RequestParam HashMap<String, Object> memberInfo ) {

		ModelAndView mv = new ModelAndView();
		mv.setViewName("/boardGrid/gList");
		
		return mv;
	}
	
	
	@RequestMapping("/board/gList.do")
	@ResponseBody
	public HashMap<String, Object> grid(@RequestParam HashMap<String, String> params) {

		int currentPage = params.containsKey("currentPage") ? Integer.parseInt(params.get("currentPage")) : 1;
		int pageArticleSize = params.containsKey("pageArticleSize") ?  Integer.parseInt(params.get("pageArticleSize")) : 10;;
		int totalArticleCnt = bService.getTotalCount(params);
		int totalPages = (int) Math.ceil(totalArticleCnt / (double) pageArticleSize);
		int startIdx = (currentPage - 1) *  pageArticleSize;
		int endIdx = currentPage * pageArticleSize;
		int block = 10;
		int start = (currentPage - 1) /  block * block + 1;
		int end = (currentPage - 1) /  block * block + block;
		end = (end >= totalPages) ? totalPages : end ;
		params.put("startIdx", String.valueOf(startIdx)) ;
		params.put("pageArticleSize", String.valueOf(pageArticleSize));

		List<Map<String, Object>> list = bService.list(params);  //ArrayList는 
		HashMap<String, Object> result = new HashMap<String, Object>();
		
		result.put("rows", list);
		result.put("page", currentPage);
		result.put("total", totalPages);
		result.put("start", start);
		result.put("end", end);
		result.put("records", totalArticleCnt);
		

		return result;
	}
}
