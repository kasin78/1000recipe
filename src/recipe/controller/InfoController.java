package recipe.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import recipe.dao.InfoDao;
import recipe.model.registerBean;

@WebServlet("/info")
public class InfoController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	@Override
	public void init() throws ServletException {
		new InfoDao();
	}
	
	

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		String id = request.getParameter("id");
		String password = request.getParameter("password");
		String userName = request.getParameter("userName");
		String name = request.getParameter("name");
		int postNum = Integer.parseInt(request.getParameter("postNum")); // getparameter은 항상 스트링타입이므로 형변환
		String address = request.getParameter("address");
		String phoneNum = request.getParameter("phoneNum");
		
		
		registerBean register = new registerBean(id, password, userName, name, postNum, address, phoneNum);
		InfoDao UpdateRegister = new InfoDao();
		int result = UpdateRegister.update(register);
		
		if (result > 0) {
			System.out.println("회원수정 성공");
			response.sendRedirect("main.jsp");
		} else {
			System.out.println("회원수정 실패");
			response.sendRedirect("main.jsp");
		}

	}

}
