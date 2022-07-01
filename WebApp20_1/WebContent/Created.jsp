<%@ page contentType="text/html; charset=UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Created.jsp</title>
<link rel="stylesheet" type="text/css" href="<%=cp%>/css/style.css">
<link rel="stylesheet" type="text/css" href="<%=cp%>/css/created.css">

<script type="text/javascript" src="<%=cp%>/js/util.js"></script>
<script type="text/javascript">
	
	
	// 지금 이 구조에서는
	// 사용자에게 보여지는 곳에서는 공백이 제거되지만,
	// DB 안에는 공백 제거되지 않은채로 들어간다!
	// trim() 한 str을 value 값에 실제로 넣어주지는 않은거라서~!
	
	function sendIt()
	{
		f = document.myForm;
		
		// 제목 입력 확인 ----------------------------------------------------------------
		// 필수 입력 항목 기재 여부 확인 및 공백 처리
		str = f.subject.value;
		
		// 자바스크립트에는 trim() 존재하지 않는다. → trim() 추가되었다고 함
		// 선생님이 util.js 에 만들어놔서 여기서 쓸 수 있는 거!
		str = str.trim();
		
		// ※ javascript 에는 trim() 이 존재하지 않는다.
		//    외부에서 참조한 util.js 에 만들어뒀다.
		//    → trim() 추가 되었다고 한다.
		
		// 제목에 『안녕하세요』와 『  안녕하세요』는 다른 문자열이지만,
		// 다른 제목은 다 왼쪽 정렬되어 있는데 걔만 정렬안되어있으면 이상하니까
		// 공백제거 기능 넣었다.
		
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
		
		// 먼저 조건문으로
		// 입력을 한 상황인지 체크해봐야 한다.
		if (f.email.value) 	// 이메일을 입력한 상황이라면...
		{
			if(!isValidEmail(f.email.value)) 	// email value 값 확인해서 유효하지 않으면,
			{
				alert("\n정상적인 이메일 형식을 입력하세요~!!!");
				f.email.focus();
				return;
			}
		}
		// -------------------------------------------------------------------- 이메일 검사
		

		
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
		
		
		
		// 내용 입력 확인 -----------------------------------------------------------------
		// 필수 입력 항목 기재 여부 확인 및 공백 처리
		// 테이블 만들 때, content 도 not null 로 만들어놨음!
		str = f.content.value;
		
		// 사이사이 공백이 아니라, 앞/뒤 공백처리니까, content에도 trim() 적용해도 상관없다.
		str = str.trim();
		
		if (!str)
		{
			alert("\n내용을 입력하세요~!!!");
			f.content.focus();
			return;
		}
		// ----------------------------------------------------------------- 내용 입력 확인 
		
		// form 에 action 속성 기재하지 않았기 때문에 여기서 설정해준다.
		f.action = "<%=cp%>/Created_ok.jsp";
		
		f.submit();	
	}

</script>

</head>
<body>

<!-- 
		글올리기 버튼 눌렀을 때, 건네줘야할 거 없다.
		그런데 글올리기 들어갔다가 [작성취소] 버튼 눌렀을 때
		List로 그냥 돌아가는거 아니고 원래 있던
		list page로 돌아가려면 있기는 함! 
		그런데 지금은 그냥 [작성취소]누르면 1 page로 돌아갈거임!!
 -->
 
 
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
						<input type="text" name="subject" size="64" maxlength="100" class="boxTF">
					</dd>
				</dl>			
			</div><!-- close .bbsCreated_bottomLine -->
			
			<div class="bbsCreated_bottomLine">
				<dl>
					<dt>작 성 자</dt>
					<dd>
						<input type="text" name="name" size="35" maxlength="20" class="boxTF">
					</dd>
				</dl>
			</div><!-- close .bbsCreated_bottomLine -->
			
			<div class="bbsCreated_bottomLine">
				<dl>
					<dt>이 메 일</dt>
					<dd>
						<input type="email" name="email" size="35" maxlength="50" class="boxTF">
					</dd>
				</dl>
			</div><!-- close .bbsCreated_bottomLine -->
			
			
			<div id="bbsCreated_content">
				<dl>
					<dt>내&nbsp;&nbsp;&nbsp;&nbsp;용</dt>
					<dd>
						<textarea rows="12" cols="63" name="content"  class="boxTA"></textarea>
					</dd>
				</dl>			
			</div><!-- close #bbsCreated_content -->
			
			
			<div class="bbsCreated_noLine">
				<dl>
					<dt>패스워드</dt>
					<dd>
						<input type="password" name="pwd" size="35" maxlength="10" class="boxTF">
						&nbsp;<span style="font-size: 6pt;">(게시물 수정 및 삭제 시 필요)</span>
					</dd>
				</dl>
			</div><!-- close .bbsCreated_noLine -->
			
			
			<div id="bbsCreated_footer">
				<input type="button" value="등록하기" class="btn2" onclick="sendIt()">
				<!-- reset 버튼 눌렀을 때 onclick에 저거 설정해주면 좋다. 
					 reset 했을 때 제목에 focus가게 해주면 사용자 조금 더 편하다.-->
				<input type="reset" value="다시입력" class="btn2"
				onclick="document.myForm.subject.focus();">
				<input type="button" value="작성취소" class="btn2"
				onclick="javascript:location.href='<%=cp%>/List.jsp'">
			</div><!-- close #bbsCreated_footer -->
			
			
		</div><!-- close #bbsCreated -->
		
	</form>

</div><!-- close #bbs -->

</body>
</html>











