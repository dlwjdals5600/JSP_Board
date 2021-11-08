package step01;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class UpdateBoard {

	public static void main(String[] args) {
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			
			String dbUrl = "jdbc:mysql://localhost:3306/jspstudy?useUnicode=true&characterEncoding=utf8";
			String dbId = "root";
			String dbPwd = "123";
			
			conn = DriverManager.getConnection(dbUrl, dbId, dbPwd);
			
			String sql = "update board set title=?, content=?, nickname=? where seq = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "change Title");
			pstmt.setString(2, "change Content");
			pstmt.setString(3, "change Nickname");
			pstmt.setInt(4, 7);
			
			int cnt = pstmt.executeUpdate();
			
			System.out.println(cnt + "개의 행이 수정되었습니다.");
			
		} catch (ClassNotFoundException | SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			if (pstmt != null) {try {pstmt.close();} catch (SQLException sqlEx) { } }
            if (conn != null) {try {conn.close();} catch (SQLException sqlEx) { } }
		}
	}

}
