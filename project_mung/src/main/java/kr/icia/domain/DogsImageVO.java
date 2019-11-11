package kr.icia.domain;

import lombok.Data;

@Data
public class DogsImageVO {
	
	private String uuid;
	private String imagePath;
	private String fileName;
	private boolean fileType;
	private int dogno;

}
