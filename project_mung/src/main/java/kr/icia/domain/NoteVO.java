package kr.icia.domain;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;

@Data
public class NoteVO {
	private int noteno;
	private String sentid;
	private String recvid;
	private String title;
	private String content;
	
	
	@JsonFormat(pattern="yyyy-MM-dd HH:mm:ss")
	private Date sentDate;
	
	@JsonFormat(pattern="yyyy-MM-dd HH:mm:ss")
	private Date readDate;
	
	private String recvread;
	private String sentdel;
	private String recvdel;
}
