package kr.icia.domain;

import lombok.Data;

@Data
public class AttachImageDTO {
	private String fileName;
	private String imagePath;
	private String uuid;
	private boolean image;
}
