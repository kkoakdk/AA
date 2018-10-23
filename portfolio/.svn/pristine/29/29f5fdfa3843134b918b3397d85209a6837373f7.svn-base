package com.hsc.pf.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface BoardAttachDao {
	

	public int insert(HashMap<String, Object> parms); 

	public List<HashMap<String, Object>>  fileSelect(int board_seq, int board_type_seq);

	public Map<String, Object> getAttach(int fileIdx);

	public int deleteAttach(int file_idx);

	public void del(int typeSeq, int boardSeq);

	public ArrayList<Map<String, Object>> fileInfo();
	
	public int updateLinkedInfo(int file_idx);
	
	public int updateLinkedInfos(ArrayList<Integer> file_idx);
}
