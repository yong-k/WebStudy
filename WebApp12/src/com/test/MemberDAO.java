/*==========================================
	MemberDAO.java
	- 데이터베이스 액션 처리 전용 클래스
	  (TBL_MEMBER 테이블 전용 DAO)
	  → 쿼리문 관련한 거는 얘랑 상담하려고
	     만들어놓은거라
	     쿼리문 관련 새로운 거 하려면
	     여기에 메소드 추가하면 된다.
===========================================*/


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
	
	// 데이터베이스 연결 담당 메소드
	public Connection connection() throws ClassNotFoundException, SQLException
	{
		conn = DBConn.getConnection();
		return conn;
	}
	
	// 데이터 입력 담당 메소드
	public int add(MemberDTO dto) throws SQLException
	{
		// executeUpdate(): 적용된 행(row)의 개수 반환
		int result = 0;
		String sql = "INSERT INTO TBL_MEMBER(SID, NAME, TEL)"
				  + " VALUES(MEMBERSEQ.NEXTVAL, ?, ?)";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, dto.getName());
		pstmt.setString(2, dto.getTel());
		
		result = pstmt.executeUpdate();
		
		pstmt.close();
		return result;
	}
	
	// 회원 리스트 출력 담당 메소드 
	public ArrayList<MemberDTO> lists() throws SQLException
	{
		ArrayList<MemberDTO> result = new ArrayList<MemberDTO>();
		String sql = "SELECT SID, NAME, TEL FROM TBL_MEMBER ORDER BY SID";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();
		while (rs.next())
		{
			MemberDTO dto = new MemberDTO();
			dto.setSid(rs.getString("SID"));
			dto.setName(rs.getString("NAME"));
			dto.setTel(rs.getString("TEL"));
			
			result.add(dto);
		}
		rs.close();
		pstmt.close();
		
		return result;
	}
	
	// 전체 인원 수 확인 담당 메소드
	public int count() throws SQLException 
	{
		int result = 0;
		String sql = "SELECT COUNT(*) AS COUNT FROM TBL_MEMBER";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();
		if (rs.next())
			result = rs.getInt("COUNT");
		
		rs.close();
		pstmt.close();

		return result;
	}
	
	// 데이터베이스 연결 종료(해제) 담당 메소드
	public void close() throws SQLException
	{
		DBConn.close();
	}
	
	// 메소드 추가
	// 번호 검색 담당 메소드(번호를 통해 회원 데이터 조회)
	//-- 현재... 번호(sid)는 TBL_MEMBER 테이블에서 식별자의 역할을 수행하고 있으며
	//   번호를 통한 검색 결과는 한 명의 회원일 수 밖에 없기 때문에
	//   반환 자료형은 MemberDTO들이 아니라 MemberDTO 형태로 구성하면 된다.
	public MemberDTO searchMember(String sid) throws SQLException
	{
		MemberDTO result = new MemberDTO();
		
		String sql = "SELECT SID, NAME, TEL FROM TBL_MEMBER WHERE SID=?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, sid);
		ResultSet rs = pstmt.executeQuery();
		while (rs.next())
		{
			result.setSid(rs.getString("SID"));
			result.setName(rs.getString("NAME"));
			result.setTel(rs.getString("TEL"));
		}
		rs.close();
		pstmt.close();
		
		return result;
	}
	
	// 메소드 추가
	// 회원 데이터 수정 담당 메소드
	public int modify(MemberDTO member) throws SQLException
	{
		int result = 0;
		String sql = "UPDATE TBL_MEMBER"
				  + " SET NAME=?, TEL=?"
				  + " WHERE SID=?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, member.getName());
		pstmt.setString(2, member.getTel());
		pstmt.setString(3, member.getSid());
		
		result = pstmt.executeUpdate();
		pstmt.close();
		
		return result;
	}
	
	// 메소드 추가
	// 회원 데이터 삭제 담당 메소드
	// 지금은 목록상에 리스트로 다 뿌려져 있기 때문에, 
	// 뭔가를 찾아서 삭제할 필요가 없다.
	public int remove(String sid) throws SQLException
	{
		int result = 0;
		String sql = "DELETE FROM TBL_MEMBER WHERE SID=?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, sid);
		
		result = pstmt.executeUpdate();
		pstmt.close();
		
		return result;
	}
	
	// 메소드 추가
	// 자식 테이블의 참조 데이터 레코드 수 확인
	public int refCount(String sid) throws SQLException
	{
		int result = 0;
		
		String sql = "SELECT COUNT(*) AS COUNT"
				  + " FROM TBL_MEMBERSCORE"
				  + " WHERE SID=?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, sid);
		
		ResultSet rs = pstmt.executeQuery();
		while (rs.next())	
			result = rs.getInt("COUNT");
		
		rs.close();
		pstmt.close();
		
		return result;
	}
}
