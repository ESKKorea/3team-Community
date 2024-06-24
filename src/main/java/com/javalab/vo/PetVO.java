package com.javalab.vo;

import java.io.Serializable;
import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

/**
 * 유기견/유기묘 정보를 나타내는 자바 빈즈 클래스
 */
@AllArgsConstructor
@NoArgsConstructor
@Getter @Setter
@ToString
public class PetVO implements Serializable {

    private static final long serialVersionUID = 1L;

    private int id;             // 유기견/유기묘 번호
    private String name;        // 이름
    private int age;            // 나이
    private String description; // 설명
	/*
	 * private String memberId; // 작성자 ID private Date regDate; // 작성일자 private
	 * String type; // 반려동물 종류
	 */    
    private String pageNum = "1";       // 요청 페이지번호(기본값을 1)
    private Integer listCount = 10;     // 한 페이지에 보여줄 게시물갯수
    private Integer pagerPerBlock = 10; // 페이지 블록당 페이지 수

    // 생성자들
    public PetVO(String name, int age, String description) {
        this.name = name;
        this.age = age;
        this.description = description;
		/*
		 * this.memberId = memberId; this.type = type;
		 */
    }



}
