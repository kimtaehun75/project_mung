package kr.icia.controller;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import kr.icia.domain.AttachFileDTO;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class FileController {
		
		String uploadFolder = "D:\\str3\\sts-bundle\\project\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\project_mung\\resources\\images";
		
		@PostMapping(value ="/uploadAjaxAction",
				produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
		@ResponseBody
		@PreAuthorize("isAuthenticated()")
		public ResponseEntity<List<AttachFileDTO>> uploadAjaxPost(MultipartFile[] uploadFile){
			// rest 방식 ajax 처리
			// 파일을 받고 json 값을 리턴함
			List<AttachFileDTO> list = new ArrayList<>();
			// 여러개 파일을 저장를 위한 객체 배열 타입 선언
			
			
			String uploadFolderPath = getFolder();
			// getFolder() 메소드를 통해 파일안에 만들 날짜를 구해옴
			File uploadPath = new File(uploadFolder,uploadFolderPath);
			// 예) c:\\upload\\2019\\09\\18에 파일 저장 예정.
			
			if(uploadPath.exists() == false) {
				uploadPath.mkdirs();
				// 경로에 폴더들이 생성되어 있지 않다면, 폴더 생성.
			}
			// 파일의 갯수가 여러 개 일수 있기 때문에 
			for(MultipartFile multipartFile : uploadFile) {
				AttachFileDTO attachDTO = new AttachFileDTO();
				
				String uploadFileName = multipartFile.getOriginalFilename();
				// 파일의 원래 이름을 저장함
				
				// 인터넷 익스플로어 경우, 예외 처리
				uploadFileName = uploadFileName.substring(
						uploadFileName.lastIndexOf("\\")+1
						);
				
				attachDTO.setFileName(uploadFileName);
				// 파일 이름 저장
				UUID uuid = UUID.randomUUID();
				// Universal unique identifier 의 약자, 범용 고유 식별자
				// 파일의 중복을 피하기 위함
				uploadFileName = uuid.toString()+"_"+uploadFileName;
				// uuid_일일일.txt
				
				try {
					File saveFile = new File(
							uploadPath,
							uploadFileName
							);
					multipartFile.transferTo(saveFile);
					// 서버에 파일 저장함
					attachDTO.setUuid(uuid.toString());
					attachDTO.setUploadPath(uploadFolderPath);
					
					list.add(attachDTO);
					// 업로드한 파일 정보를 객체 배열에 담아서 리턴함
				}catch(Exception e) {
					e.printStackTrace();
				}
			}
			return new ResponseEntity<>(list,HttpStatus.OK);
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
		
	@GetMapping(value="/download",
			produces=MediaType.APPLICATION_OCTET_STREAM_VALUE)
	@ResponseBody
	public ResponseEntity<Resource> downloadFile(
				@RequestHeader("User-Agent") String userAgent,
				String fileName
				// 서버에 접속한 브라우저의 정보는
				// 헤더의 User-Agent를 확인하면 알 수 있음
				){
			Resource resource = new FileSystemResource("c:\\upload\\"+fileName);
			log.info("resource : "+resource);
			
			if(resource.exists() == false) {
				return new ResponseEntity<>(
						HttpStatus.NOT_FOUND
						);
			}
			
			String resourceName = resource.getFilename();
			
			System.out.println(resourceName);
			System.out.println(resourceName.indexOf("_"));
			String resourceOriginalName = resourceName.substring(
					resourceName.indexOf("_")+1
					);
			// uuid를 제외한 파일명을 추출함
			HttpHeaders headers = new HttpHeaders();
			
			try {
				String downloadName = null;
				
				if(userAgent.contains("Trident")) {
					log.info("IE browser");
					downloadName = URLEncoder.encode(
							resourceOriginalName,"UTF-8"
							).replaceAll("\\"," ");
				}else if(userAgent.contains("Edge")) {
					log.info("Edge browser");
					downloadName = URLEncoder.encode(
							resourceOriginalName,"UTF-8"
							);
				}else {
					log.info("chrome browser");
					downloadName = new String(
							resourceOriginalName.getBytes("UTF-8"),
							"ISO-8859-1"
							);
					headers.add("Content-disposition","attachment; filename="+downloadName);
					// 헤더에 파일 다운로드 정보 추가
				}
				log.info("downloadName : "+downloadName);	
				}catch(UnsupportedEncodingException e) {
					e.printStackTrace(); 
				}
			
			return new ResponseEntity<Resource>(
					resource,headers,HttpStatus.OK
					);
	}	
}//end class