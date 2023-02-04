<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>반짝찾기</title>

    <%@ include file="/WEB-INF/views/header.jsp"%>

    <style>
        .marketing .col-lg-4 {
            margin-bottom: 1.5rem;
            text-align: center;
          }
    </style>
</head>
<body>
    <div class="container marketing">
        <div id="row" class="row pt-5">
        </div>
    </div>

    <script>
        window.onload = function(){
            const img = $('.col-lg-4');
            //mouse over
            img.mouseover(function(){
                this.classList.add('shadow', 'p-3', 'mb-5', 'bg-body', 'rounded', 'border');
            });
            //mouse out
            img.mouseout(function(){
                this.classList.remove('shadow', 'p-3', 'mb-5', 'bg-body', 'rounded', 'border');
            });

            createBanjjakDom();

            

        }
        function show(username){
            window.open("/writeNoteForm?reply="+ username, "note", "width=880, height=650");
            }

        function createBanjjakDom(){
            //c.username, c.usernickname, c.userpetinfo, p.profiledata
            let usernickname = '';
            let userpetinfo = '';
            let profiledata = '';
            const row = document.getElementById('row');
            
            $.ajax({
                url: "/banjjaklist",
                type: "GET",
                dataType: "json",
            }).done(function (data) {
                //console.log(data);
                
                for(let i = 0; i < data.length; i++){
                    if(data[i].userpetinfo == null){
                    userpetinfo = '반려동물 정보가 없습니다.';
                    }else{
                        userpetinfo = data[i].userpetinfo;
                    }
                    
                    let content = '<div class="col-lg-4 btn" type="button" onclick="show(\'' + data[i].username + '\');">'+
                    '<img class="bd-placeholder-img rounded-circle" width="140" height="140" src="http://donipop.com:8000/img/' + data[i].profiledata + '">'+
                    '<h2 class="fw-normal">' + data[i].usernickname + '</h2>'+
                    '<p>' + userpetinfo + '</p>'+
                    '</div>'
                    row.innerHTML += content;

                }
            }).fail(function (error) {
                console.log("error : " + error);
            });


            
        }

        
    </script>
</body>
</html>