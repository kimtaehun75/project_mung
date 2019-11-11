package kr.icia.domain;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class CouponVO {
	private int cpnum;
	private String userid;
	private String cpName;
	private String cpContent;
	private String value;
	private String type;
	
	private String disCost;
	private String saleCost;
	
	private Date cpUpdate;
	
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date cpEndDate;
	
	private GradeVO grade;
}
