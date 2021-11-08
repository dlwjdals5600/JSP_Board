<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    //한글깨짐 방지코드
    request.setCharacterEncoding("utf-8");

      //수정폼에서 글번호를 받아온다.
      String seq_ = request.getParameter("seq");
    int seq = 0;
    
    //사용자가 직접 "상세글보기"로 접근하는 걸 막음
    if(seq_==null || seq_.equals("")){
       response.sendRedirect("getBoardList.jsp");//목록페이지로 보냄
    }else{
       seq = Integer.parseInt(seq_);
    }       
    

    String title = request.getParameter("title");
    String userid = request.getParameter("userid");
    String nickname = request.getParameter("nickname");
    String content  = request.getParameter("content");
    
    int cnt = 0;
    Connection conn = null;
    PreparedStatement pstmt = null;
    
    try {
      Class.forName("com.mysql.cj.jdbc.Driver");
      
      String dbUrl = "jdbc:mysql://localhost:3306/jspstudy?useUnicode=true&characterEncoding=utf8";
      String dbId = "root";
      String dbPwd = "123";
      
      conn = DriverManager.getConnection(dbUrl,dbId,dbPwd);
      
      //쿼리 생성후 결합하여 pstmt 객체 생성
      String sql = "update board set title=?, nickname=?, content=?, userid=? where seq = ?";
      pstmt = conn.prepareStatement(sql);
      //쿼리문에 대입해야 할 값 세팅 - ?(물음표)에 순차적으로 값 대입, 1부터 시작
      pstmt.setString(1, title);
      pstmt.setString(2, nickname);
      pstmt.setString(3, content);
      pstmt.setString(4, userid);
      pstmt.setInt(5, seq);
      
      //insert, update, delete  -> executeUpdate();
      //insert된 행의 개수를 리턴
      cnt = pstmt.executeUpdate();
      
      System.out.println(cnt + "개의 데이터 행이 입력되었습니다.");
      
      
    } catch (ClassNotFoundException | SQLException e) {
      // TODO Auto-generated catch block
      e.printStackTrace();
      
    } finally {
      //6. 사용한 DB자원 닫기
      //시스템 자원이 불필요하게 소모된는 걸 방지
      //다 쓰고 나면 DB관련 여러 객체를 닫아줘야 한다.
      if (pstmt != null) {try {pstmt.close();} catch (SQLException sqlEx) { } }
      if (conn != null) {try {conn.close();} catch (SQLException sqlEx) { } }
    }

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSP 게시판</title>
</head>
<body>
  <h1>게시글 수정결과</h1>
  
  <%
     if(cnt>0){
  %>
  
  <p>수정성공~!</p>
  
  <%
     }else{
  %>  
  
  <p>수정실패~!</p>
  
  <%
     }
  %>
    
  
  <p><a href="10_table.jsp">목록보기</a></p>
</body>
</html>