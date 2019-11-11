package kr.icia.domain;

import java.util.Date;

import lombok.Data;

@Data
public class DogsVO {

	private int dogno;
	private String userid;
	private String dogName;
	private String kind;
	private int age;
	private String pre;
	private String gender;
	private String detail;
	private Date updateDate;
	private Date apprDate;
	private Date sellDate;
	private String adopt;
	private DogsImageVO attachImage;
	
}
