<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>ID / PW 찾기</title>
  </head>
  <body>
    <c:if test="${foundId == null && foundPw == null}"> 아이디가 존재하지 않습니다 </c:if>
    <c:if test="${foundId != null}"> 당신의 아이디는 "<b>${foundId}</b>" 입니다 </c:if>
    <c:if test="${foundPw != null}"> 당신의 패스워드는 "<b>${foundPw}</b>" 입니다 </c:if>
  </body>
</html>
