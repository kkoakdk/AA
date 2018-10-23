package com.hsc.pf.service;

import java.util.HashMap;
import java.util.Map;

public interface BoardAttachService {
	public Map<String, Object> getAttach(int fileIdx);
	public int deleteAttach(int file_idx);

	/**
	 * 첨부파일 테이블에 있는 정보와 물리적 파일 간의
	 * 연결이 끊긴 데이터를 찾아서 특정 컬럼(linked)에 표시하라.
	 * @return
	 */
	public int updateUnlinkedInfo();
}
