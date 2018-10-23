package com.hsc.pf.service.impl;

import java.io.File;
import java.util.ArrayList;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.hsc.pf.dao.BoardAttachDao;
import com.hsc.pf.service.BoardAttachService;


@Service	
public class BoardAttachServiceImpl implements BoardAttachService {
	@Autowired BoardAttachDao bAttachDao;
	
	@Value("#{config['file.save.location']}")
	private String saveLocation;
	
	
	@Override
	public Map<String, Object> getAttach(int fileIdx) {
		// TODO Auto-generated method stub
		return bAttachDao.getAttach(fileIdx);
	}

	@Override
	public int deleteAttach(int file_idx) {
		
		return bAttachDao.deleteAttach(file_idx);
	}

	@Override
	public int updateUnlinkedInfo() {
		//1. 첨부파일 정보 다 가져오기
		ArrayList<Map<String, Object>> targets = bAttachDao.fileInfo();

		ArrayList<Integer> fileIdxs = new ArrayList<Integer>();
		
		//2. 파일 있는지 없는지
		for (Map<String, Object> target : targets) {
			String fakeFilname = String.valueOf(target.get("fake_filename"));
			File f = new File(saveLocation, fakeFilname);
			
		//2-1. 없으면, 컬럼(linked) 값 수정 
			if(!f.exists()) {
				int fileIdx = Integer.parseInt(String.valueOf(target.get("file_idx")));
				fileIdxs.add(fileIdx);
				//1건씩
				//int result = bAttachDao.updateLinkedInfo(fileIdx);
			}
		}
		
		//한번에 업데이트
		int result = 0;
		if(fileIdxs.size() > 0)
		result = bAttachDao.updateLinkedInfos(fileIdxs);
		
		return result;
	}

}
