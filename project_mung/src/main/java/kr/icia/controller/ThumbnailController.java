package kr.icia.controller;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.text.SimpleDateFormat;
import java.util.Date;
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
public class ThumbnailController {
 
    String uploadFolder = "D:\\str3\\sts-bundle\\project\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\project_mung\\resources\\images";
    
    @PostMapping(value="/uploadImageAction",
    		produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
    @ResponseBody
    @PreAuthorize("isAuthenticated()")
    public ResponseEntity<AttachImageDTO> getThumbnailImage(MultipartFile uploadImage) {
        
    	AttachImageDTO image = new AttachImageDTO();
    	
    	String uploadFolderPath = getFolder();
    	
    	File uploadPath = new File(uploadFolder,uploadFolderPath);
    	
    	if(uploadPath.exists() == false) {
			uploadPath.mkdirs();
			// 경로에 폴더들이 생성되어 있지 않다면, 폴더 생성.
		}
    	
    	String uploadImageName = uploadImage.getOriginalFilename();
    	
    	// 인터넷 익스플로어 경우, 예외 처리
    	uploadImageName =uploadImageName.substring(
    			uploadImageName.lastIndexOf("\\")+1
    					);
    	
    	image.setFileName(uploadImageName);
    	
    	UUID uuid = UUID.randomUUID();
    	
    	uploadImageName = uuid.toString()+"_"+uploadImageName;
    	
		try {
			
			File saveFile = new File(
					uploadPath,
					uploadImageName
					);
			
			uploadImage.transferTo(saveFile);
			
			/*
			 * Thumbnails.of(uploadPath+"\\"+uploadImageName) .allowOverwrite(true)
			 * .forceSize(200,200) .toFile(uploadPath+"\\"+uploadImageName);
			 */
				
		} catch (Exception e) {
			e.printStackTrace();
		} 
    	
    	
    		
    	image.setUuid(uuid.toString());
    	image.setImagePath(uploadFolderPath);
    	
                     
        
    	return new ResponseEntity<>(image,HttpStatus.OK);
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
    
    @PostMapping("/deleteFile")
	@ResponseBody
	@PreAuthorize("isAuthenticated()")
	public ResponseEntity<String> deleteFile(
			String fileName, String type
			){
		log.info("deleteFile : "+fileName);
		
		File file;
		
		try {
			file = new File("D:\\str3\\sts-bundle\\project\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\project_mung\\resources\\images"+URLDecoder.decode(fileName,"UTF-8"));
			System.out.println(file);
			// 한글처리를 위한 파일이름을 UTF-8 방식으로 처리
			// 알맞은 문자 포맷을 해석해서 읽어 들여야 함
			file.delete();
			// 파일 삭제
		}catch(UnsupportedEncodingException e) {
			e.printStackTrace();
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
		
		
		return new ResponseEntity<String>("deleted",HttpStatus.OK);
	}
}
