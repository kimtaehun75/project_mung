package kr.icia.domain;

import org.springframework.web.util.UriComponentsBuilder;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Criteria {
	private int pageNum;
	private int amount;
	private int cateno;
	private String time;
	private String type;
	private String keyword;
	private String userid;
	
	public Criteria() {
		this(1,20);
	}
	
	public Criteria(int pageNum,int amount) {
		this.pageNum = pageNum;
		this.amount = amount;
	}
	
	public String[] getTypeArr() {
		// 검색 타입 배열 가져오기
		return type == null? new String[] {} : type.split("");
		// 검색 타입이 null이라면 비어있는 문자 배열을 생성하고, 존재한다면 잘라냄
		// 그렇지 않다면, 검색타입을 한글자씩 잘라서 문자열 배열로 만듬
	}
	
	public String[] getTimeArr() {
		// 검색 타입 배열 가져오기
		return time == null? new String[] {} : time.split("");
		// 검색 타입이 null이라면 비어있는 문자 배열을 생성하고, 존재한다면 잘라냄
		// 그렇지 않다면, 검색타입을 한글자씩 잘라서 문자열 배열로 만듬
	}

 	
	public String getListLink() {
		UriComponentsBuilder builder = UriComponentsBuilder.fromPath("")
				.queryParam("pageNum",this.pageNum)
				.queryParam("amount",this.getAmount())
				.queryParam("type",this.getType())
				.queryParam("keyword",this.getKeyword())
				.queryParam("time",this.getTime());
				
		
		return builder.toUriString();
	}
}
