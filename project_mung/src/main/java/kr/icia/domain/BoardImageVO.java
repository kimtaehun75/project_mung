package kr.icia.domain;

import lombok.Data;

@Data
public class BoardImageVO {
	private String uuid;
	private String imagePath;
	private String fileName;
	private boolean fileType;
	private int bno;
}
