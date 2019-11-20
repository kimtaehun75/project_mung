package kr.icia.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.icia.mapper.ImageMapper;
import lombok.Setter;

@Service
public class ImageServiceImpl implements ImageService {
	
	@Setter(onMethod_=@Autowired)
	private ImageMapper mapper;

	@Override
	public void removeUser(int userno) {
		
		
		mapper.deleteUser(userno);
		
	}

	@Override
	public int checkUserno(String userid) {
		
		
		
		return mapper.checkUserno(userid);
	}
	
	
}
