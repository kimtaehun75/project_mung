package kr.icia.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.icia.domain.NoteVO;

public interface NoteMapper {
	public String getRecvCount(String userid);
	
	public NoteVO getSent(
			@Param("noteno") int noteno
			);
	public NoteVO getRecv(
			@Param("noteno") int noteno
			);
	public void writemail(NoteVO vo);
	
	public List<NoteVO> getSentList(@Param("userid")
		String userid);

	public List<NoteVO> getRecvList(@Param("userid")
		String userid);
	
	public int updateRecvCount(@Param("noteno") int noteno);
}
