package com.test;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.util.DBConn;

public class MemberDAO
{
	private Connection conn;
	
	// 데이터베이스 연결 connection()
	public Connection connection() throws ClassNotFoundException, SQLException
	{
		conn = DBConn.getConnection();
		return conn;
	}
	
	// 데이터 입력	add()
	public int add(MemberDTO dto) throws SQLException
	{
		int updateCount = 0;
		String sql = "INSERT INTO TBL_MEMBER(SID, NAME, TEL)"
				  + " VALUES(MEMBERSEQ.NEXTVAL, ?, ?)";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, dto.getName());
		pstmt.setString(2, dto.getTel());
		updateCount = pstmt.executeUpdate();
		
		pstmt.close();
		return updateCount;
	}
	
	// 데이터 리스트 출력 lists()
	public ArrayList<MemberDTO> lists() throws SQLException
	{
		ArrayList<MemberDTO> memberList = new ArrayList<MemberDTO>();
		String sql = "SELECT SID, NAME, TEL FROM TBL_MEMBER ORDER BY SID";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();
		while (rs.next())
		{
			MemberDTO dto = new MemberDTO();
			dto.setSid(rs.getString("SID"));
			dto.setName(rs.getString("NAME"));
			dto.setTel(rs.getString("TEL"));
			
			memberList.add(dto);
		}
		rs.close();
		pstmt.close();
		return memberList;
	}
	
	// 전체 인원 수 count()
	public int count() throws SQLException
	{
		int count = 0;
		String sql = "SELECT COUNT(*) AS COUNT FROM TBL_MEMBER";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();
		if (rs.next())
			count = rs.getInt("COUNT");
		
		rs.close();
		pstmt.close();
		return count;
	}
	
	// sid 통해서 회원 검색 searchMember()
	public MemberDTO searchMember(String sid) throws SQLException
	{
		MemberDTO dto = new MemberDTO();
		String sql = "SELECT SID, NAME, TEL FROM TBL_MEMBER WHERE SID=?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, sid);
		ResultSet rs = pstmt.executeQuery();
		while (rs.next())
		{
			dto.setSid(rs.getString("SID"));
			dto.setName(rs.getString("NAME"));
			dto.setTel(rs.getString("TEL"));
		}
		rs.close();
		pstmt.close();
		
		return dto;
	}
	
	// 데이터 수정 modify()
	//★public int modify(String sid)
	public int modify(MemberDTO dto) throws SQLException
	{
		int updateCount = 0;
		String sql = "UPDATE TBL_MEMBER"
				  + " SET NAME=?, TEL=?"
				  + " WHERE SID=?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, dto.getName());
		pstmt.setString(2, dto.getTel());
		pstmt.setString(3, dto.getSid());
		updateCount = pstmt.executeUpdate();
		
		pstmt.close();
		return updateCount;
	}
	
	// 데이터 삭제 remove()
	public int remove(String sid) throws SQLException
	{
		int updateCount = 0;
		String sql = "DELETE TBL_MEMBER WHERE SID=?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, sid);
		updateCount = pstmt.executeUpdate();
		
		pstmt.close();
		return updateCount;
	}
	
	// 자식 테이블의 참조 데이터 레코드 수 확인 refCount()
	//★public int refCount()
	public int refCount(String sid) throws SQLException
	{
		int refCount = 0;
		String sql = "SELECT COUNT(*) AS COUNT"
				  + " FROM TBL_MEMBERSCORE"
				  + " WHERE SID=?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, sid);
		ResultSet rs = pstmt.executeQuery();
		if (rs.next())
			refCount = rs.getInt("COUNT");
		
		rs.close();
		pstmt.close();
		return refCount;
	}
	
	// 데이터베이스 연결 종료 close()
	public void close() throws SQLException
	{
		DBConn.close();
	}
}
