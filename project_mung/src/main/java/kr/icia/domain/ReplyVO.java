package kr.icia.domain;

import java.util.Date;

import lombok.Data;

@Data
public class ReplyVO {
	private int bno;
	private int rno;
	private String reply;
	private String userid;
	private String auth;
	private Date updateDate;
	private Date replyDate;
}
