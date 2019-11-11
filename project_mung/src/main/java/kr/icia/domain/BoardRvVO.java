package kr.icia.domain;

import java.util.Date;
import lombok.Data;

@Data
public class BoardRvVO {

	private int bno;
	private int saleno;
	private String userid;
	private String title;
	private String content;
	private Date updateDate;
	private int views;
	private int good;
	private BoardImageVO attachImage;
	
} //end class