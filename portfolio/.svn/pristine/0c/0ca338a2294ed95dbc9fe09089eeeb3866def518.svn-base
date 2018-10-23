package com.hsc.pf.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface NoticeDao {
	
	public int writing(HashMap<String, Object> writing);
	
	public List<Map<String, Object>> listNotice(HashMap<String, String> params);

	public int getTotalCount(HashMap<String, String> params);
	
	public int updateHit(int typeSeq, int boardSeq); //조회수 울리기
	
	public Map<String, Object> getBoard(int typeSeq, int boardSeq); //게시글 한건 조회

	public int del(int typeSeq, int boardSeq);

	public int upd(HashMap<String, Object> params );

	public int updateHasFile(int board_seq ,int type_seq );

}