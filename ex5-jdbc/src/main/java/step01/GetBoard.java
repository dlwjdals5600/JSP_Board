package step01;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;


public class GetBoard {

	public static void main(String[] args) {

		Connection conn = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;

	    int seq_ = 3; //사용자로부터 전달받은 값을 상
	    
	    try {
	    	Class.forName("com.mysql.cj.jdbc.Driver");
	    	
	    	String dbUrl = "jdbc:mysql://localhost:3306/jspstudy?useUnicode=true&characterEncoding=utf8";
            String dbId = "root";
            String dbPwd = "123";
	    	
	    	conn = DriverManager.getConnection(dbUrl,dbId,dbPwd);
	    	
	    	String sql = "select * from board where seq = ?";
	    	pstmt = conn.prepareStatement(sql);
	    	pstmt.setInt(1, seq_);
	    	
	    	//select -> executeQuery();
	    	rs = pstmt.executeQuery();
	    	
	    	rs.next(); //헤더가 현재 데이터의 row를 가리킨다.
	    	
	    	int seq = rs.getInt("seq");
            String title = rs.getString("title");
            String content = rs.getString("content");
            String nickname = rs.getString("nickname");
            Date regdate = rs.getDate("regdate");
            int cnt = rs.getInt("cnt");
            String userid = rs.getString("userid");
            
            System.out.println(seq +"\t"+ title +"\t"+ content +"\t"+ nickname +"\t"+ userid +"\t"+ regdate +"\t"+ cnt);
            
	    	
	    } catch (ClassNotFoundException | SQLException e) {
            System.out.println("JDBC 드라이버 로딩 오류 발생~!");
            e.printStackTrace();
	    } finally {
	    	if (rs != null) {try {rs.close();} catch (SQLException sqlEx) { } }
            if (pstmt != null) {try {pstmt.close();} catch (SQLException sqlEx) { } }
            if (conn != null) {try {conn.close();} catch (SQLException sqlEx) { } }
	    }
	}

}
