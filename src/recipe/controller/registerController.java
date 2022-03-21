package recipe.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import recipe.dao.registerDao;
import recipe.model.registerBean;

@WebServlet("/register")
public class registerController extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	private registerDao registerDao;

    @Override
	public void init() throws ServletException {
		registerDao = new registerDao();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {		
		request.setCharacterEncoding("UTF-8");
		
		String id = request.getParameter("ID1").trim();
		String pw = request.getParameter("PW1").trim();
		String userName = request.getParameter("userName").trim();
		String name = request.getParameter("name1").trim();
		Integer postNum = Integer.parseInt(request.getParameter("postNum").trim());
		String address = request.getParameter("address").trim();
		String phoneNum = request.getParameter("phoneNum1").trim();
	
		registerBean register = new registerBean(id, pw, userName, name, postNum, address, phoneNum);
		
		registerDao.registerUser(register);
		
		response.sendRedirect("main.jsp");
	}
}
