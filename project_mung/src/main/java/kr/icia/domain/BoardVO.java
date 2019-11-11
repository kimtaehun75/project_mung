package kr.icia.domain;

import java.util.Date;

import lombok.Data;

@Data
public class BoardVO {
	private int bno;
	
	private String userid;
	private String grade;
	private String tear;
	
	private String title;
	private String content;
	private Date updateDate;
	private int views;
	
	private int replyCnt;
	
	private BoardImageVO attachImage;
}
