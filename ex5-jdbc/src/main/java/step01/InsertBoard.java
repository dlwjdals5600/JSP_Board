package step01;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class InsertBoard {

	public static void main(String[] args) {
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			
			String dbUrl = "jdbc:mysql://localhost:3306/jspstudy?useUnicode=true&characterEncoding=utf8";
			String dbId = "root";
			String dbPwd = "123";
			
			conn = DriverManager.getConnection(dbUrl, dbId, dbPwd);
			
			//쿼리 생성후 결합하여 pstmt 객체 생성 
			String sql = "insert into board (title, nickname, content, userid) values (?,?,?,?);";
			pstmt = conn.prepareStatement(sql);
			//쿼리문에 대입해야 할 값 세팅 - ?(물음표)에 순차적으로 값 대입, 1부터 시작 
			pstmt.setString(1, "new Title");
			pstmt.setString(2, "new Nickname");
			pstmt.setString(3, "new Content");
			pstmt.setString(4, "duly");
			
			//insert, update, delete -> executeUpdate();
			//insert된 행의 개수를 리턴 
			int cnt = pstmt.executeUpdate();
			
			System.out.println(cnt + "개의 데이터 행이 입력되었습니다.");
			
		} catch (ClassNotFoundException | SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
            if (pstmt != null) {try {pstmt.close();} catch (SQLException sqlEx) { } }
            if (conn != null) {try {conn.close();} catch (SQLException sqlEx) { } }
		}
		

	}

}
