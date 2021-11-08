<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.util.Date"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    //이전페이지에서 글번호를 받아온다.
    String seq_ = request.getParameter("seq");

     String rsResult = "";
    
     //DB에서 추출한 정보를 저장할 변수선언
     int seq = 0;
     String title = "";
     String userid = "";
     String nickname = "";
     Date regdate = null;
     int cnt = 0; 
     String content = "";
     
     
    //사용자가 직접 "상세글보기"로 접근하는 걸 막음
    if(seq_==null || seq_.equals("")){
      response.sendRedirect("getBoardList.jsp");//목록페이지로 보냄
    }else{
      seq = Integer.parseInt(seq_);
      
      Connection conn = null;
      PreparedStatement pstmt = null;
      ResultSet rs = null;
        

     rsResult = "상세정보발견";
     

     try {
       
         Class.forName("com.mysql.cj.jdbc.Driver");
         
         String dbUrl = "jdbc:mysql://localhost:3306/jspstudy?useUnicode=true&characterEncoding=utf8";
         String dbId = "root";
         String dbPwd = "123";
         
         conn = DriverManager.getConnection(dbUrl,dbId,dbPwd);
         
         String sql = "select * from board where seq = ?";
         pstmt = conn.prepareStatement(sql);
         pstmt.setInt(1, seq);
         
         rs = pstmt.executeQuery();
  
         if(rs.next()){
             title = rs.getString("title");
             userid = rs.getString("userid");
             nickname = rs.getString("nickname");
             regdate = rs.getDate("regdate");
             cnt = rs.getInt("cnt"); 
             content = rs.getString("content");
             
         }else{
           
           rsResult = "요청한 게시글에 대한 내용이 없습니다.";
           
         }

       } catch (ClassNotFoundException | SQLException e) {
         e.printStackTrace();
         
       }finally {
         if (rs != null) {try {rs.close();} catch (SQLException sqlEx) { } }
         if (pstmt != null) {try {pstmt.close();} catch (SQLException sqlEx) { } }
         if (conn != null) {try {conn.close();} catch (SQLException sqlEx) { } }
         
       }//end of finally  
     
    }
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSP 게시판</title>
</head>
<body>
  <h1>게시글 수정</h1>
<%
   if(rsResult.equals("상세정보발견")){
%>  
 <form action="update.jsp" method="post">
      <input type="hidden" name="seq" value="<%=seq %>" />
      <fieldset>
         <legend>내용입력</legend>
         <ul>
            <li>제목 : <input type="text" name="title" value="<%=title %>" /> </li>
            <li>작성자 : <input type="text" name="userid" value="<%=userid %>"/> </li>
            <li>닉네임 : <input type="text" name="nickname" value="<%=nickname %>"/> </li>
            <li>내용 : <textarea name="content" id="content" cols="30" rows="10"><%=content %>"</textarea> </li>
         </ul>
      </fieldset>
      
      <p>
      <button>확인</button>
      <button onclick="history.back();">취소</button>
      </p>
      
   </form>
<%  
   }else{
%> 
  <p><%=rsResult %></p>
<%
   }
%> 
  <p><a href="getBoardList.jsp">목록보기</a></p>
</body>
</html>