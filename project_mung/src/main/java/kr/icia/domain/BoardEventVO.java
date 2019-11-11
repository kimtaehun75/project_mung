package kr.icia.domain;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class BoardEventVO {
	
	private int bno;
	private String userid;
	private String title;
	private String sub;
	private String content;
	
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date updateDate;
	
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date endDate;
	
	private int good;
	private BoardImageVO attachImage;
	
} // end class
