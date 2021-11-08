package step01;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class DeleteBoard {

	public static void main(String[] args) {
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			
			String dbUrl = "jdbc:mysql://localhost:3306/jspstudy?useUnicode=true&characterEncoding=utf8";
			String dbId = "root";
			String dbPwd = "123";
			
			conn = DriverManager.getConnection(dbUrl, dbId, dbPwd);
			
			String sql = "delete from board where seq = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, 7);
			
			int cnt = pstmt.executeUpdate();
			
			System.out.println(cnt + "개의 행이 삭되었습니다.");
			
		} catch (ClassNotFoundException | SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			if (pstmt != null) {try {pstmt.close();} catch (SQLException sqlEx) { } }
            if (conn != null) {try {conn.close();} catch (SQLException sqlEx) { } }
		}

	}

}
