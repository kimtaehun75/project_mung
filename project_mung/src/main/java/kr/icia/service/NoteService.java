package kr.icia.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.icia.domain.NoteVO;

public interface NoteService {
	public String getRecvCount(String userid);
	
	public List<NoteVO> getSentList(String userid);
	
	public List<NoteVO> getRecvList(String userid);
	
	public NoteVO getSent(
			@Param("noteno") int noteno			
			);
	public NoteVO getRecv(
			@Param("noteno") int noteno			
			);
	public void writemail(NoteVO vo);
	
	public boolean updateRecvCount(
			@Param("noteno") int noteno
			);
}
