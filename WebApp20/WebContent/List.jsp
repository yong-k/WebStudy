<%@page import="java.net.URLDecoder"%>
<%@page import="com.test.BoardDTO"%>
<%@page import="java.util.List"%>
<%@page import="com.test.BoardDAO"%>
<%@page import="com.util.MyUtil"%>
<%@page import="com.util.DBConn"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
	//--==>> /WebApp20 → 여기를 리소스를 관리하는 출발지점으로 잡는 것
	// 여기서 출발하는 상대경로를 절대경로처럼 쓰려고 하는 것이다.
	// 편한점
	// contextPath 는 고정값처럼 지정되어 있기 때문에
	// 만약 css 파일 절대경로로 가져온다고 하면
	// href="C:/WebStudy/~~~" 써야 하는데
	// href='<%=cp%/css/main.css'
	// 이렇게 할 수 있어진다. 
	// (위에 href쓴거에서 값넣는부분 닫는괄호 처리 일부러 저렇게 해놓음... )
%>
<%
	// 리스트 번호 목록에서 페이지 눌렀을 때, 컨텐트 눌렀을 때
	// 다른 페이지로 가는 거 아니고 『List.jsp』 이다.
	// → 내가 던지고 내가 받는거. 예전에 했던 SendAndReceive.jsp 같은 거!!
	// 그럼 제일 먼저 해 줘야 하는 처리!!!
	// │
	// └→ 이전 페이지(List.jsp.....)로부터 데이터 수신(pageNum, num, searchKey, searchValue ...)
	//      그 중에 제일 먼저 신경써야 하는 건 → num(게시물 번호)
	
	// 이전 페이지로부터 넘어온 게시물 번호 수신
	String strNum = request.getParameter("num");
	int num = 0;		//-- 게시물 번호 제대로 넘겨받지 못할 경우에는 num = 0
	if (strNum != null)
		num = Integer.parseInt(strNum);
	
	// 이전 페이지로부터 넘어온 페이지 번호 수신
	String pageNum = request.getParameter("pageNum");
	int currentPage = 1;
	if (pageNum != null)
		currentPage = Integer.parseInt(pageNum);
	
	// 이전 페이지로부터 검색 키와 검색 값 수신
	String searchKey = request.getParameter("searchKey");
	String searchValue = request.getParameter("searchValue");
	
	//-- searchKey가 null 이 아니라는 것의 의미는
	//   검색을 통해서 이 페이지가 요청되었다는 것!
	//-- 우리는 searchKey 와 Value를 get방식으로 넘길 것이다.
	// 페이지로 넘기는 인코딩 방식(body방식)과 URL 로 넘기는 인코딩 방식(header방식)은 다르다.
	// header로 전달된 것이 
	// 해당 페이지 body에서 지원하지 않는 인코딩 방식이라면 예외 발생하는 구조로 짜여져있다.
	if (searchKey != null)		//-- 검색 기능을 통해 이 페이지가 요청되었을 경우
	{
		// 넘어온 값이 GET 방식이라면...(method="get" 방식으로 form 전달되었다면,)
		if (request.getMethod().equalsIgnoreCase("GET"))
		{
			// 디코딩 처리
			// get 방식에서는 넘어오는 값들도 쿼리스트링에 포함되어 있다.
			// → GET 은 한글 문자열을 인코딩해서 보내기 때문에...
			// → 그래서 디코딩 처리 해줘야 한다.
			searchValue = URLDecoder.decode(searchValue, "UTF-8");
			
		}
	}
	else 						//-- 검색 기능이 아닌 기본적인 페이지 요청이 이루어졌을 경우
	{
		searchKey = "subject";
		searchValue = "";
	}
	
	
	
	
	Connection conn = DBConn.getConnection();
	BoardDAO dao = new BoardDAO(conn);
	MyUtil myUtil = new MyUtil();
	

	// 전체 데이터 개수 구하기
	int dataCount = dao.getDataCount(searchKey, searchValue); 
	
	
	// 전체 페이지를 기준으로 총 페이지 수 계산
	int numPerPage = 10;	//-- 한 페이지에 표시할 데이터 개수
	int totalPage = myUtil.getPageCount(numPerPage, dataCount);
	
	
	// 전체 페이지 수 보다 표시할 페이지가 큰 경우
	// 표시할 페이지를 전체 페이지로 처리
	// → 한 마디로, 데이터를 삭제해서 페이지가 줄어들었을 경우...
	// 내가 11페이지에 머물러있었는데, 
	// 다른 사람이 게시물 삭제해서 전체 페이지수가 10페이지가 되었을 때..!
	// 나는 섬처럼 둥둥 떠서 11페이지에 머물고 있는 상황이 된다.
	if (currentPage > totalPage)
		currentPage = totalPage;
	
	
	// ┌→ 검색한 내용 중에 한 페이지에 띄울 분량 가져오는 거!
	// │   [내용: 음식] 검색했으면 현재 1페이지면, rownum 이 start=1, end=10
	// │ 							현재 2페이지면, rownum 이 start=2, end=20		
	// 데이터베이스에서 가져올 시작과 끝 위치
	int start = (currentPage-1) * numPerPage + 1;
	int end = currentPage * numPerPage;
	
	
	// 실제 리스트 가져오기
	List<BoardDTO> lists = dao.getLists(start, end, searchKey, searchValue);
	
	
	// 페이징 처리
	String param = "";
	
	
	// 검색값이 존재한다면
	if (!searchValue.equals(""))
	{
		// url로 들어갈 거기 때문에 "" 사이에는 공백이 들어있으면 안된다.
		param += "?searchKey=" + searchKey;
		param += "&searchValue=" + searchValue;
	}
	
	String listUrl = "List.jsp" + param;
	String pageIndexList = myUtil.pageIndexList(currentPage, totalPage, listUrl);
	
	
	// 글 내용 보기 주소
	String articleUrl = cp + "/Article.jsp";
	
	
	// 검색 값이 없었다면, param = ""  인 상태로 여기에 왔을 것이다.
	if (param.equals(""))
		articleUrl = articleUrl + "?pageNum=" + currentPage;
	else
		articleUrl = articleUrl + param + "&pageNum=" + currentPage;
	//-- pageNum 왜 넘길까?
	//   리스트에서 게시물 클릭하면 
	//   articleUrl 은 Article.jsp로 가서 상세내용 보게 되는것이다.
	//   게시물 번호만 붙잡고 들어가서 해당 게시물 열람하면 되는데..왜 pageNum 손에 쥐어줬을까?
	//   → if 2페이지에서 클릭해서 상세내용 보러 들어가면,
	//      그 page에서는 [리스트로 돌아가기] 버튼이 있는데, 돌아갔을 때 2 페이지여야한다.
	//      제대로 구현안해놓으면 리스트로 돌아가기 했을 때,
	//      내가 원래 있던 페이지로 돌아가는 게 아니라, 1페이지로 계속 돌아가진다....!!!
	//      → 그거 구현하기 위해서 pageNum 넘긴다.
	
	DBConn.close();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>List.jsp</title>
<link rel="stylesheet" type="text/css" href="<%=cp %>/css/style.css">
<link rel="stylesheet" type="text/css" href="<%=cp %>/css/list.css">
<script type="text/javascript">
 
	function sendIt()
	{
		var f = document.searchForm;
		
		// 검색 키워드에 대한 유효성 검사 코드 활용 가능~!!!
		
		// check~!!!
		// form의 action 속성 여기서도 지정해줄 수 있다.
		f.action = "<%=cp%>/List.jsp";
		
		f.submit();
	}
	 
</script>
</head>
<body>

<%--
<div>
	<h1><%=cp %></h1>
</div>
--%>

<div id="bbsList">

	<div id="bbsList_title">
		게 시 판 (JDBC 연동 버전)
	</div>
	
	<div id="bbsList_header">
		
		<div id="leftHeader">
			
			<!-- 검색 폼 구성 -->
			<form action="" name="searchForm" method="post">
				<select name="searchKey" class="selectFiled">
					<!-- 예전 만년달력했을 때 떠올려보면, selected 처리안하면
					     사용자가 뭘 이전에 선택했던지 간에, 다시 selectbox 원래대로 돌아감
					     ex) '작성자'선택하고 '홍길동' 입력해서 검색햇는데,
					         검색된 내용 아래 쭉 나오는데, selectbox는 '제목'으로 다시 돌아가있음 ㅎㅎ
					     사용자가 예전에 선택했던 내용을 페이지 다시 불러와서도
					     선택되어있는 상태로 만들기 위한 처리해보자 -->
					<!--     
					<option value="subject">제목</option>
					<option value="name">작성자</option>
					<option value="content">내용</option>
					-->
					<%
					if (searchKey.equals("name"))		// 수신한 searchKey 가 name 이라면...
					{
					%>
						<option value="subject">제목</option>
						<option value="name" selected="selected">작성자</option>
						<option value="content">내용</option>
					<%
					}
					else if (searchKey.equals("content"))	// 수신한 searchKey 가 content 라면...
					{
					%>
						<option value="subject">제목</option>
						<option value="name">작성자</option>
						<option value="content" selected="selected">내용</option>
					<%
					}
					else		// 수신한 searchKey 가 subject 이거나... 없으면...!
					{
					%>
						<!-- 67번 line에서도 선택된거 없으면 subject로 설정하기로,  -->
						<!-- 검색 기능이 아닌 기본적인 페이지 요청이 이루어졌을 경우에는 subject 로 하자고 한 코드가 있다. -->
						<option value="subject" selected="selected">제목</option>
						<option value="name">작성자</option>
						<option value="content">내용</option>
					<%
					}
					%>
				</select>
				<!-- 내가 '이름'선택하고 '홍길동' 입력해서 검색했으면 페이지 다시 요청되어도
					 '홍길동'값 남아있게 처리 
					  → value에 searchValue 값 넣어주자!! --> 
				<input type="text" name="searchValue" class="textFiled" value="<%=searchValue%>">
				<input type="button" value="검색" class="btn2" onclick="sendIt()">
			</form>
		</div><!-- #leftHeader -->
		
		<div id="rightHeader">
			<!-- 버튼 클릭했을 때 해당 페이지 직접요청하게끔! -->
			<input type="button" value="글올리기" class="btn2"
			onclick="javascript:location.href='<%=cp%>/Created.jsp'">
		</div><!-- #rightHeader -->
		
	</div><!-- #bbsList_header -->
	
	<div id="bbsList_list">
	
		<div id="title">
			<dl>
				<dt class="num">번호</dt>
				<dt class="subject">제목</dt>
				<dt class="name">작성자</dt>
				<dt class="created">작성일</dt>
				<dt class="hitCount">조회수</dt>
			</dl>
		</div><!-- #title -->
		
		<div id="lists">
			<!-- 
			<dl>
				<dd class="num">1</dd>
				<dd class="subject">안녕하세요</dd>
				<dd class="name">김정용</dd>
				<dd class="created">2022-04-25</dd>
				<dd class="hitCount">0</dd>
			</dl>
			 -->
			 
			 <%
			 for (BoardDTO dto : lists)
			 {
			 %>

			 <!-- 목록 10개라고 상세보기 페이지에 10개 다 보여주는 거 아니다.
			 	  상세보기 페이지는 하나인데, 그 안에 뭘 해당 게시물 내용 동적으로 보여준다. 
			 	  리스트 보여주는 것도 마찬가지로 동적으로 처리하는 것이다. 
			 	  → 보여주는 페이지 하나로 안에 내용물 채우겠다 (동적으로 처리) -->
			 <dl>
				<dd class="num"><%=dto.getNum() %></dd>
				<!-- 제목 클릭하면 내용 보이게끔, 링크로 만들기 -->
				<dd class="subject">
					<a href="<%=articleUrl%>&num=<%=dto.getNum()%>"><%=dto.getSubject() %></a>
				</dd>
				<dd class="name"><%=dto.getName() %></dd>
				<dd class="created"><%=dto.getCreated() %></dd>
				<dd class="hitCount"><%=dto.getHitCount() %></dd>
			</dl>
			
			 <%
			 }
			 %>
		</div><!-- #lists -->
		
		<div id="footer">
		
			<!-- <p>1 Prev 21 22 23 24 25 26 27 28 29 30 Next 42</p> -->
			<!-- <p>등록된 게시물이 존재하지 않습니다.</p> -->
			
			<p>
			<%
			if (dataCount != 0)
			{
			%>
				<%=pageIndexList %>
			<%
			}
			else
			{
			%>
				등록된 게시물이 존재하지 않습니다.
			<%
			}
			%>
			</p>
			
		</div><!-- #footer -->
	
	</div><!-- #bbsList_list -->

</div><!-- #bbsList -->

</body>
</html>