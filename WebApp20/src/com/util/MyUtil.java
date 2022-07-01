/*==============================================
 	MyUtil.java
 	- 게시판 페이징 처리 (산수들이 조금 쓰임)
 						  수학까지는 아니고,,!
================================================*/

// check~!!!
// 지금 같이 확인해보고자 하는 페이징 처리 기법은
// 다양한 방법들 중 한 가지(그나마 쉬운 것을 골라...) 이다.
// 학습을 마친 이후에... 꼭~!!! 추가적으로 개념을 정리하고
// 확장시키고, 다른 방법들도 찾아보고 공부해야 한다~!!!
// 게시판 종류에 따라 페이징처리 기법도 상당히 다양하다.
// ex) 스크롤 내리고 다 내리면 스크롤 아래에 더 생기고 이런것도 있고!
// 게시판 만드는데 페이징기법 모르면 게시판 헛만드는 것

package com.util;

public class MyUtil
{
	// ■ 전체 페이지 수를 구하는 메소드 
	//-- 전체 몇 페이지인지를 결과값으로 반환하게 함 → int
	//-- 첫번째 매개변수(numPerPage) : 한 페이지에 표시할 데이터(게시물)의 수
	//   두번째 매개변수(dataCount)  : 전체 데이터(게시물) 수
	public int getPageCount(int numPerPage, int dataCount)
	{
		int pageCount = 0;
		
		pageCount = dataCount / numPerPage;
		
		if (dataCount % numPerPage != 0)
			pageCount++;
		
		return pageCount;
	}
	//-- 한 페이지에 10개의 게시물을 출력할 때
	//   총 32개의 게시물을 페이지로 구성하기 위해서는
	//   『32 / 10』의 연산을 수행하여 결과 3을 얻을 수 있다.
	//   → 『pageCount = dataCount / numPerPage;』
	//   그런데 이 때, 나머지 2개의 게시물을 출력해 주기 위해서는
	//   페이지 하나가 더 필요하다.
	//   → 『pageCount++;』
	
	
	// ■ 페이징 처리 기능의 메소드
	// currentPage : 현재 표시할 페이지
	// totalPage   : 전체 페이지 수
	// listUrl     : 링크를 설정할 url
	//      			   1  2  3  4  5 <a href="">Next</a>
	// <a href="">Prev</a> <a>6</a>  <a>7</a>  <a>8</a>  <a>9</a>  <a>10</a> <a href="">Next</a>
	// <a href="">Prev</a> 11 12 13 14 15 <a href="">Next</a>
	// --> 각각 숫자들에도 다 <a> 태그 걸려있을거임 → 숫자 클릭하면 페이지 이동해야하니까!
	// --> 이런거 만들려고 하는 거!!
	public String pageIndexList(int currentPage, int totalPage, String listUrl)
	{
		// 실제 페이징을 저장할 StringBuffer 변수
		StringBuffer strList = new StringBuffer();
		// <a href="">Prev</a> <a>6</a>  <a>7</a>  <a>8</a>  <a>9</a>  <a>10</a> <a href="">Next</a>
		//-- 이게 하나의 set로 strList로 구성!
		
		// 게시물 리스트 하단에 띄울 숫자 개수
		int numPerBlock = 10;
		//-- 페이징 처리 시 게시물 리스트 하단의 숫자를 10개씩 보여주겠다.
		//   21~30, 31~40  10개씩 보여주겠다.
		
		int currentPageSetup;
		//-- 현재 페이지(이 페이지를 기준으로 보여주는 숫자가 달라져야 하기 때문...)
		// 페이지를 몇 페이지부터 랜더링 시켜줄건지. 이거부터 +1 돼서 리스트 띄어진다.
		//   0 이면 →  1 ~ 10page 목록 띄움
		//  10 이면 → 11 ~ 20page 목록 띄움
		
		int page;	//-- 각 페이지 바로가기에서 사용할 변수
		int n;		//-- Prev, Next 처리에서 사용할 변수
		//-- 이전 페이지 블럭과 같은 처리에서 이동하기 위한 변수
		//   (얼마만큼 이동해야 하는지...)
		
		
		// 페이징 처리가 별도로 필요하지 않은 경우
		//-- 데이터가 존재하지 않거나 
		//   데이터의 수가 1페이지도 못 채우는 경우는
		//   별도로 페이징 처리를 할 필요가 없다.
		if (currentPage == 0)
			return "";		//-- 아무것도 보여주지 않고 끝낸다.
		
		
		// ※ 페이지 요청을 처리하는 과정에서
		//    URL 경로의 패턴에 대한 처리
		/*
		      - 클라이언트 요청의 형태 → List.jsp → (가공) List.jsp?
		        → 가공과정 거쳐서 『?』 붙여주려고 한다.
		        
		      - 클라이언트 요청의 형태 → List.jsp?subject=study → (가공) List.jsp?subject=study&		 
		      	→ 가공과정 거쳐서 『&』 붙여주려고 한다.
		
			→ 그래야 둘 다 그 뒤에 『pageNum=1』 붙을 수 있다.	
		*/
		
		// 링크를 설정할 URL 에 대한 선가공 처리~!!!
		// 『?』들어있는지 확인해서 -1 이 아니면 → url에 ?이 포함되어 있다면,
		if (listUrl.indexOf("?") != -1)		//-- 링크를 설정할 URL 에 『?』가 들어있으면...
			listUrl = listUrl + "&";		//   listUrl += "&";
		else								//-- 링크를 설정할 URL 에 『?』가 없으면...
			listUrl = listUrl + "?";		//   listUrl += "?";
		//-- 예를 들어, 검색값이 존재하면
		//   이미 request 값에 searchKey 값과 searchValue 값이 들어있는 상황이므로
		//   『&』를 붙여서 속성값을 추가해줘야 한다.
		
		
		// currentPageSetup = 표시할 첫 페이지 - 1
		currentPageSetup = (currentPage / numPerBlock) * numPerBlock;
		//-- 만약 현재 페이지가 5페이지이고(currentPage=5)
		//   리스트 하단에 보여줄 페이지 개수가 10이면(numPerBlock=10)
		//   『5 / 10 = 0』 이며... 여기에 『* 10』 (10을 곱해도) 0 이다.
		//   하지만, 현재 페이지가 11페이지라면(currentPage=11)
		//   『11 / 10 = 1』 이며... 여기에 『* 10』 (10을 곱하면) 10 이다.
		//   그러면... currentPageSetup 은 10이 되는 것이다.
		//-- 0이면 1~10 page 목록 띄우고, 10이면 11~20 page 목록 띄우는거
		//   내가 21, 23, 29페이지. 즉 21~30 page 중 어느 곳에 있다면 currentPageSetup 은 20으로 만드는 것
		//   그래야 21~30 페이지 목록 띄어주니까!!!
		//    1~10 사이에 있으면 → 0	→ 1|2|3|4|5|6|7|8|9|10   		 페이지 목록 띄움
		//   11~20 사이에 있으면 → 10  → 11|12|13|14|15|16|17|18|19|20 페이지 목록 띄움
		//			:
		
		// 그런데 현재 20page라면 20/10 * 10  = 20이 나와버린다...
		// 10의 배수일 경우 문제가 생긴다!!
		// 아래와 같이 처리 → 10의 배수라면, 10 빼준다.
		if (currentPage % numPerBlock == 0)
			currentPageSetup = currentPageSetup - numPerBlock;
		//-- 만약 위 처리에서...(Line 108)
		//   현재 페이지가 20 페이지였다면, (currentPage=20)
		//   『20 / 10 = 2』 이며.. 여기에 『* 10』 (10을 곱해서) 20이 되는데
		//   이와 같은 상황이라면... 다시 10을 빼서 10으로 만들어주기 위한 구문
		
		
		
		// 1 ~ 10 page가 아닐 때, 11 페이지부터는 목록 list 맨 앞에 1 페이지로 가게끔 링크 추가하려고 함
		// 마지막 페이지가 아닐 때에는 목록 list 맨 뒤에 맨 뒷페이지로 가게끔 링크 추가하려고 함
		// 맨처음으로  Prev   21 | 22 | 23 | 24 | 25 | 26 | 27 | 28 | 29 | 30   Next   맨뒤로
		// → 리스트 맨 앞일 때는 Prev 안 뜨고,
		//    리스트 맨 뒤일 때는 Next 안 뜬다!
		
// 1 페이지로 이동 (맨 처음으로)	
		//-- currentPageSetup이 0일 때는 이미 목록에 1페이지가 나와있기 때문에
		//   1페이지로 이동하는 거 만들지 않아도 된다.
		if ( (totalPage > numPerBlock) && (currentPageSetup > 0) )
			strList.append(" <a href='" + listUrl + "pageNum=1'>1</a>");
		//-- listUrl 은 위에서 (Line 98) 이미 전처리가 끝난 상황이기 때문에
		//   『...?』 상태 또는 『...?...&』 인 상태이다.
		//   이로 인해 결과는
		//   『...?pageNum=1』 이거나 『...&pageNum=1』 가 되는 상황이다.
		
		
// Prev (numPerBlock 만큼 앞으로) (이전으로)
		n = currentPage - numPerBlock;
		//-- n : 해당 페이지만큼 앞으로 가기 위한 변수
		//   ex) 33페이지에서 Prev 누르면 22 페이지로, 22 페이지에서 Prev 누르면 12 페이지로, 또 누르면 2 페이지로 가는거
		
		if ( (totalPage > numPerBlock) && (currentPageSetup > 0) )
			strList.append(" <a href='" + listUrl + "pageNum=" + n + "'>Prev</a>");
		//-- currentPageSetup 이 0 보다 큰 경우는
		//   이미 페이지가 11 이상이라는 의미이며
		//   이 때, 현재 페이지(currentPage)가 11 이상일 경우
		//   『Prev』를 붙이기 위한 구문이다.
		//-- 『Prev』를 클릭할 경우
		//   n 변수 페이지로 이동하는데
		//   12 에서 『Prev』 할 경우 2 페이지가 되고,
		//   22 에서 『Prev』 할 경우 12 페이지가 된다.
		
		
// 각 페이지 바로가기 (페이지 링크 클릭시, 해당 페이지로 바로 이동)
		// 0 이면 1~10 찍고, 10이면 11~20 찍음
		page = currentPageSetup + 1;		
		//-- 『+1』을 수행하는 이유는
		//   앞에서 currentPageSetup 에서 10을 가져왔다면 (11 ~ 20 page 리스트 띄어야 함)
		//   10부터 시작하는 것이 아니라
		//   바로가기 페이지는 11부터 시작해야 하기 때문이다.
		//   → Prev 11 12 13 14 15 16 17 18 19 20 Next     
		
		
		// <a> 태그 작성할 때 일부러 ' ' 공백 하나씩 넣고 있음
		// 공백 쫌 넓게 넣으려면 &nbsp; 넣어야 하는데 그러면 코드 너무 정신없어지니까ㅠㅠ!!
		// 그래서 숫자끼리 공백 엄청 작을거임..!
		
		// if) page가 11이라면 
		//     반복문 안에서 page=11 ~ 20까지 반복문 돌게 된다.
		
		//							초기값:11	      10		+    10 = 20   →  11~20까지 반복수행
		//								----	------------------------------
		while ( (page <= totalPage) && (page <= currentPageSetup + numPerBlock) )
		{
			// 내가 현재 13페이지라면, 13페이지는 링크가 걸려있으면 안되니까 <span> 태그로
			if (page == currentPage)
				strList.append(" <span style='color:orange; font-weight: bold;'>" + page + "</span>");
			// 나머지 페이지는 다 링크면 된다.
			else 
				strList.append(" <a href='" + listUrl + "pageNum=" + page + "'>" + page + "</a>");
			
			page++;
		}
		// 위에 코드는 아래와 같은 의미이다.
		// 내가 현재 13페이지라면,
		// <a href='...'>11</a> <a href='...'>12</a> <span 오렌지 굵게>13</span> <a href='...'>14</a> <a href='...'>15</a> <a href='...'>16</a> <a href='...'>17</a> <a href='...'>18</a> <a href='...'>19</a> <a href='...'>20</a>
		
		
// Next (numPerBlock 만큼 뒤로) (다음으로)
		n = currentPage + numPerBlock;
		if ( (totalPage - currentPageSetup) > numPerBlock )
			strList.append(" <a href='" + listUrl + "pageNum=" + n + "'>Next</a>");
		
		
// 마지막 페이지로 이동 (맨 마지막으로)
		if ( (totalPage > numPerBlock) && (currentPageSetup + numPerBlock) < totalPage )
			// 마지막페이지만큼은 시각적으로 몇 페이지인지 보여주려고, <a> 태그 사이에 totalPage 변수 직접 넣어주었다.
			strList.append(" <a href='" + listUrl + "pageNum=" + totalPage + "'>" + totalPage + "</a>");
		
		return strList.toString();
	}
}
