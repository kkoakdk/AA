package com.hsc.pf.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface BoardService {
	
	public int writing(HashMap<String, Object> writing);
	
	public List<Map<String, Object>> list(HashMap<String, String> params);
	
	public int getTotalCount(HashMap<String, String> params);

	public Map<String, Object> readAtcl(int boardSeq , int typeSeq);
	
	public int del(int boardSeq , int typeSeq);

	public int upd(HashMap<String, Object>params);

}

