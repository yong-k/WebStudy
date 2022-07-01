<%@page import="com.test.MemberDTO"%>
<%@page import="com.test.MemberDAO"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<% 
	StringBuffer str = new StringBuffer();
	MemberDAO dao = new MemberDAO();
	String memberCount = "<span id='memberCount'>전체 인원 수 : ";
	
	try
	{
		dao.connection();
		
		memberCount += dao.count() + "명</span>";
		
		str.append("<table class='table'>");
		str.append("	<tr>");
		str.append("		<th style='width: 50px'>번호</th>");
		str.append("		<th style='width: 100px'>이름</th>");
		str.append("		<th style='width: 150px'>전화번호</th>");
		str.append("		<th style='width: 200px'>회원관리</th>");	
		str.append("	</tr>");
		
		for(MemberDTO member : dao.lists())
		{
			str.append("	<tr>");
			str.append("		<td>" + member.getSid() + "</td>");
			str.append("		<td>" + member.getName() + "</td>");
			str.append("		<td>" + member.getTel() + "</td>");
			str.append("		<td>");
			str.append("			<a href='MemberUpdateForm.jsp?sid=" + member.getSid() + "'>");
			str.append("				<button type='button' class='btn01'>수정</button>");
			str.append("			</a>");
			
			// memberDelete(1, '고길동')
			
			/*
				※ 자바스크립트에서 사용할 수 있는
			       따옴표의 종류 : ① ""
			            		   ② ''
			            		   ③ \"\"
			       일반적으로 따옴표가 두 번 중첩되어 사용하게 되면
			       ①과 ②를 사용하면 된다.
			       하지만, 따옴표가 세 번 중첩되어 사용될 경우
			       ③ escape 를 사용해야 한다.
			*/
			
	         // str.append("              <a href='javascript: memberDelete(1,\"고길동\")'>");
			str.append("			<a href='javascript:memberDelete(" + member.getSid() + ", \"" + member.getName() + "\")'>"); 
			str.append("				<button type='button' class='btn01'>삭제</button>");
			str.append("			</a>");
			str.append("		</td>");
			str.append("	</tr>");
		}
		str.append("</table>");
	}
	catch(Exception e)
	{
		System.out.println(e.toString());
	}
	finally
	{
		try
		{
			dao.close();
		}
		catch(Exception e)
		{
			System.out.println(e.toString());
		}
	}
		
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MemberSelect.jsp</title>
<link rel="stylesheet" type="text/css" href="css/MemberScore.css">
<style type="text/css">
	a { text-decoration: none; }
</style>
<script type="text/javascript">

	function memberDelete(sid, name)
	{
		// 확인
		//alert("함수 호출 확인~!!!");
		
		// 확인 											
		//alert("번호:" + sid + ", 이름:" + name);
		
		var res = confirm("번호:" + sid + ", 이름:" + name + "\n이 회원의 정보를 정말 삭제하시겠습니까?");
		//		  ------------------------------------------------------------------------------------------
		//         true/false 반환된다.
		
		// 확인
		//alert(res);
		//-- confirm() 함수를 통해 호출되는 창은
		//   true(확인) 또는 false(취소)를 반환하게 된다.
		
		// 그냥 get방식으로 바로 스크립트에서 요청
		if (res)
			window.location.href = 'MemberDelete.jsp?sid=' + sid;
		
		// true 면 저렇게 되고,
		// false 만 되면 그냥 함수만 끝나게 된다.
	}

</script>
</head>
<body>

<div>
	<h1>회원 <span style="color: red;">명단</span> 관리 및 출력 페이지</h1>
	<hr />
</div>

<div>
	<a href="MemberScoreSelect.jsp"><button type="button">회원 성적 관리</button></a>
	<a href="MemberInsertForm.jsp"><button type="button">신규 회원 등록</button></a>
	<!-- └→ 현재 보고 있는건 리스트 페이지
			  여기서 사용자가 『회원 등록』 누르면 『회원 입력 폼페이지』가 떠야한다.
			  거기에 사용자가 집어넣은 값들을 확인하고나서
			  『데이터 입력 액션 처리 페이지』에서 데이터 입력 액션 처리(insert) 수행하면 된다.
			  『데이터 입력 액션 처리 페이지』는 클라이언트와 만나지 않는다.
			  여기서는 sendRedirect("리스트페이지") 해준다.
			  리스트페이지는 불려질 때, 리스트 출력 액션(select)을 수행한다.
			  
			  회원 입력 폼페이지에는 입력하게해서 submit 시키면 된다. 	
			  
			  지금까지 우리가 만들었던거는 한 페이지 안에 
			  입력폼있고, submit 버튼있고,
			  그리고 그 아래는 list()가 출력되게 다 만들었었다.
			  → 액션을 묶어서 처리했었다.
			  
			  지금은 입력폼+submit 수행하는 게 					 → 회원입력폼페이지
			  														ex) MemberInsertForm.jsp
			         list() 출력되게 하는 거   					 → 리스트페이지
			         												ex) MemberSelect.jsp
			  그리고 클라이언트 안만나는 페이지 하나 만들었던 거 → 데이터 입력 액션 처리 페이지 
			         												ex) MemberInsert.jsp				
				
			  삭제는 버튼 누르면 
			  이 사람 정말 지울거냐는 창 띄워줄 거기 때문에 따로 form 필요 없고 
			  그냥 삭제 수행해주는 MemberDelete.jsp 페이지만 있으면 된다.  														
	 -->
</div>
<br />

<div>
	<%=memberCount %>
	<br /><br />
	<%=str %>
	
	<!-- 정적으로 리스트 출력 예시-->
	<!--  
	<table class="table">
		<tr>
			<th style="width: 50px">번호</th>
			<th style="width: 100px">이름</th>
			<th style="width: 150px">전화번호</th>
			<th style="width: 200px">회원관리</th>	
		</tr>
		<tr>
			<td>1</td>
			<td>희동이</td>
			<td>010-1111-1111</td>
			<td>
				<a href=""><button type="button" class="btn01">수정</button></a>
				<a href=""><button type="button" class="btn01">삭제</button></a>
			</td>
		</tr>
		<tr>
			<td>2</td>
			<td>도우너</td>
			<td>010-2222-2222</td>
			<td>
				<a href=""><button type="button" class="btn01">수정</button></a>
				<a href=""><button type="button" class="btn01">삭제</button></a>
			</td>
		</tr>
		<tr>
			<td>3</td>
			<td>마이콜</td>
			<td>010-3333-3333</td>
			<td>
				<a href=""><button type="button" class="btn01">수정</button></a>
				<a href=""><button type="button" class="btn01">삭제</button></a>
			</td>
		</tr>
	</table>
	-->
</div>


</body>
</html>

