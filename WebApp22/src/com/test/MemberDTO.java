package com.test;

public class MemberDTO
{
	private String name, tel, addr;
	
	// ★★★→ default 형태의 생성자도 만들어주기
	public MemberDTO()
	{}
	
	// 필요에 따라서 이렇게 생성자 정의했으면..!!
	// ★★★→ default 형태의 생성자도 만들어주기
	public MemberDTO(String name, String tel, String addr)
	{
		this.name = name;
		this.tel = tel;
		this.addr = addr;
	}
	
	public String getName()
	{
		return name;
	}

	public void setName(String name)
	{
		this.name = name;
	}

	public String getTel()
	{
		return tel;
	}

	public void setTel(String tel)
	{
		this.tel = tel;
	}

	public String getAddr()
	{
		return addr;
	}

	public void setAddr(String addr)
	{
		this.addr = addr;
	}
	
	
}
