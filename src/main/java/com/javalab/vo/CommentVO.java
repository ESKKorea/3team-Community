package com.javalab.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

import java.util.Date;

@AllArgsConstructor
@NoArgsConstructor
@Getter @Setter
@ToString

public class CommentVO {
    private int id;
    private int boardId;
    private String memberId;
    private String content;
    private Date regDate;
}
