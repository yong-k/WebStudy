<%@page import="com.test.BoardDTO"%>
<%@page import="com.test.BoardDAO"%>
<%@page import="com.util.DBConn"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<%
	Connection conn = DBConn.getConnection();
	BoardDAO dao = new BoardDAO(conn);
	
	// 이전 페이지(List.jsp → 목록 페이지)로부터 데이터(num, pageNum) 수신
	String pageNum = request.getParameter("pageNum");		//-- 페이지 번호
	String strNum = request.getParameter("num");			//-- 게시물 번호
	int num = Integer.parseInt(strNum);
	
	// 목록에서 해당 게시물로 들어왔으면, 
	// 먼저
	// 해당 게시물의 조회수를 +1 해줘야 한다.
	// → 해당 게시물의 조회수 증가
	dao.updateHitCount(num);
	
	// Article에서는 이전글, 다음글에 대한 내용도 필요하다.
	// 아래 띄워주고 있고, 그거 클릭하면 해당 글로 이동한다.
	// → 이전, 다음 게시물 번호 확인
													// 만약 우리가 지금 조회하고 있는게 22번이라면,
	int beforeNum = dao.getBeforeNum(num);			// 19 22번  이런거일 것이다. 번호를 확정지을 수는 없음!
	int nextNum = dao.getNextNum(num);				// 25 32번 혹은 뒤에 다 지워져서 없을수도 있음!
	
	
	// 번호만 가지고 있는게 아니라, DTO로 게시물 번호, 이름 등등 다 가지고 있으려고 한다.
	BoardDTO dtoBefore = null;
	BoardDTO dtoNext = null;
	
	// beforeNum 이 존재하는 상황이면, 이전번호의 게시물 내용 얻어오겠다.
	if (beforeNum != -1)
		dtoBefore = dao.getReadData(beforeNum);
	
	// afterNum 이 존재하는 상황이면, 다음번호의 게시물 내용 얻어오겠다.
	if (nextNum != -1)
		dtoNext = dao.getReadData(nextNum);
	

	// 해당 게시물의 상세 내용 가져오기 (현재 게시물)
	BoardDTO dto = dao.getReadData(num);
	
	
	// 라인수가 DB상에는 없는데, 보여주게 할꺼니까 처리해줘야 한다.
	// → 게시물 본문 라인 수 확인
	// 개행있을 때마다 잘려서 배열로 들어간다. 
	// → 배열 길이 확인해주면 → line 수가 된다.
	int lineSu = dto.getContent().split("\n").length;
	
	
	// ※ textarea로 받은 건 『\n』 → 『<br>』로 바꿔주어야 한다!!
	
	// 게시물 내용
	dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
	//-- 안녕하세요\n반갑습니다.\n즐거운오후입니다.\n안녕히가세요.
	//→ 안녕하세요<br>반갑습니다.<br>즐거운오후입니다.<br>안녕히가세요.
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Article.jsp</title>
<link rel="stylesheet" type="text/css" href="<%=cp %>/css/style.css">
<link rel="stylesheet" type="text/css" href="<%=cp %>/css/article.css">
</head>
<body>

<div id="bbs">

	<div id="bbs_title">
		게 시 판 (JDBC 연동 버전)
	</div><!-- close #bbs_title -->
	
	
	<div id="bbsArticle">
		
		<div id="bbsArticle_header">
			<!-- 게시물의 제목입니다. -->
			<%=dto.getSubject() %>
		</div><!-- close #bbsArticle_header -->
		
		
		<div class="bbsArticle_bottomLine">
			<dl>
				<dt>작성자</dt>
				<!-- <dd>김정용</dd> -->
				<dd><%=dto.getName() %></dd>
				
				<dt>라인수</dt>
				<!-- <dd>1</dd> -->
				<dd><%=lineSu %></dd>
			</dl>
		</div><!-- close .bbsArticle_bottomLine -->
		
		
		<div class="bbsArticle_bottomLine">
			<dl>
				<dt>등록일</dt>
				<!-- <dd>2022-04-27</dd> -->
				<dd><%=dto.getCreated() %></dd>
				
				<dt>조회수</dt>
				<!-- <dd>13</dd> -->
				<dd><%=dto.getHitCount() %></dd>
			</dl>
		</div><!-- close .bbsArticle_bottomLine -->
		
		
		<div id="bbsArticle_content">
			<table style="width: 600;">
				<tr>
					<td style="padding: 10px 40px 10px 10px; vertical-align: top; height: 150;">
						<!-- 어쩌구 저쩌구 이러쿵 저러쿵 내용입니다. -->
						<%=dto.getContent() %>
					</td>
				</tr>
			</table>
		</div><!-- close #bbsArticle_content -->
		
		
		<!--  
			이전글/다음글은 없을 경우
		-->
		
		<div class="bbsArticle_bottomLine">
			<!-- 이전글 : (104) 취미 관련 게시물 -->
			
			<%
			// beforeNum 이 존재한다면, 
			if (beforeNum != -1)
			{
			%>
				<a href="<%=cp%>/Article.jsp?pageNum=<%=pageNum%>&num=<%=beforeNum%>">
					이전글 : (<%=beforeNum %>) <%=dtoBefore.getSubject() %>
				</a>
			<%
			}
			else
			{
			%>
				이전글 : 없음
			<%
			}
			%>
		</div><!-- close .bbsArticle_bottomLine -->
		
		
		<div class="bbsArticle_noLine">
			<%
			// nextNum 이 존재한다면,
			if (nextNum != -1)
			{
			%>
				<a href="<%=cp%>/Article.jsp?pageNum<%=pageNum%>&num=<%=nextNum%>">
					다음글 : (<%=nextNum %>) <%=dtoNext.getSubject() %>
				</a>
			<%
			}
			else
			{
			%>
				다음글 : 없음
			<%
			}
			%>
		</div><!-- close .bbsArticle_noLine -->
		
		
	</div><!-- close #bbsArticle -->  					<!-- #bbsArticle 닫는 div 있는거 check~!!! -->
	
	<div class="bbsArticle_noLine" style="text-align: right;">
		<!-- From : 211.238.142.151 -->
		From : <%=dto.getIpAddr() %>
	</div><!-- close .bbsArticle_noLine -->
	
	
	<div id="bbsArticle_footer">
		
		<div id="leftFooter">
			 <!-- 수정한다고 하면 수정form 띄울것이다.
			 	  insert form 이랑 형식은 똑같은데, 안에 내용은 차있도록! -->
			 <!-- ++) 나: 수정 버튼 눌렀을 때 pw 입력하게 하고 입력했던 pw랑 안맞으면 수정 못하게 하면 될듯 -->
			 <!-- 수정/삭제 구분위해 각 버튼에 status 값 추가 
			      그럼 Updated.jsp에서 어떤 버튼에 의해 불려진 것 인지 알 수 있다. -->
			<input type="button" value="수정" class="btn2"
			onclick="javascript:location.href='<%=cp%>/Updated.jsp?num=<%=dto.getNum()%>&pageNum=<%=pageNum%>&status=1'">
			<input type="button" value="삭제" class="btn2"
			onclick="javascript:location.href='<%=cp%>/Updated.jsp?num=<%=dto.getNum()%>&pageNum=<%=pageNum%>&status=2'">
		</div><!-- close #leftFooter -->
		
		
		<div id="rightFooter">
			<input type="button" value="리스트" class="btn2"
			onclick="javascript:location.href='<%=cp%>/List.jsp?pageNum=<%=pageNum%>'">
			<!-- page1로 돌아가는게 아니라, 여기 들어오기전에 건네줬던 pageNum 다시 건네주면 된다. -->
		</div><!-- close #rightFooter -->
		
	</div><!-- close #bbsArticle_footer -->

</div><!-- close #bbs -->

</body>
</html>



















