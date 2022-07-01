<%@ page contentType="text/html; charset=UTF-8"%>
<%
	// Forward11_1.jsp
		
	String num1Str = request.getParameter("num1");
	String num2Str = request.getParameter("num2");
	String calResult = request.getParameter("calResult");
	
	int num1 = 0;
	int num2 = 0;
	String result = "";
	
	try
	{
		num1 = Integer.parseInt(num1Str);
		num2 = Integer.parseInt(num2Str);
		
		if (calResult.equals("1"))			// 더하기
			result = String.format("%d + %d = %d", num1, num2, (num1+num2));
		else if (calResult.equals("2"))		// 빼기
			result = String.format("%d - %d = %d", num1, num2, (num1-num2));
		else if (calResult.equals("3"))		// 곱하기
			result = String.format("%d * %d = %d", num1, num2, (num1*num2));
		else if (calResult.equals("4"))		// 나누기
			result = String.format("%d / %d = %.1f", num1, num2, (num1/(double)num2));
		
	}
	catch(Exception e)
	{
		System.out.println(e.toString());
	}
	
	request.setAttribute("resultStr", result);
	
/*	
	이 파일에서는 forward 액션태그 쓰지 않는다.
	<jsp:forward page="Receive11.jsp"></jsp:forward> 
 
	이거 지우고 밑에 Line 42,43 추가
	document 와 관련된 내용 하나도 없으니까 html 부분 다 지워버림!! 
*/
	RequestDispatcher dispatcher = request.getRequestDispatcher("Receive11.jsp");
	dispatcher.forward(request, response);
%>
<!-- 
	// check~!!!
	RequestDispatcher dispatcher = request.getRequestDispatcher("Receive11.jsp");
	//-- RequestDispatcher 는 javax.servlet 에 있는 interface 이다.
	//-- request 요청 객체에 requestDispatcher를 얻어낼 수 있는 
	//   getRequestDispatcher() 메소드 사용해서 얻어내고 있다.
	//   request로 부터 'Receive11.jsp'넘기면서 requestDispatcher 얻어왔다. 	
	dispatcher.forward(request, response);
	//-- 그렇게 얻어낸 dispatcher 로 forward 처리하면서
	//   원래 있던 request와 response 넘겨주고 있다.
	//-- 이렇게 두 줄 쓰면, jsp에서 action 처리하는 거처럼 해주니까 쓴다.
	//   아니라, 이유를 제대로 잘 알고 써야 한다!!
	//   ↓
	//   ↓ 어려운 내용이니까 잘 기억해두기 (실무 경력자들도 어려워하는 내용)
	//   ↓
	/*=============================================================================
	■■■ 『RequestDispatcher』 인터페이스 ■■■	
			-------------------
			javax.servlet 에 있는 interface
	
	※ 이 인터페이스는 『forward()』 와 『include()』 만 있다.
	
	※ 처리 과정 및 개념
	   
	일반적으로 HttpServlet 을 상속받는 클래스로 서블릿을 만든다.
		
		+) 과거에 우리는..
		   GenericServlet 상속받아서 service() 메소드 오버라이딩해서 설계했었다.
		   웹 기반 어플리케이션 만들 때는 HttpServlet 상속받아서 만든다.
	
	이렇게 작성된 클래스 내부에는
	실체 요청을 서비스하는 『doGet()』 과 『doPost()』 메소드가
	정의되어 있으며(service() 메소드가 이들의 상위 메소드)
	
		+) 상위 메소드 : service()
		   하위 메소드 : doGet(), doPost()
					     get 방식이면 doGet() 메소드 호출
					     post 방식이면 doPost() 메소드 호출
		   → 우리가 호출하는 거 아님!!
		      Servlet이 호출해주는 것이다.
	 
	ServletContainer 는 『HttpServlet』 의 인스턴스를 생성하고,
	『init()』 메소드를 실행해주고,
	이 메소드에 의해 매핑된 URL 에
	(페이지 요청 방식에 따라) doGet() 과 doPost() 중 선택하여
	메소드를 호출해 주고(실행시켜 주고)
	Container 가 종료될 때 『destroy()』 메소드를 호출해주고,
	관련된 처리 과정이 마무리된다.
	→ 이거 다 ServletContainer 가 해주는 거다.
	
	즉, ServletContainer 가
	init()		→ 처음 
	service()	→ 중간중간 요청이 있을 때마다 (상황에 맞게 doGet(), doPost() 호출)
	destory()	→ 마지막
	메소드를 호출한다.
	(절대 우리가 직접 호출하는 것이 아니다~!!!)
	
	
	결국 『HttpServlet』은
	하나의 인스턴스만 생성되어 멀티 스레딩으로 돌아가게 된다.
	
		++) 서블릿 하나 생성되고, 파괴되고, 사이사이 요청이 있을 때 
			init(), service(), destroy() 각각 다 하나의 객체 안에 있는 메소드이다.
			서로 독립되어 있어서 따로따로 돌아가는 메소드가 아니다.
	
			사람이 깨다(), 점심먹다(), 저녁먹다(), 자다() 이 행동이 객체 하나 안에서 일어나는 일!
			서로 다른 객체에서 서로 다르게 돌아가면 사람이 제대로 살아갈 수 없다.
		
			→ 그러므로 인스턴스는 하나만 생성되어서 멀티 스레드로 돌아간다는 것이다!!
			   그래서 ServletContext 가 멀티스레드 수행하느라 자리 비울 수 없음
		
		++) 『스레드』 
			→ 동시다발적인 업무 요구에 대해서 동시다발적으로 수행할 수 없기 때문에, 
           	   하나씩 멈추는 것
           	   
           	멀티 태스킹(태스크) : 한 번에 여러 일 처리하는 거
           				------
           				업무 단위
           				
           	멀티 스레딩(스레드)
           				-------
           				업무 단위 수행하기 위한 최소 단위
           				
           	사실 컴퓨터는 멀티태스킹 못한다.
           	그런데 음악 잠깐 틀고, 영상 잠깐 재생하고, 문서편집 잠깐하고 하는 걸
           	엄~~~~~청 빠르게 수행해서 
           	사람이 느끼기에는 동시에 일어나는 것처럼 느껴지는 것이다!!
           	
           	컴퓨터는 멀티태스킹 불가능하니까 사실상 멀티스레드도 존재하지 않는다.
           	음악 틀고 있으니까, 영상 잠깐 멈춰
           	영상 재생 하고 있으니까, 문서편집 잠깐 멈춰
           	이런 작업들을 수행해야 한다.
           	이런 걸 복합적으로 수행할 때 → 『멀티스레딩』 이라고 한다.
           	잠깐잠깐 지연되고, 실행되고, 대기걸렸다가 다시 지연됐다가 실행하러 들어왔다가
           	
           	컴퓨터는 밥먹으면서, 화장실가면서, 음악들으면서, 잠자는 4가지 일 한 번에/동시에 못한다.
           	그래서 이걸 짤막짤막하게 끊어서 겁~~나 빠르게 할 수 밖에 없다.
           	그걸 큰 의미로 확장하면 『멀티태스킹』
           	작은 단위로 줄여서 확대해서 보면 『멀티스레드』 이다.
           	
           	멀티스레드 언세이프티 → 동시 다발적으로 확 걸려버리면 문제생길 수 있다.
           	멀티스레드 세이프티   → 동시 다발적으로 확 걸려도 안전성 보장
           	
           		 printer
           		A		C		
           	
           		B		D
           		
           	    사무실에서 A B C D 사원이 동시에 print 버튼 누름!
           
           		- 그 때, 프린터기 뻗어버리면 → 『멀티스레드 언세이프티』       	
           		- 4명 동시에 프린터 명령 실행했는데, 
           	  	  그 안에서 조금이라도 먼저 요청 들어온거 처리하고,
           	 	  나머지 줄 세워서 대기열에 쌓아 놓는 것 → 『멀티스레드 세이프티 』
          
           	 	  
		   WebApp04 > src 에서
		   Test004 는 GenericServlet 상속된 클래스
	  ┌→ Test005 는 HttpServlet 상속된 클래스
      │     	 	  
	이렇게 구성되는 『HttpServlet』의 상속된 클래스의 인스턴스는
					--------------------------------
					   → 우리가 만든 Servlet (위에서 설명써놓은 Test004, Test005)	
					   
	스레드에 안전하게 설계(스레드 세이프티)되어야 하고
	따라서 스레드에 안전하게 설계하지 않는 경우
	상위 클래스를 마구 접근하게 되어 에러가 발생할 수 밖에 없다.
	→ 멀티스레드 언세이프티 되면, 동시다발적 명령 들어오면 뻗어버릴 수 있다.
	
	이와 같은 이유로 환경 설정이나 J2EE 서비스에 관한 내용은
	『ServletContext』 에서 할 수 있게 된다.
			(J2EE 보이면 엔터프라이즈 개념의 서비스라고 이해하면 된다.)

			+) 컴퓨터보면 모두들 환경설정에 들어가야 
               환경설정에 관련된 거 다 모아져 있다.
               서블릿도 서블릿/서블릿컨테이너가 
               어떤 상태인지, 몇 평인지, 온도는 어떤지 등에 대한 정보에
               접근,설정하는 거 한 군데에 모아 놓은 것 → ServletContext
	(※ ServletContext
			: 서블릿에 대한 환경, 상태 등을 설정할 수 있는 객체)
	이 『ServletContext』는 『getServletContext()』로만 받을 수 있다.
							 --------------------
							  → 예전에 서버 오류 로그 남길 때 한 번 만났었음 
 		   					     getServletContext().log("오류 : " + e.toString());
	그렇기 때문에 이 『getServletContext()』는
	동기화가 제대로 구현되어 있을 것이라고 예측할 수 있다.
	그 이유는 멀티 스레드에 안전하게 설계(세이프티)되어 있어야
	우리가 『ServletContext』의 『setAttribute()』나 『getAttribute()』를
							    -----------------     ----------------
							     환경설정값 세팅	  환경설정값 얻어오기
	스레드 걱정 없이 마음대로 읽고 쓸 수 있기 때문이다.
	
		+) setAttribute(), getAttribute() 는 request 객체 대해서 호출하면 된다.
		   그런데 request 가 서로 다른 객체에 있다면,,,
		   A의 주머니에 1000원 넣어줬는데 B의 주머니에서 1000원 나오는 상황 ㅎㅎ
		   → 따라서 request 객체는 하나여야 한다.
		   
		   멀티스레딩 세이프티
		    └→ A 주머니에 너도나도 동시에 1000원 넣어주려고 하면 주머니 찢어질 것이다.
		   		 줄을 서시오~ 해야 할 것이다. 꺼낼 때도 줄세워서 한 명씩 꺼내야 한다.
		   		 → 그래서 여러 사용자들이 여러 PC 에서 동시에 꺼낼 수 있는것
		   		 	멀티스레딩 세이프하고 만들어지지 않았다면, 이거 불가능하다!!
	
		   		 	
	『ServletContext』의 또 다른 커다란 기능 중 하나는
	다른 서블릿 인스턴스를 가져올 수 있다거나
	서블릿 환경 설정값을 가져올 수 있는 기능이다.
	
	『RequestDispatcher』 역시 그 기능 중의 하나이다.
	사전적인 의미로는... 요청을 제공하는 도구
	즉, 요청을 보내주는 인터페이스이다.
	
		+) RequestDispatcher
   		   → ServletContext가 사용하는 하인/심부름꾼/도구 정도로 생각하면 된다.
   			  ServletContext 은 항상 그 자리에 있어야 한다.
   			  ServletContext 가 있어야할 자리에 있지 않으면, 
   			  환경설정하고 값 가져오고 하는 거 못한다.
   			  ServletContext 찾아다녀야 하니까..!
   			  본인은 본인 자리 지켜야하니까,
   			  그 일 수행할 수 있는 RequestDispatcher 하나 만들어 둔 것이다.
	
	현재... 요청을 다른 서블릿(혹은 JSP)으로 보내야 하는 상황.
	그런데, 위에 언급한 바와 같이 서블릿의 인스턴스는 하나만 생성되고
	이것이 멀티 스레딩으로 돌아가고 있다.
	
	그렇기 때문에 새로운 서블릿을 
	그 서블릿을 실행하는 것만으로는 안되고
	이미 돌아가고 있는 서블릿 인스턴스의 스레드를
	하나 더 추가해야 한다.
	이것은 서블릿 개발자가 처리해야 할 영역을 벗어났기 때문에
	이 일은 『Dispatcher』가 대신 수행해 준다는 것이다.
		│
		└→ 그런데 ServletContext는 자리 못 비우니까, RequestDispatcher 한테 부탁하는거
			 그런데 RequestDispatcher는 서블릿 인스턴스의 스레드 생성 능력은 없다.
			 일개 ServletContext의 하인이니까..!
			 그래서 기존에 있던 request, response 객체를 받아서 처리한다.
			 → !! 그래서 forwarding 처리할 때 우리가 request, response 객체 넘겨주는 것이다 !!
	
	하지만, 이 『Dispatcher』는
	『HttpServletRequest』, 『HttpServletResponse』를
	생성해 줄 수는 없다.
	그렇기 때문에 『Dispatcher』가 생성해준 새로운 서블릿 스레드를
	실행시키기 위해 『doGet()』이나 『doPost()』를 호출해야 한다.
	
	이와 같은 이유로
	『dispatcher.forward(request, response);』 구문을 통해
	request 와 response 를 넘겨주는 것이다.
		
	===============================================================================*/
 -->





















