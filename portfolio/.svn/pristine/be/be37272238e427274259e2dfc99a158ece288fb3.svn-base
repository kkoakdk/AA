package com.hsc.pf.service.impl;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.hsc.pf.dao.BoardAttachDao;
import com.hsc.pf.dao.NoticeDao;
import com.hsc.pf.service.NoticeService;
import com.hsc.pf.util.FileUtil;

@Service	
public class NoticeServiceImpl implements NoticeService{
	private Logger logger = Logger.getLogger(NoticeServiceImpl.class);
	@Autowired private NoticeDao nDao;
	@Autowired private BoardAttachDao aDao;
	@Autowired private FileUtil fUtil;

	@Override
	public int writeCant(HashMap<String, Object> params, List<MultipartFile> mFile) {
		// 1.글 등록
		nDao.writing(params);
		System.out.println("boardSeq :" + params.get("boardSeq"));
		//2. 첨부파일 있으면 board_attach 테이블에 등록
		for(MultipartFile mf : mFile) {
			if(!mf.getOriginalFilename().equals("")) {
				params.put("filename", mf.getOriginalFilename());
				//난수를 만들어 가짜 이름 사용.
				String fakename= UUID.randomUUID().toString().replace("-", "");
				params.put("fakeFilename", fakename);

				params.put("fileSize", mf.getSize());
				aDao.insert(params);
				try {
					fUtil.copyFile(mf, fakename);
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}

		return 0;
	}


	@Override
	public int writing(HashMap<String, Object> writing) {
		int writ = nDao.writing(writing);

		// TODO Auto-generated method stub
		return writ;
	}


	@Override
	public List<Map<String, Object>> listNotice(HashMap<String, String> params) {	
		// TODO Auto-generated method stub
		List<Map<String, Object>> listNotice = nDao.listNotice(params);							

		return listNotice;																
	}



	@Override
	public int getTotalCount(HashMap<String, String> params) {

		return nDao.getTotalCount(params);
	}


	@Override 
	public Map<String, Object> readAtcl(int boardSeq, int typeSeq) {
		int hit = nDao.updateHit(boardSeq, typeSeq);
		Map<String, Object> readAtcl = nDao.getBoard(boardSeq , typeSeq);

		return readAtcl;
	}


	@Override
	public int del(int boardSeq, int typeSeq, String hasFile) {
		if(hasFile.equals("1")) {
			List<HashMap<String, Object>> fileSelect = aDao.fileSelect(boardSeq, typeSeq);
			for(HashMap<String, Object> file : fileSelect) {
				fUtil.deleteFile(file); //물리적 위치의  파일을 삭제 시긴다. 
			}
			//글번호, 타입으로 첨부파일을 삭제하는 DAO 메서드 호출
			aDao.del(typeSeq, boardSeq); 
		}
		int del = nDao.del(boardSeq, typeSeq); 
		return del;
	}



	@Override
	public int upd(HashMap<String, Object> params, List<MultipartFile> mFile) {
		logger.debug("보낸 데이터  :"+ params);
		for(MultipartFile mf : mFile) {
			if(!mf.getOriginalFilename().equals("")) {
				params.put("filename", mf.getOriginalFilename());
				//난수를 만들어 가짜 이름 사용.
				String fakename= UUID.randomUUID().toString().replace("-", "");
				params.put("fakeFilename", fakename);

				params.put("fileSize", mf.getSize());
				aDao.insert(params);
				try {
					fUtil.copyFile(mf, fakename);
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}


		return nDao.upd(params);
	}


	@Override
	public List<HashMap<String, Object>> fileSelect(int boardSeq, int boardTypeSeq) {
		// TODO Auto-generated method stub
		return aDao.fileSelect(boardSeq, boardTypeSeq);
	}

	//  @Autowired private NoticeDao nDao;
	//	@Autowired private BoardAttachDao aDao;
	//	@Autowired private FileUtil fUtil;

	@Override
	public boolean deleteAttach(int file_idx, int boardSeq, int typeSeq) {
		boolean result = false;

		//첨부파일 정보를 가져온다.
		Map<String, Object> attach = aDao.getAttach(file_idx); //코드적기
		//db에서 삭제 한다.
		aDao.deleteAttach(file_idx);
		//원 게시글과 첨부파일 정보의 관계를 확인한다. (첨부파일 잔체 가져오기)
		List<HashMap<String, Object>>files	= aDao.fileSelect(boardSeq,typeSeq);
		// 가져온 첨부파일이 엇ㅂ으면 (더이상 첨부파일이 없으면)
		if(files == null || files.size() == 0) {
			//공지사항 게시글의 has_file을 0으로 바꾼다.
			result = (nDao.updateHasFile(boardSeq, typeSeq)==1 && result);
		}
		//물리디스크에서 삭제 한다.
		result = fUtil.deleteFile(attach) == result;

		return result;
	}
}
