package kr.icia.controller;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import kr.icia.domain.AttachImageDTO;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class ImageController {
	
String uploadFolder = "D:\\str3\\sts-bundle\\project\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\project_mung\\resources\\images";
    
    @PostMapping(value="/uploadImagesAction",
    		produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
    @ResponseBody
    @PreAuthorize("isAuthenticated()")
    public ResponseEntity<List<AttachImageDTO>> getThumbnailImage(MultipartFile[] uploadImage) {
        
    	List<AttachImageDTO> images = new ArrayList<>();
    	
    	String uploadFolderPath = getFolder();
    	
    	File uploadPath = new File(uploadFolder,uploadFolderPath);
    	
    	if(uploadPath.exists() == false) {
			uploadPath.mkdirs();
			// 경로에 폴더들이 생성되어 있지 않다면, 폴더 생성.
		}
    	
    	for(MultipartFile multipartFile : uploadImage) {
	    	AttachImageDTO imageDTO = new AttachImageDTO();
    		
    		String uploadImageName = multipartFile.getOriginalFilename();
	    	
	    	// 인터넷 익스플로어 경우, 예외 처리
	    	uploadImageName =uploadImageName.substring(
	    			uploadImageName.lastIndexOf("\\")+1
	    					);
	    	
	    	imageDTO.setFileName(uploadImageName);
	    	
	    	UUID uuid = UUID.randomUUID();
	    	
	    	uploadImageName = uuid.toString()+"_"+uploadImageName;
	    	
	    	log.info("fileName : "+uploadImageName);
	    	
		try {
			
			File saveFile = new File(
					uploadPath,
					uploadImageName
					);
			
			multipartFile.transferTo(saveFile);
			
			imageDTO.setUuid(uuid.toString());
	    	imageDTO.setImagePath(uploadFolderPath);
	    	
	    	images.add(imageDTO);
			
			/*
			 * Thumbnails.of(uploadPath+"\\"+uploadImageName) .allowOverwrite(true)
			 * .forceSize(200,200) .toFile(uploadPath+"\\"+uploadImageName);
			 */
				
			} catch (Exception e) {
				e.printStackTrace();
			} 
    	}
    	    		
    	return new ResponseEntity<>(images,HttpStatus.OK);
    }
    
    public String getFolder() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date date = new Date();
		String str = sdf.format(date);
		
		return str.replace("-",File.separator);
		// 파일 검색 시간을 줄이기 위해서
		// 폴더 1개에 모두 저장하는 것이 아니라
		// 년월일을 구분하여 파일을 생성하고 파일을 저장함
		// File.separator : 폴더 구분자를 운영체제에 맞춰서 변경
		// 2019-09-18
		// 2019/09/18 결과적으로 날짜별로 파일 저장
	}

}
