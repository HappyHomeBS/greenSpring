<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>회원탈퇴</title>
    <%@ include file="/WEB-INF/views/header.jsp"%>
    <style>
        *     { box-sizing:border-box;  }

        body  { text-align: center;
            align-items: center;
            padding-bottom: 40px;
            background-color: #f5f5f5;}

        main {
            display: block;
        }

        .leaveUserForm { width:600px; margin:0 auto; }

        .leaveUserForm input{

            border:1px solid grey;
            border-radius:10px;
            width: 40%;
            padding: 10px;
            margin:5px;

        }

        a { text-decoration: none; font-size: 16px; }

        .con { width:100% }

        #form1 { width:100%; }
        #pwOK { width: 15%; margin-top: 20px; border:1px solid;}

        hr  {  margin-bottom:70px; }

        .leaveUserlabel { margin-top: 20px; }

        .error { margin-top: 20px; text-align: center; margin-bottom: 20px;}

        .label1 { margin-bottom: 20px; }

        .bottom-a { margin-top: 20px; }


    </style>
    <script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
    <script>
        window.onload = function() {
            const form = document.querySelector('form');

            form.addEventListener('submit', function(e) {
                const username = document.getElementById('username').value;
                const userpassword = document.getElementById('userpassword').value;

                if(username == '') {
                    e.preventDefault();
                    alert('아이디를 입력해주세요.');
                } else if(userpassword == '') {
                    e.preventDefault();
                    alert('비밀번호를 입력해주세요.');
                } else if(username == '${username}' && userpassword == '${userpassword}') {
                    let result = confirm('탈퇴하시겠습니까?');
                    if(result == true) {
                        alert('회원탈퇴가 완료되었습니다.');
                    } else {
                        e.preventDefault();
                        location.reload();
                    }
                }
            });
        } // window.load end

    </script>
</head>
<body>
<div class="leaveUserForm">
    <h2 class="leaveUserlabel">회원탈퇴</h2>
    <hr />
    <form action="/leaveUserSuccess" method="POST" id="form1" name="form1">
        <div class="con">
            <div class="label1"><label>탈퇴는 신중하게 생각하세요!</label></div>
            <div>
                <input type="text" id="username" name="username" placeholder="아이디"/>
                <input type="password" id="userpassword" name="userpassword" placeholder="비밀번호"/><br>
                <span id="pwCheck"></span>
            </div>

            <div>
                <c:if test="${message == 'error'}">
                    <div class="error" style="color:red;"> 아이디 또는 비밀번호가 일치하지 않습니다.</div>
                </c:if>
            </div>

            <div><input type="submit" class="btn btn-primary" id="pwOK" name="pwOK" value="탈퇴하기"/></div>
            <div class="bottom-a"><a href="javascript:history.back()">이전으로</a></div>

        </div>
    </form>
</div>
</body>
</html>