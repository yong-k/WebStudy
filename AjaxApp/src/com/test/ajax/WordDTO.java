/*=================
	WordDTO.java
==================*/

package com.test.ajax;

public class WordDTO
{
	// 주요 속성 구성
	private String word;
	
	// 기본 생성자 추가
	public WordDTO()
	{
		this("");
	}
	
	// 사용자 정의 생성자
	public WordDTO(String word)
	{
		this.word = word;
	}
	
	// getter / setter 구성
	public String getWord()
	{
		return word;
	}

	public void setWord(String word)
	{
		this.word = word;
	}
}
