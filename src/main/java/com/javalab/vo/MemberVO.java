package com.javalab.vo;

import java.io.Serializable;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
@AllArgsConstructor
@NoArgsConstructor
@Getter @Setter
@ToString

public class MemberVO implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private String memberId;
	private String password;
	private String name;
	private String email;
	// 비밀번호를 제외한 나머지 정보만 세션에 보관하기 위해서 별도로 생성자 정의
	public MemberVO(String memberId, String name, String email ) {
		this.memberId = memberId;
		this.name = name;
		this.email = email;
	}
}



