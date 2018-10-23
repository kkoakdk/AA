package com.hsc.pf.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

public interface NoticeService {
	
	public int writing(HashMap<String, Object> writing);
	
	public List<Map<String, Object>> listNotice(HashMap<String, String> params);
	

	public int getTotalCount(HashMap<String, String> params);

	public Map<String, Object> readAtcl(int boardSeq , int typeSeq);
	
	public int del(int boardSeq , int typeSeq, String hasFile);

	public int upd(HashMap<String, Object>params , List<MultipartFile> mFile);

	public int writeCant(HashMap<String, Object> parms, List<MultipartFile> mFile);

	public List<HashMap<String, Object>> fileSelect(int boardSeq, int boardTypeSeq);
	
	public boolean deleteAttach(int file_idx, int boardSeq, int typeSeq);

}

