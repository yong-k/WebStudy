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
	// 게시물 수정 액션 요청 시 넘어온 데이터 수신
	
	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
	
	
	// 삭제 액션 요청 처리 과정에서 추가한 코드
	String statusStr = request.getParameter("status");
	int status = Integer.parseInt(statusStr);
	
	
	
	// 수정하러 들어왔으니 DB 연결
	Connection conn = DBConn.getConnection();
	BoardDAO dao = new BoardDAO(conn);
	
	BoardDTO dto = dao.getReadData(num);
	
	// 이메일 입력하지 않으면 수정폼에 null 로 뜨고 
	// 수정하기 누르면 알맞은 이메일 형식 아니라고 해서 처리함
	String emailStr = "";
	if (dto.getEmail()!=null)
		emailStr = dto.getEmail();

	
	DBConn.close();
	
	// 번호 넘겨받아서 수정 중인데, 누군가가 삭제했다면,
	// dao.getReadData(num) 을 dto가 못 넘겨 받을 것이다.
	// ↓ 그거에 대한 처리
	if (dto == null)
		response.sendRedirect("List.jsp");
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Updated.jsp</title>
<link rel="stylesheet" type="text/css" href="<%=cp%>/css/style.css">
<link rel="stylesheet" type="text/css" href="<%=cp%>/css/created.css">

<script type="text/javascript" src="<%=cp%>/js/util.js"></script>
<script type="text/javascript">
	
	function sendIt()
	{
		f = document.myForm;
		
		// 제목 입력 확인 ----------------------------------------------------------------
		// 필수 입력 항목 기재 여부 확인 및 공백 처리
		str = f.subject.value;
		
		str = str.trim();
		
		// 테스트
		//alert("|" + str + "|");
		
		if(!str)
		{
			alert("\n제목을 입력하세요~!!!");
			f.subject.focus();
			return;
		}
		// ---------------------------------------------------------------- 제목 입력 확인 
		
		
		
		// 이름 입력 확인 ----------------------------------------------------------------
		// 필수 입력 항목 기재 여부 확인 및 공백 처리
		str = f.name.value;
		str = str.trim();
		
		if (!str)
		{
			alert("\n작성자 이름을 입력하세요~!!!");
			f.name.focus();
			return;
		}
		// ---------------------------------------------------------------- 이름 입력 확인 
		

		
		// 이메일은 없는 사람도 있으니, 이메일 입력 확인은 안한다.
		// 그런데, 이메일 입력했을 경우에는, 올바른 형식으로 입력했는지 검사해야 한다.
		// 이메일 검사 -------------------------------------------------------------------
		// 필수 입력 항목이 아니므로 선택적인 입력이 가능하지만
		// 입력을 한 상황이면, 이메일 형식에 맞게 입력했는지
		// 확인하는 처리
		
		if (f.email.value) 
		{
			if(!isValidEmail(f.email.value)) 	
			{
				alert("\n정상적인 이메일 형식을 입력하세요~!!!");
				f.email.focus();
				return;
			}
		}
		// -------------------------------------------------------------------- 이메일 검사
		

		
		// 내용 입력 확인 -----------------------------------------------------------------
		// 필수 입력 항목 기재 여부 확인 및 공백 처리
		str = f.content.value;
		
		str = str.trim();
		
		if (!str)
		{
			alert("\n내용을 입력하세요~!!!");
			f.content.focus();
			return;
		}
		// ----------------------------------------------------------------- 내용 입력 확인 
		
		
		
		// 패스워드 입력 확인 -------------------------------------------------------------
		// 필수 입력 항목 기재 여부 확인 및 공백 처리
		str = f.pwd.value;
		str = str.trim();
		
		if (!str)
		{
			alert("\n패스워드를 입력하세요~!!!");	
			f.pwd.focus();
			return;
		}
		// ------------------------------------------------------------- 패스워드 입력 확인 
	
		
		
		// 패스워드 일치여부 확인 ---------------------------------------------------------
		// 게시물 작성 시 설정한 패스워드와
		// 게시물을 수정하는 과정에서 입력한 패스워드가
		// 서로 일치하는지를 확인하여 액션 처리 수행 여부 판단
		var pwdSource = f.pwdSource.value;
		if (str != pwdSource)
		{
			alert("\n패스워드가 맞지 않습니다.");
			f.pwd.focus();
			return;
		}
		// --------------------------------------------------------- 패스워드 일치여부 확인 
		

		f.action = "<%=cp%>/Updated_ok.jsp";
		
		f.submit();	
	}
	
	function removeIt()
	{
		f = document.myForm;
		
		// 패스워드 입력 확인 -------------------------------------------------------------
		// 필수 입력 항목 기재 여부 확인 및 공백 처리
		str = f.pwd.value;
		str = str.trim();
		
		if (!str)
		{
			alert("\n패스워드를 입력하세요~!!!");	
			f.pwd.focus();
			return;
		}
		// ------------------------------------------------------------- 패스워드 입력 확인 
	
		
		
		// 패스워드 일치여부 확인 ---------------------------------------------------------
		// 게시물 작성 시 설정한 패스워드와
		// 게시물을 삭제하는 과정에서 입력한 패스워드가
		// 서로 일치하는지를 확인하여 액션 처리 수행 여부 판단
		var pwdSource = f.pwdSource.value;
		if (str != pwdSource)
		{
			alert("\n패스워드가 맞지 않습니다.");
			f.pwd.focus();
			return;
		}
		// --------------------------------------------------------- 패스워드 일치여부 확인 
		

		f.action = "<%=cp%>/Delete_ok.jsp";
		
		f.submit();	

	}

</script>

</head>
<body>

<div id="bbs">
	
	<div id="bbs_title">
		게 시 판 (JDBC 연동 버전)
	</div>
	
	<form action="" method="post" name="myForm">
		
		<div id="bbsCreated">
		
			<div class="bbsCreated_bottomLine">
				<dl>
					<dt>제&nbsp;&nbsp;&nbsp;&nbsp;목</dt>
					<dd>
					
						<%
						/* [수정하기] */
						if (status==1)
						{
						%>
							<input type="text" name="subject" size="64" maxlength="100" class="boxTF"
							value="<%=dto.getSubject()%>">
						<%
						}
						/* [삭제하기] */
						else
						{
						%>
							<input type="text" name="subject" size="64" maxlength="100" class="boxTF"
							value="<%=dto.getSubject()%>" disabled="disabled">
						<%
						}
						%>
						
					</dd>
				</dl>			
			</div><!-- close .bbsCreated_bottomLine -->
			
			<div class="bbsCreated_bottomLine">
				<dl>
					<dt>작 성 자</dt>
					<dd>
						
						<%
						/* [수정하기] */
						if (status==1)
						{
						%>
							<input type="text" name="name" size="35" maxlength="20" class="boxTF"
							value="<%=dto.getName()%>">
						<%
						}
						/* [삭제하기] */
						else
						{
						%>
							<input type="text" name="name" size="35" maxlength="20" class="boxTF"
							value="<%=dto.getName()%>" disabled="disabled">
						<%
						}
						%>
					</dd>
				</dl>
			</div><!-- close .bbsCreated_bottomLine -->
			
			<div class="bbsCreated_bottomLine">
				<dl>
					<dt>이 메 일</dt>
					<dd>
					
						<%
						/* [수정하기] */
						if (status==1)
						{
						%>
							<input type="email" name="email" size="35" maxlength="50" class="boxTF"
							value="<%=emailStr %>">
							<%-- value="<%=dto.getEmail()==null?"":dto.getEmail()%>"> --%>
						<%
						}
						/* [삭제하기] */
						else
						{
						%>
							<input type="email" name="email" size="35" maxlength="50" class="boxTF"
							value="<%=emailStr %>" disabled="disabled">
						<%
						}
						%>
					</dd>
				</dl>
			</div><!-- close .bbsCreated_bottomLine -->
			
			
			<div id="bbsCreated_content">
				<dl>
					<dt>내&nbsp;&nbsp;&nbsp;&nbsp;용</dt>
					<dd>
						<!-- ※주의!※ textarea는 value 속성으로 값을 넘겨주는 것이 아니다 -->
						<%-- 
						<textarea rows="12" cols="63" name="content" class="boxTA">
							<%=dto.getContent() %>
						</textarea>
						--%>
						<!-- textarea에 content 위와 같이 넣어주면,
							 안에 "boxTA">와 dto.getContent() 사이에 있는 공백만큼 공백 생긴다음 값 들어간다... -->
						<!-- 아래와 같이 작성하도록 하자 --> 
						<%
						/* [수정하기] */
						if (status==1)
						{
						%>
							<textarea rows="12" cols="63" name="content" 
							class="boxTA"><%=dto.getContent() %></textarea>
						<%
						}
						/* [삭제하기] */
						else
						{
						%>	
							<textarea rows="12" cols="63" name="content" 
							class="boxTA" disabled="disabled"><%=dto.getContent() %></textarea>
						<%
						}
						%>
					</dd>
				</dl>			
			</div><!-- close #bbsCreated_content -->
			
			
			<div class="bbsCreated_noLine">
				<dl>
					<!-- 패스워드는 비워둬야 한다! 그래야 새로 입력할테니까 -->
					<!-- 패스워드는 [수정/삭제] 분기할 필요 없이 모두 입력해야하는 것 -->
					<dt>패스워드</dt>
					<dd>
						<!-- 패스워드 갖고 있으려고! 
							 수정하기 버튼 누르면 비밀번호 확인해서 다르면 수정 불가하게 처리 -->
						<input type="hidden" name="pwdSource" value="<%=dto.getPwd()%>">
						<input type="password" name="pwd" size="35" maxlength="10" class="boxTF">
						&nbsp;<span style="font-size: 6pt; color: red;">(게시물 수정 및 삭제 시 필요)</span>
					</dd>
				</dl>
			</div><!-- close .bbsCreated_noLine -->
			
			
			<div id="bbsCreated_footer">
				
				<!-- 대표적으로 수정dao 에서 필요한데 Updated.jsp 에서 넘겨주고 있지 않은거
					 → num 값 
					 Updated_ok.jsp 에서 수정완료하고 sendRedirect() 할 때,
					 원래 있던 리스트로 돌려보내기로 업데이트 정책 정했다면!! 
					 Article.jsp로 보내든지, List.jsp 로 보내든, pageNum 갖고 있어야 한다.
					 → 수정완료하고 완료된 게시물 상세내용페이지에 남아있게 하는 경우도 있고,
					    처음리스트로 돌아가게 하는 경우도, 원래있던 리스트로 돌아가게 하는 경우도 있으니
					    완~~~~전 많이 생각하고 관찰해야 한다.
					    이게 코드레벨보다 더 중요함!!! -->
				<!-- Updated_ok.jsp 페이지 요청 과정에서 추가로 필요한 데이터 -->
				<input type="hidden" name="num" value="<%=dto.getNum()%>">
				<input type="hidden" name="pageNum" value="<%=pageNum%>">
				
				<!-- 수정/삭제하기 버튼으로 고치고,
					 삭제할 때는 → [다시입력] 버튼 필요 없고, [삭제하기] [삭제취소] 만 있으면 된다. -->
				<%
				/* [수정하기] */
				if (status==1)
				{
				%>
					<input type="button" value="수정하기" class="btn2" onclick="sendIt()">
					<input type="reset" value="다시입력" class="btn2"
					onclick="document.myForm.subject.focus();">
					<!-- 중간 어디쯤에 와서 수정하기 누른거니까 다시 리스트로 돌아갔을 때,
						 해당 페이지로 돌아가게 하기 위해서, pageNum 건네준다. -->
					<input type="button" value="작성취소" class="btn2"
					onclick="javascript:location.href='<%=cp%>/List.jsp?pageNum=<%=pageNum%>'">
				<%
				}
				/* [삭제하기] */
				else
				{
				%>
					<input type="button" value="삭제하기" class="btn2" onclick="removeIt()">
					<input type="button" value="삭제취소" class="btn2"
					onclick="javascript:location.href='<%=cp%>/List.jsp?pageNum=<%=pageNum%>'">
				<%
				}
				%>
			</div><!-- close #bbsCreated_footer -->
					
		</div><!-- close #bbsCreated -->
		
	</form>

</div><!-- close #bbs -->

</body>
</html>











