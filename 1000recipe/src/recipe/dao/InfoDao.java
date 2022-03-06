package recipe.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;

import recipe.model.registerBean;
import recipe.utils.JDBCUtils;

public class InfoDao {
	public int update(registerBean register){
		
		int result = 0;
		
		String sql_update = "UPDATE register SET id=?, password=?, userName=?, name=?, postNum=?, address=?, phoneNum=? where id=?";
		try {
			Connection conn = JDBCUtils.getConnection();
			PreparedStatement pstmt = conn.prepareStatement(sql_update);

			pstmt.setString(1, register.getId()); // 레지스터에서 값 가져와서 db에 넣기
			pstmt.setString(2, register.getPassword());
			pstmt.setString(3, register.getUserName());
			pstmt.setString(4, register.getName());
			pstmt.setInt(5, register.getPostNum());
			pstmt.setString(6, register.getAddress());
			pstmt.setString(7, register.getPhoneNum());
			pstmt.setString(8, register.getId()); // 레지스터에서 값 가져와서 db에 넣기
			
			result = pstmt.executeUpdate();
			
		} catch (Exception e) {
			
	
			System.out.println("수정오류");
		}

		System.out.println("회원정보 수정 완료"); // alert으로 수정고려
		return result;

	}
	
}