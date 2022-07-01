package com.util;

public class MyUtil
{
	// ■ 전체 페이지 수를 구하는 메소드
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
	
	// ■ 페이징 처리 기능의 메소드
	//-- currentPage : 현재 표시할 페이지
	//   totalPage   : 전체 페이지 수
	//   listUrl     : 링크를 설정할 url
	public String pageIndexList(int currentPage, int totalPage, String listUrl)
	{
		// 실제 페이징을 저장할 StringBuffer 변수
		StringBuffer strList = new StringBuffer();
		
		// 게시물 리스트 하단에 띄울 숫자 개수
		int numPerBlock = 10;
		
		// 현재 페이지
		// → 이걸 기준으로 하단에 보여주는 리스트가 달라진다.
		//    0  :  1 ~ 10 page 리스트 띄움
		//    10 : 11 ~ 20 page 리스트 띄움
		int currentPageSetup;
		
		int page;	//-- 각 페이지 바로가기에서 사용할 변수
		int n;		//-- Prev, Next 처리에서 사용할 변수
		
		// 페이징 처리가 별도로 필요하지 않은 경우
		// (데이터 존재하지 않거나, 데이터의 수가 1페이지 안 넘는 경우)
		if (currentPage == 0)
			return "";
		
		// 링크 설정할 URL 에 대한 선가공 처리
		if (listUrl.indexOf("?") != -1)
			listUrl += "&";
		else
			listUrl += "?";
		
		// currentPageSetup = 표시할 첫 페이지 - 1
		currentPageSetup = (currentPage / numPerBlock) * numPerBlock;
		
		// 10의 배수(numPerBlock의 배수)일 경우 문제 생기니까 처리
		if (currentPage % numPerBlock == 0)
			currentPageSetup = currentPageSetup - numPerBlock;
		
		// 1 페이지로 이동 (맨 처음으로)
		if ((totalPage > numPerBlock) && (currentPageSetup > 0))
			strList.append(" <a href='" + listUrl + "pageNum=1'>1</a>");
		
		// Prev (numPerBlock 만큼 앞으로)
		n = currentPage - numPerBlock;
		if ((totalPage > numPerBlock) && (currentPageSetup > 0))
			strList.append(" <a href='" + listUrl + "pageNum=" + n + "'>Prev</a>");
		
		// 각 페이지 바로가기
		page = currentPageSetup + 1;
		
		while ((page <= totalPage) && (page <= currentPageSetup + numPerBlock))
		{
			if (page == currentPage)
				strList.append(" <span style='color: orange; font-weight: bold;'>" + page + "</span>");
			else
				strList.append(" <a href='" + listUrl + "pageNum=" + page + "'>" + page + "</a>");
			
			page++;
		}
		
		// Next (numPerBlock 만큼 뒤로)
		n = currentPage + numPerBlock;
		if ((totalPage - currentPageSetup) > numPerBlock)
			strList.append(" <a href='" + listUrl + "pageNum=" + n + "'>Next</a>");
		
		// 마지막 페이지로 이동 (맨 마지막으로)
		if ((totalPage > numPerBlock) && (currentPageSetup + numPerBlock) < totalPage)
			strList.append(" <a href='" + listUrl + "pageNum=" + totalPage + "'>" + totalPage + "</a>");
		
		return strList.toString();
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
