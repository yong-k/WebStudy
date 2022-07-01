package com.test;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.util.DBConn;

public class ScoreDAO
{
	private Connection conn;
	
	public ScoreDAO() throws ClassNotFoundException, SQLException
	{
		conn = DBConn.getConnection();
	}
	
	public int add(ScoreDTO dto) throws SQLException
	{
		int result = 0;
		
		//String sql = "INSERT INTO TBL_SCORE(SID, NAME, KOR, ENG, MAT)"
		//		  + " VALUES(SCORESEQ.NEXTVAL, ?, ?, ?, ?)";
		
		// 성적 입력값이 없거나 공백이면 -99로 처리해서 DB에 null로 값 넣음
		// 웹페이지 상에서는 성적 null 이면 0점으로 나오지만,
		// DB상에서는 0점과 null을 구분 (일단 지금은 여기까지........)
		String sql = "INSERT INTO TBL_SCORE(SID, NAME, KOR, ENG, MAT) "
				+ "VALUES(SCORESEQ.NEXTVAL, ?, NULLIF(?, -99), NULLIF(?, -99), NULLIF(?, -99))";
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		//pstmt.setInt(1, dto.getSid());	//-- ??? ㅎㅎ;;;;.....
		pstmt.setString(1, dto.getName());
		pstmt.setInt(2, dto.getKor());
		pstmt.setInt(3, dto.getEng());
		pstmt.setInt(4, dto.getMat());
		
		result = pstmt.executeUpdate();
		pstmt.close();
		
		return result;
	}
	
	public ArrayList<ScoreDTO> lists() throws SQLException
	{
		ArrayList<ScoreDTO> result = new ArrayList<ScoreDTO>();
		String sql = "SELECT SID, NAME, KOR, ENG, MAT, (NVL(KOR,0)+NVL(ENG,0)+NVL(MAT,0)) AS TOT, ROUND((NVL(KOR,0)+NVL(ENG,0)+NVL(MAT,0))/3, 1) AS AVG FROM TBL_SCORE ORDER BY SID";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();
		while (rs.next())
		{
			ScoreDTO dto = new ScoreDTO();
			dto.setSid(rs.getInt("SID"));
			dto.setName(rs.getString("NAME"));
			dto.setKor(rs.getInt("KOR"));
			dto.setEng(rs.getInt("ENG"));
			dto.setMat(rs.getInt("MAT"));
			dto.setTot(rs.getInt("TOT"));
			dto.setAvg(rs.getDouble("AVG"));
			
			result.add(dto);
		}
		rs.close();
		pstmt.close();
		
		return result;
	}
	
	public int count() throws SQLException
	{
		int result = 0;
		String sql = "SELECT COUNT(*) AS COUNT FROM TBL_SCORE";	
		PreparedStatement pstmt = conn.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();		
		if(rs.next())
			result = rs.getInt("COUNT");
		
		rs.close();
		pstmt.close();
		
		return result;
	}
	
	public void close() throws SQLException
	{
		DBConn.close();
	}
}
