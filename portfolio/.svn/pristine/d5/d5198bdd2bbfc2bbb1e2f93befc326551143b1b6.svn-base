package com.hsc.pf.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hsc.pf.dao.BoardDao;
import com.hsc.pf.service.BoardService;

@Service	
public class BoardServiceImpl implements BoardService{
	@Autowired private BoardDao bDao;

	@Override
	public int writing(HashMap<String, Object> writing) {
		int writ = bDao.writing(writing);

		// TODO Auto-generated method stub
		return writ;
	}
	@Override
	public List<Map<String, Object>> list(HashMap<String, String> params) {				//리스트를 선언하고 
		// TODO Auto-generated method stub
		List<Map<String, Object>> list = bDao.list(params);								//bDao에 list에서 값을 가져와서

		return list;																	//list에 리턴해 준다.
	}
	@Override
	public int getTotalCount(HashMap<String, String> params) {

		return bDao.getTotalCount(params);
	}
	@Override
	public Map<String, Object> readAtcl(int boardSeq, int typeSeq) {
		int hit = bDao.updateHit(boardSeq, typeSeq);
		Map<String, Object> readAtcl = bDao.getBoard(boardSeq , typeSeq);

		return readAtcl;
	}
	@Override
	public int del(int boardSeq, int typeSeq) {	
		int del = bDao.del(boardSeq, typeSeq);
		return del;
	}
	@Override
	public int upd(HashMap<String, Object> params) {
		// TODO Auto-generated method stub
		return bDao.upd(params);
	}
}



