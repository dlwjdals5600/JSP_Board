<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSP 게시판</title>
<style>
  table{border-collapse:collapse;}
  th,td{border:1px solid black;text-align:center;padding:5px 10px;}
  
  a:link{
    color:black;
    text-decoration:none;
  }
  
  a:hover{text-decoration:underline;}  
</style>
</head>
<body>
  <h1>글목록</h1>
  
  <table>
    <tr>
      <th>번호</th>
      <th>제목</th>
      <th>작성자</th>
      <th>등록일</th>
      <th>조회수</th>
      <th>관리</th>
    </tr>
<%
   Connection conn = null;
   PreparedStatement pstmt = null;
   ResultSet rs = null;
   
    try {
        //1. mysql-connector-java-8.0.23.jar 파일을 사용할 수 있도록 로드
        Class.forName("com.mysql.cj.jdbc.Driver");
        
        
        //DB식별정보 - 한글데이터를 올바르게 식별하기위해 utf8 캐릭터셋 지정
        String dbUrl = "jdbc:mysql://localhost:3306/jspstudy?useUnicode=true&characterEncoding=utf8";
        String dbId = "root";
        String dbPwd = "123";
        
        
        //2. DB연결
        conn = DriverManager.getConnection(dbUrl,dbId,dbPwd);
        
        
        //3. 쿼리문 생성후 결합하여 pstmt 객체생성
        String sql = "select * from board order by seq desc";
        pstmt = conn.prepareStatement(sql);
        
        //4. 쿼리실행하여 rs객체에 데이터집합을 할당
        //select -> executeQuery()
        rs = pstmt.executeQuery();
        
        //5. 결과처리(출력)
        while(rs.next()) {//데이터가 있을때가지만 반복

%>  
    <tr>
      <td><%=rs.getInt("seq") %></td>
      <td><a href="getBoardList.jsp?seq=<%=rs.getInt("seq") %>"><%=rs.getString("title") %></a></td>
      <td><%=rs.getString("nickname") %></td>
      <td><%=rs.getDate("regdate") %></td>
      <td><%=rs.getInt("cnt") %></td>
      <td>
        <a href="updateForm.jsp?seq=<%=rs.getInt("seq") %>">수정</a>
        <a href="DeleteBoard.jsp?seq=<%=rs.getInt("seq") %>">삭제</a>
      </td>
    </tr>
<%
        }
        
        
      } catch (ClassNotFoundException | SQLException e) {
        System.out.println("JDBC 드라이버 로딩 오류 발생~!");
        e.printStackTrace();
        
      } finally {
        //6. 사용한 DB자원 닫기
        //시스템 자원이 불필요하게 소모된는 걸 방지
        //다 쓰고 나면 DB관련 여러 객체를 닫아줘야 한다.
        if (rs != null) {try {rs.close();} catch (SQLException sqlEx) { } }
        if (pstmt != null) {try {pstmt.close();} catch (SQLException sqlEx) { } }
        if (conn != null) {try {conn.close();} catch (SQLException sqlEx) { } }
      }

%> 
    
  </table>
  
  <p>
    <a href="insertForm.jsp">새글작성</a>
  </p>
</body>
</html>