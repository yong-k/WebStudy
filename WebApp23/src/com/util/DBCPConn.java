/*==================
	DBCPConn.java
===================*/

package com.util;

import java.sql.Connection;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

/*
 DBConn 이 했던 걸 얘가 하게끔 하려고 한다.
 Connection 과 관련된거 context가 관리하게 resource 에 등록해놓음
 그 자원관리를 누가 해? → container
 상세내용은 xml의 context에 다 남겨놓음
 DBConn.getConnection() 한 거 처럼
 연결 하려면 DBCPConn.getConnection() 하면 된다. 
 
 ★★★ DBConn 사용하면 프로그램 배포된 후에, 
 url, username, password 변경 불가능하지만,
 지금 DBCPConn 은 xml에 값 넣어놨기 때문에 변경가능하다!!
*/
public class DBCPConn
{
	private static Connection conn = null;
	
	public static Connection getConnection()
	{
		if (conn == null)
		{
			try
			{
				// ○ 이름과 객체를 바인딩 
				//    (servlet container 한테 context 얻어서 쓸 수 있게 해준다.)
				//-- 컨텍스트(Context)를 얻어내는 가장 쉬운 방법은
				//   『javax.naming.InitialContext』클래스의
				//   인스턴스를 생성하는 것이다.
				//   → 『new InitialContext();』
				// 컨텍스트 있어야 최종 결과본과 만날 수 있음!
				
				// javax.naming.Context 로 선택하기
				Context ctx =  new InitialContext();	//-- 컨텍스트 얻어냄
				//-- ex) 게임팩 생성
				
				// ※ javax.naming.InitialContext 의 메소드
				//    - bind(String str, Object obj)
				//      : 서비스할 객체를 특정 이름으로 등록한다.
				//    - rebind(String str, Object obj)
				//		: 서비스할 객체를 특정 이름으로 다시 등록한다.
				//    - list(String str)
				//		: 특정 이름으로 서비스하는 객체 정보를 반환한다.
				//    - unbinding(String str)
				//		: 등록된 객체를 메모리에서 해제한다.
				//    - Object lookup(String str)
				//		: 서비스중인 객체 정보를 얻어온다.
				
				
				// ↓ 이건 고정된 형태로 써야하는 구문이다.
				// ↓ 『web.xml(배치기술서)』로 부터 환경 설정을 얻어오겠다는 코딩
				// ↓  다른 형태로 변경 불가!!
				// ↓  이렇게 하면 context 얻어낼 수 있다.     
				Context evt = (Context)ctx.lookup("java:/comp/env");
				//-- Type mismatch: cannot convert from Object to Context
				//   오류나기 때문에 (Context)로 다운캐스팅 해야 된다.
				//-- ex) 닌텐도 객체 생성
				
				// 여러개의 컨텍스트 내용 중에서
				// web.xml에 <res-ref-name>에 "jdbc/myOralce" 참조 이름 통해서
				// DataSource 얻어오겠다.
				// javax.sql 의 DataSource import 하기
				DataSource ds = (DataSource)evt.lookup("jdbc/myOracle");
				//-- ex) 닌텐도 활용해서 슈퍼마리오 얻어냄
				
				// DataSource 안에는 getConnection() 메소드가 있다.
				conn = ds.getConnection();
				//-- ex) 슈퍼마리오한테 버섯먹이는거 ㅋㅅㅋ 
				//       그래서 버섯먹고 커진 마리오(conn) 획득
				
			} catch (Exception e)
			{
				System.out.println(e.toString());
			}
		}
		
		return conn;
	}
	
	public static void close()
	{
		if (conn != null)
		{
			try
			{
				if (!conn.isClosed())
					conn.close();
				
			} catch (Exception e)
			{
				System.out.println(e.toString());
			}
		}
		
		conn = null;
	}
}
