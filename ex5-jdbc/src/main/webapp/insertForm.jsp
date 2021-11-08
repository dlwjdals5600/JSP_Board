<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSP 게시판</title>
</head>
<body>
<h1>게시글 추가</h1>
   <form action="insert.jsp" method="post">
      <fieldset>
         <legend>내용입력</legend>
         <ul>
            <li>제목 : <input type="text" name="title" /> </li>
            <li>작성자 : <input type="text" name="userid" /> </li>
            <li>닉네임 : <input type="text" name="nickname" /> </li>
            <li>내용 : <textarea name="content" id="content" cols="30" rows="10"></textarea> </li>
         </ul>
      </fieldset>
      
      <p>
      <button>확인</button>
      <button onclick="history.back();">취소</button>
      </p>
      
   </form>
<p><a href="getBoardList.jsp">목록보기</a></p>
</body>
</html>