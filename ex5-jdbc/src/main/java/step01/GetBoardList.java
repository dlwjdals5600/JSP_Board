package step01;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;

//자바는 여러개의 class를 결합해서 작동하는 프로그램이다.
public class GetBoardList {

   public static void main(String[] args) {
      
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
            rs = pstmt.executeQuery();
            
            //5. 결과처리(출력)
            while(rs.next()) {//데이터가 있을때가지만 반복
               
               //헤더가 가리키는 데이터행의 정보를 변수에 저장
               int seq = rs.getInt("seq");
               String title = rs.getString("title");
               String content = rs.getString("content");
               String nickname = rs.getString("nickname");
               Date regdate = rs.getDate("regdate");
               int cnt = rs.getInt("cnt");
               String userid = rs.getString("userid");
               
               System.out.println(seq +"\t"+ title +"\t"+ content +"\t"+ nickname +"\t"+ userid +"\t"+ regdate +"\t"+ cnt);
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
         


   }

}