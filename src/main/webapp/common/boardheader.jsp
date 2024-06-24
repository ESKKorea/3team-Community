<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<header>
	<h3> Free List</h3>
      <form action="<c:url value='/boardList'/>" method="get" class="search-form" >
      <select name="searchType">
            <option value="member_id">작성자</option>
            <option value="title">제목</option>
            <option value="description">내용</option>
        </select>
        <input type="text" name="keyword" placeholder="검색어 입력" />
        <input type="submit" value="검색" />
    </form>
</header>