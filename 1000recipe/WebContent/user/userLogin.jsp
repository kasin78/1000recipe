<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="recipe.model.UserInfo"%>
<%@page import="recipe.model.loginBean"%>
<%@page import="recipe.model.registerBean"%> 
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>1000개의 레시피</title>
    <!-- css 링크 -->
    <link rel="stylesheet" href="css/bootstrap.min.css" />
    <link rel="stylesheet" href="css/style.css" />
  </head>
  <body>
    <!-- Header -->
    <% registerBean info = (registerBean)session.getAttribute("info"); %>

    <!-- 마이페이지 (정보수정) 모달창 -->
    <div class="modal fade" id="modal-myUserpage" tabindex="-1" aria-labelledby="addUpdateLabel" aria-hidden="true">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <h5 id="title-add-upd" class="modal-title">정보수정</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
          </div>
          <form id="update" action="<%=request.getContextPath()%>/info" method="post">
            <div class="modal-body">
              <div class="form-group">
                <input type="text" class="form-control" id="ID9" name="id" value="<%= info.getId() %>" readonly /><div>아이디(수정불가)</div>
              </div>
            </div>

            <div class="modal-body">
              <div class="form-group">
                <input type="password" class="form-control" id="PW9" name="password" autocomplete="off" value="<%= info.getPassword() %>"  /><div>비밀번호</div>
              </div>
            </div>
            
             <div class="modal-body">
              <div class="form-group">
                <input type="password" class="form-control" id="PWCheck2" name="PWCheck" autocomplete="off"  value="<%= info.getPassword() %>"  /><div>비밀번호확인</div>
              </div>
            </div>
            <div class="alert alert-success" id="alert-success2">비밀번호가 일치합니다</div>
            <div class="alert alert-danger" id="alert-danger2">비밀번호가 일치하지 않습니다</div>
            

            <div class="modal-body">
              <div class="form-group">
                <input type="text" class="form-control" id="userName9" name="userName" value="<%= info.getUserName() %>" readonly/><div>닉네임(수정불가)</div>
              </div>
            </div>
			
			
			<div class="modal-body">
              <div class="form-group">
                <input type="text" class="form-control" id="name9" name="name" value="<%=info.getName() %>" /><div>성함</div>
              </div>
            </div>
            
           <div class="container-fluid">
              <div class="row">
                <div class="col-md-5 ps-3">
                  <input type="text" class="form-control" id="postNum9" name="postNum" value="<%=info.getPostNum() %>" />
                </div>
                <div class="col-md-4 ps-3">
                  <button type="button" class="btn btn-secondary btn-action" onclick="find_PostNum()">우편번호 찾기</button>
                </div>
              </div>
            </div>
            
            <div class="modal-body">
              <div class="form-group">
                <input type="text" class="form-control" id="address9" name="address" value="<%=info.getAddress() %>" /><div>주소</div>
              </div>
            </div>
            
            <div class="modal-body">
              <div class="form-group">
                <input type="text" class="form-control" id="phoneNum9" name="phoneNum" value="<%=info.getPhoneNum() %>" /><div>전화번호</div>
              </div>
            </div>
            
            <div class="modal-footer">
              <button type="submit" class="btn btn-success btn-action">회원정보 수정</button>
            </div>
          </form>
        </div>
      </div>
    </div>

    
        

 
  </body>
</html>
