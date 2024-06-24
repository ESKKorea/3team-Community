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

    private int bno;             // 유기견/유기묘 번호
    private String name;         // 이름
    private int age;             // 나이
    private String description;  // 설명
    private String memberId;     // 작성자 ID
    private Date regDate;        // 작성일자

    private String type;         // 추가적인 속성 필요 시 구현

    private String pageNum = "1";        // 요청 페이지번호(기본값을 1)
    private Integer listCount = 10;      // 한 페이지에 보여줄 게시물 갯수
    private Integer pagerPerBlock = 10;  // 필요에 따라 추가적으로 구현할 수 있는 속성들

    // 생성자들
    public PetVO(String name, int age, String description, String memberId) {
        this.name = name;
        this.age = age;
        this.description = description;
        this.memberId = memberId;
    }

    public PetVO(int bno, String name, int age, String description, String memberId) {
        this.bno = bno;
        this.name = name;
        this.age = age;
        this.description = description;
        this.memberId = memberId;
    }

    // Getter, Setter, ToString 등은 롬복(@Getter, @Setter, @ToString)을 사용하여 자동 생성됨
}
