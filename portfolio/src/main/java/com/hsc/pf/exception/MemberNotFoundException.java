package com.hsc.pf.exception;

public class MemberNotFoundException extends Exception{

	private String message;

	public MemberNotFoundException() {
		this.setMessage("회원이 없습니다.");
	}
	public MemberNotFoundException(String message) {
		this.setMessage(message);
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}


}
