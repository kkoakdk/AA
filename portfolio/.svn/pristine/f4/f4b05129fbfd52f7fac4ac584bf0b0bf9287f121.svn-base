package com.hsc.pf.controller;

import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import com.hsc.pf.service.BoardAttachService;
import com.hsc.pf.service.NoticeService;
import com.hsc.pf.util.FileUtil;

@Controller
public class NoticeController {
	private Logger logger = Logger.getLogger(NoticeController.class);
	@Value("#{config['project.context.path']}")
	private String contextRoot;

	@Autowired private NoticeService nService;
	@Autowired private FileUtil fUtil;
	@Autowired private BoardAttachService bAService;

	//자유게시판
	@RequestMapping("/notice/listNotice.do")
	public ModelAndView listNotice(@RequestParam HashMap<String, String> params) {
		logger.debug(  "list params@@@@@ "  + params);
		ModelAndView mv = new ModelAndView();
		mv.setViewName("/notice/listNotice");// 실제 파일로 보낸는 주소 jsp

		if(params.containsKey("msg")) {
			mv.addObject("msg", params.get("msg"));
		}

		//페이징 처리
		//현재 페이지
		int currentPage = params.containsKey("currentPage") ? Integer.parseInt(params.get("currentPage")) : 1;
		//보여줄 게시글 수
		int pageArticleSize = params.containsKey("pageArticleSize") ?  Integer.parseInt(params.get("pageArticleSize")) : 10;;
		//총 게시글 수
		int totalArticleCnt = nService.getTotalCount(params);
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
		List<Map<String, Object>> list = nService.listNotice(params);  //ArrayList는 
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


	@RequestMapping("/notice/goWritePage.do")	
	public ModelAndView goWritePage() {		
		ModelAndView mv = new ModelAndView();		
		mv.setViewName("/notice/write");				

		logger.debug("contextRoot----"+contextRoot);
		return mv;		
	}

	@RequestMapping("/notice/write.do")
	public ModelAndView write(@RequestParam HashMap<String, Object> params, MultipartHttpServletRequest mReq) {
		logger.debug("/notice/write.do params - "+ params); // 로그에 데이터들어갔는지 출력

		mReq.getMultiFileMap();
		List<MultipartFile> mFiles = mReq.getFiles("attfile");

		for(MultipartFile mf : mFiles) {
			if(!mf.getOriginalFilename().equals("") ) {
				params.put("hasFile", 1);
			} else params.put("hasFile", 0);

			System.out.println("filename : " + mf.getOriginalFilename());
			System.out.println("size : " + mf.getSize());
			System.out.println("type : " + mf.getContentType());
		}

		ModelAndView mv = new ModelAndView();
		RedirectView rv = new RedirectView(contextRoot+"/notice/listNotice.do");
		mv.setView(rv);
		
		nService.writeCant(params,mFiles );

		return mv;
	}


	@RequestMapping("/notice/read.do")
	public ModelAndView read(@RequestParam HashMap<String, String > params) {
		ModelAndView mv = new ModelAndView();

		Map<String, Object> readAtcl = nService.readAtcl(Integer.parseInt(params.get("boardSeq")) , Integer.parseInt(params.get("typeSeq")));
		int boardSeq = Integer.parseInt(params.get("boardSeq"));
		int typeSeq = Integer.parseInt(params.get("typeSeq"));

		mv.addObject("files", nService.fileSelect(boardSeq, typeSeq));
		if(readAtcl.get("has_file").equals("1")) {

		}
		String msg = params.get("msg");
		if(msg != null) {
			mv.addObject("msg", msg);
		}

		mv.addObject("readAtcl", readAtcl);
		mv.setViewName("/notice/read");
		System.out.println("!!!!!!!!!!!!"+readAtcl);
		return mv;
	}

	//삭제
	@RequestMapping("/notice/del.do")
	public ModelAndView del(@RequestParam int boardSeq, @RequestParam int typeSeq,	HttpSession session) {

		ModelAndView mv = new ModelAndView();

		if(session.getAttribute("memberId") != null) { 
			Map<String, Object> upd = nService.readAtcl(boardSeq, typeSeq);
			String id = (String) session.getAttribute("memberId"); 
			String id1 = (String) upd.get("member_id");
			
			if(id.equals(id1)) {
				int del = nService.del(boardSeq,typeSeq, String.valueOf(upd.get("has_file")));
				System.out.println("삭제" + del);

				if(del != 1) {
					String url = contextRoot+"/notice/read.do?boardSeq="; 
					url += boardSeq + "&typeSeq=" + typeSeq;
					RedirectView rv = new RedirectView(url);
					mv.setView(rv);
					mv.addObject("msg", "삭제 실패! 오류가 있습니다.");

				}else {
					RedirectView rv = new RedirectView(contextRoot+"/notice/listNotice.do");
					mv.addObject("msg", "삭제 성공");
					mv.setView(rv);
				}
			}

		}else { 
			mv.addObject("msg", "로그인 하세요");
			mv.addObject("nextLocation", "/index.do");
			mv.setViewName("common/error");
		}

		return mv;

	}

	@RequestMapping("/notice/goUpd.do")
	public ModelAndView goupd(@RequestParam int boardSeq, @RequestParam int typeSeq, HttpSession session) {
		ModelAndView mv = new ModelAndView();
		System.out.println("수정 파라미터 : " + typeSeq + " " +  boardSeq);

		if(session.getAttribute("memberId") != null) { 
			Map<String, Object> upd = nService.readAtcl(boardSeq, typeSeq);
			String id = (String) session.getAttribute("memberId"); 
			String id1 = (String) upd.get("member_id");

			if(id.equals(id1)) {
				//
				mv.addObject("upd", upd);
				mv.setViewName("/notice/update");

				if(upd.get("has_file").equals("1")) {

					mv.addObject("files", nService.fileSelect(boardSeq, typeSeq));
				}



			}else {
				mv.addObject("msg", "작성한 회원이 아닙니다.");
			}
		}
		return mv;
	}


	@RequestMapping("/notice/doUpd.do")
	public ModelAndView upd ( HttpSession session, MultipartHttpServletRequest mReq, @RequestParam HashMap<String, Object> params) {
		ModelAndView mv = new ModelAndView();
		System.out.println("보낸 데이터 (doUpd) :"+  params);
		logger.debug("보낸 데이터 (doUpd) :"+ params);


		if(session.getAttribute("memberId") != null) {
			int boardSeq = Integer.parseInt( String.valueOf(params.get("boardSeq")));
			int typeSeq = Integer.parseInt(String.valueOf(params.get("typeSeq")));
			Map<String, Object> atcl = nService.readAtcl(boardSeq, typeSeq);
			logger.debug("show : "+ atcl);	

			String id = (String) session.getAttribute("memberId");
			String id1 = (String) atcl.get("member_id");


			List<MultipartFile> mFiles = mReq.getFiles("attfile");
			if(params.get("hasFile").equals("0")) {
				for(MultipartFile mf : mFiles) {
					if(!mf.getOriginalFilename().equals("") ) {
						params.put("hasFile", 1);
					} else {
						params.put("hasFile", 0);
					}
				}
			}
			if(id.equals(id1)) {
				int upd = nService.upd(params, mFiles);
				RedirectView rv = new RedirectView(contextRoot+"/notice/read.do?boardSeq="+ boardSeq + "&typeSeq=" +typeSeq );
				mv.setView(rv);
				mv.addObject("upd", upd);

			}else {
				mv.addObject("msg", "작성한 회원이 아닙니다.");
				mv.setViewName("/notice/list");
			}

		}
		return mv;

	}
	@ResponseBody
	@RequestMapping("/notice/donwload.do")
	public byte[] download(@RequestParam int fileIdx, HttpServletResponse rep) {
		logger.debug("/download.do params :" + fileIdx);

		Map<String, Object> attach = bAService.getAttach(fileIdx);
		byte[] b = null;
		String endcodingName = null;

		if(attach == null) { //지워짐

		} else { 
			//한글 파일명 인코딩
			try {
				endcodingName = java.net.URLEncoder.encode(attach.get("filename").toString(), "UTF-8" );  //인코딩한 이름
			} catch (UnsupportedEncodingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

			b = fUtil.readFile(attach);

			rep.setHeader("Content-Disposition", "attachment; filename=\"" + endcodingName + "\"");
			rep.setContentType(String.valueOf(attach.get("file_type")));
			rep.setHeader("Pragma", "no-cache");
			rep.setHeader("Cache_Control","no-cache");
			String tmp = String.valueOf(attach.get("file_size"));
			rep.setContentLength(Integer.parseInt(tmp));
		}

		return b;
	}

	@RequestMapping("/notice/deleteAttach.do")
	public ModelAndView deleteAttach(@RequestParam int fileIdx, @RequestParam int boardSeq, @RequestParam int typeSeq) {
		ModelAndView mv = new ModelAndView();
		//삭제가 되든 안되든 update.do로 리다이렉트
		RedirectView rv = new RedirectView(contextRoot+"/notice/goUpd.do?boardSeq="+ boardSeq+"&typeSeq=" +typeSeq);
		mv.setView(rv);

		nService.deleteAttach(fileIdx, boardSeq, typeSeq);
		return mv;
	}

}




