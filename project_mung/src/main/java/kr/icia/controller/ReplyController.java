package kr.icia.controller;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import kr.icia.domain.Criteria;
import kr.icia.domain.ReplyPageDTO;
import kr.icia.domain.ReplyVO;
import kr.icia.domain.ReportVO;
import kr.icia.service.ReplyService;
import kr.icia.service.ReportService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@RequestMapping("/replies/")
@RestController
@Log4j
@AllArgsConstructor
public class ReplyController {
	
	private ReplyService service;
	
	private ReportService Rservice;
	
	// url 요청이 /replies/new로 오면,
	// 정보를 조회하여, 리턴하는데,
	// 정보 형태는 json
	// 전달 결과물은 평범한 문자열 형태
	@PostMapping(value ="/new", consumes="application/json",produces= {MediaType.TEXT_PLAIN_VALUE})
	@PreAuthorize("isAuthenticated()")
	public ResponseEntity<String> create(
			@RequestBody ReplyVO vo){
		// @RequestBody : json 형태로 받은 값을 객체로 변환함
		log.info("ReplyVO : "+vo);
		
		service.register(vo);
		
		return new ResponseEntity<>("success",HttpStatus.OK);
		// 페이지의 상태를 전달
	}
	
	@PostMapping(value ="/report", consumes="application/json",produces= {MediaType.TEXT_PLAIN_VALUE})
	@PreAuthorize("isAuthenticated()")
	public ResponseEntity<String> report(
			@RequestBody ReportVO vo){
		// @RequestBody : json 형태로 받은 값을 객체로 변환함
		log.info("ReportVO : "+vo);
		
		Rservice.insertReport(vo);
		
		return new ResponseEntity<>("success",HttpStatus.OK);
		// 페이지의 상태를 전달
	}
	
	
	// 댓글의 경우 게시물 별로 목록이 다르다.
	// 얻어진 값은 xml과 json으로 변환 가능.
	@GetMapping(value="/pages/{bno}/{page}", produces= { 
		MediaType.APPLICATION_XML_VALUE,
		MediaType.APPLICATION_JSON_UTF8_VALUE
	})
	public ResponseEntity<ReplyPageDTO> getList(
				@PathVariable("page") int page,
				@PathVariable("bno") int bno
				// @PathVariable : url로 넘겨받은 값 이용.
			){
		log.info("getList......");
		Criteria cri = new Criteria(page,10);
		log.info(cri);
		
		return new ResponseEntity<>(service.getListPage(cri, bno),HttpStatus.OK)  ;
		// T<List<ReplyVO>> = new T<>();
		// 댓글 목록을 출력하고, 정상 처리 상대를 리턴
	}
	
	@GetMapping(value="/pages/count/{bno}", produces= { 
			MediaType.APPLICATION_XML_VALUE,
			MediaType.APPLICATION_JSON_UTF8_VALUE
		})
	public ResponseEntity<String> getCount(
			@PathVariable("bno") int bno
				// @PathVariable : url로 넘겨받은 값 이용.
			){
		log.info("getCount......");
			
		return new ResponseEntity<>(service.getCount(bno)+"",HttpStatus.OK)  ;
			// T<List<ReplyVO>> = new T<>();
			// 댓글 목록을 출력하고, 정상 처리 상대를 리턴
	}
	
	
	
	@GetMapping(value="/{rno}", produces= {
			MediaType.APPLICATION_XML_VALUE,
			MediaType.APPLICATION_JSON_UTF8_VALUE
	})
	public ResponseEntity<ReplyVO> get(
				@PathVariable("rno") int rno
			){
		log.info("get : "+rno);
		return new ResponseEntity<>(service.get(rno),HttpStatus.OK);
		// 댓글 번호를 받으면 댓글을 조회함
	}
	
	@PreAuthorize("principal.username == #vo.userid")
	@DeleteMapping(value="/{rno}",
			produces= {
			MediaType.TEXT_PLAIN_VALUE
	})
	public ResponseEntity<String> remove(
				@RequestBody ReplyVO vo,
				@PathVariable("rno") int rno
			){
		log.info("remove : "+rno);
		// 댓글 삭제 요청 시 전달 받은 json 값으로,
		// ReplyVO vo 를 표기화 하고,
		// 그 값으로 현재 접속자와 댓글 작성자를 비교하여 일치하면 삭제
		
		return service.remove(rno)==1? new ResponseEntity<>("success",HttpStatus.OK):new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		
	}
	
	@PreAuthorize("principal.username == #vo.userid")
	@RequestMapping(method= {RequestMethod.PUT,
			RequestMethod.PATCH}, value="/{rno}",
			consumes="application/json",
			produces= {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> modify(
				@RequestBody ReplyVO vo,
				@PathVariable("rno") int rno
			){
		// put , patch : 둘 다 수정처리를 의미함
		// 생성되는 정보의 형태는 json에 일반적인 문자열 이용
		// @RequestBody : json으로 생성된 정보를 객체화
			vo.setRno(rno);
			log.info("rno :"+rno);
			
			return service.modify(vo)==1? new ResponseEntity<>("success",HttpStatus.OK):new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
}
