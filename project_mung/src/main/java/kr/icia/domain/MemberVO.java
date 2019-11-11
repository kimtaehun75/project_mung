package kr.icia.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class MemberVO {
	private int userno;
	private String userid;
	private String userpw;
	private String userName;
	private String addr_1;
	private String addr_2;
	private String addr_3;
	private String email;
	private String phone;
	private String birth;
	private Date joinDate;
	private Date updateDate;
	private int report;
	private String adopt;
	private String enabled;
	private List<AuthVO> authList;
	private MemberImageVO attachImage;
	private GradeVO grade;
}
