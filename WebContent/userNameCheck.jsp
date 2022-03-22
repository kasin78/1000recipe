<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%
	String userName = request.getParameter("userName");

try {
	String url = "jdbc:mysql://localhost:3306/recipe?useSSL=false";
  	String sql = "SELECT * FROM register "
             + "WHERE userName = ?";

	Connection conn = DriverManager.getConnection(url, "root", "1234");

	PreparedStatement pstmt = conn.prepareStatement(sql);

	pstmt.setString(1, userName);

	ResultSet rs = pstmt.executeQuery();

	if (rs.next()) {
		out.print("이미 사용되고있는 닉네임입니다");
	} else {
		out.print("사용가능한 닉네임입니다");
	}
	conn.close();
} catch (Exception e) {
	e.printStackTrace(); // 예외 출력
	out.print("예외 발생");
}
%>
