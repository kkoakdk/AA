package com.hsc.pf.util;

import java.io.File;
import java.io.IOException;
import java.util.Map;

import org.apache.commons.io.FileUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;


public class FileUtil {
	Logger logger = Logger.getLogger(FileUtil.class);
	
	@Value("#{config['file.save.location']}")
	private String saveLocation;


	public byte[] readFile(Map<String, Object> attach) {
		//파일 찾기
		File f = new File(saveLocation, String.valueOf(attach.get("fake_filename")));
		byte[] b = null;
		if(f.exists()) { //물리적 위치에 존재하면
			//파일 byte단위로 읽어온다.
			try {
				b = FileUtils.readFileToByteArray(f);
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}else { //물리적 위치에 파일 없음
			
		}
		return b;
	}

	public boolean deleteFile(Map<String, Object> attach) {
		//파일찾기
		File f = new File(saveLocation, String.valueOf(attach.get("fake_filename")));
		if(f.exists()) {
			return f.delete(); //존제하면 지운다
		}
		return false;
	}
	
													   //예외 선언
	public void copyFile(MultipartFile mf, String fakename) throws IOException {
		
		logger.debug("saveLocation----"+saveLocation);
		//폴더 지정
		File destDir = new File(this.saveLocation);
		logger.debug("mdir exist----"+destDir.exists());
		if(!destDir.exists()) {
			//없으면 만든다
			destDir.mkdirs();
		}
		logger.debug("mdir----"+destDir);
		
		//파일 지정
		File destFile = new File(destDir, fakename);
		FileCopyUtils.copy(mf.getBytes(), destFile);
	}

}
