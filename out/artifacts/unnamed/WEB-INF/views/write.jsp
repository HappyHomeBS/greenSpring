<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>글쓰기</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">

    <style>
        table {margin:100px auto;}
        tr:nth-of-type(4) {text-align: right;}
        td                {padding:3px}
        td:nth-of-type(1) {width:90px; text-align: right;}
        td:nth-of-type(2) {width:700px;}
        textarea          {width:100%; height:400px; resize:none; border-radius: 8px;}
        input[type=text]  {border:1px solid; width:100%; height:30px; border-radius: 8px;}
    </style>

    <script src="http://code.jquery.com/jquery-3.6.1.min.js"></script>
    <script>

        $.ajax( {
            url  :  '/viewupdate?_id=' + ${_id} ,
            data :  {
                _id : $('#_id').val() ,
                title : $('#title').val(),
                content : $('#content').val(),
                username : $('#username').val(),
                category : $('#category').val(),
                bnum : $('#bnum').val(),
                lvl : $('#lvl').val(),
                step : $('#step').val(),
            },
            method   : "GET",
            dataType:  "json"
        })
            .done(function( result, textStatus, xhr ) {
                var resultStr = JSON.stringify( result ); // JSOn -> string
                var html= "";

                for(var i = 0; i < result.length; i++  ){
                    var _id = result[i]._id
                    var title = result[i].title
                    var content = result[i].content
                    var username = result[i].username
                    var category = result[i].category
                    var bnum = result[i].bnum
                    var lvl = result[i].lvl
                    var step = result[i].step

                    html += '<tr>';
                    html += '<td> 답 글 쓰기 </td>';
                    html += '</tr>';
                    html += '<td> 제목 </td>';
                    html += '<td><input type="text" name="title" maxLength="20" value="'+title+'" ></td>';
                    html += '<td> 카테고리 : </td>';
                    if(category == '1'){
                        html += '<td> 강아지 </td>';
                        html += '<input type="hidden" name="category" value="1" />';
                    }
                    else if(category =='2') {
                        html += '<td> 고양이 </td>';
                        html += '<input type="hidden" name="category" value="2" />';
                    }
                    else if(category =='3') {
                        html += '<td> 기타 </td>';
                        html += '<input type="hidden" name="category" value="3" />';
                    }
                    html += '</tr>';
                    html += '<tr>';
                    html += '<td></td>';
                    html += '<td colspan="3"><textarea maxLength="500" name= "content" >'+ content + '\n====================\n</textarea></td>';
                    html += '</td>';
                    html += '</tr>';
                };

                $('#reply').html(html);
            })
            .fail(function( error ) {
                console.log( error );
            });





        window.onload = function() {
            var formEl = document.getElementById('form');
            formEl.addEventListener('submit', function(e) {
                // 필수 입력 제목, 내용
                const  titleEl = document.querySelector('[name=title]');
                const  contentEl = document.querySelector('[name=content]');
                const  categoryEl = document.querySelector('[name=category]');

                if(  titleEl.value.trim() == ''  ) {
                    alert('제목을 입력하세요');
                    e.preventDefault();   // 기본이벤트 제거
                    e.stopPropagation();  // 이벤트 버블링 방지 - 다른 이벤트에 영향을 주지 못함
                }

                if( categoryEl.value.trim() == '0') {
                    alert('카테고리를 선택하세요');
                    e.preventDefault();   // 기본이벤트 제거
                    e.stopPropagation();  // 이베늩 버블링 방지 - 다른 이벤트에 영향을 주지 못함
                }

                if( contentEl.value.trim() == '') {
                    alert('내용을 입력하세요');
                    e.preventDefault();   // 기본이벤트 제거
                    e.stopPropagation();  // 이베늩 버블링 방지 - 다른 이벤트에 영향을 주지 못함
                }


            } );
        }

        var submit = document.getElementById('submitButton');
        submit.onclick = showImage;     //Submit 버튼 클릭시 이미지 보여주기

        function showImage() {
            var newImage = document.getElementById('image-show').lastElementChild;
            newImage.style.visibility = "visible";

            document.getElementById('image-upload').style.visibility = 'hidden';

            document.getElementById('fileName').textContent = null;     //기존 파일 이름 지우기
        }


        function loadFile(input) {
            var file = input.files[0];

            var name = document.getElementById('fileName');
            name.textContent = file.name;

            var newImage = document.createElement("img");
            newImage.setAttribute("class", 'img');

            newImage.src = URL.createObjectURL(file);

            newImage.style.width = "10%";
            newImage.style.height = "10%";
            newImage.style.objectFit = "contain";

            var container = document.getElementById('image-show');
            container.appendChild(newImage);
        };


    </script>

</head>
<body>
<!-- ( get방식에는 enctype이 없기때문에 null을 반환한다 ) -->
<form action="/write_insert" id="form" encType = "multipart/form-data" method="post" >
    <input type="hidden" name="username"  value=${username} />
    <input type="hidden" name="_id"       value=${_id} />
    <input type="hidden" name="bnum"      value=${ bnum } />
    <input type="hidden" name="lvl"       value=${ lvl  } />
    <input type="hidden" name="step"      value=${ step } />
    <input type="hidden" name="readcount" value="0" />
    <table>

        <c:choose>
        <c:when test="${ lvl eq 0 }" >
        <tr>
            <td>새 글 쓰기</td>
        </tr>
        <tr>
            <td>제목 :</td>
            <td>
                <input type="text" name="title" maxLength="20" >
            </td>
        </tr>

        <tr>
            <td>애완동물 :</td>
            <td>
                <select size="1" name="category" >
                    <option name="info" value="0">선택하세요.</option>
                    <option name="info" value="1">개</option>
                    <option name="info" value="2">고양이</option>
                    <option name="info" value="3">기타</option>
                </select>
            </td>
        </tr>

        <tr>
            <td> </td>
            <td>
                <textarea maxLength="500" name= "content" placeholder="내용을 입력하세요" value="content"></textarea>
            </td>
        </tr>
        </c:when>

        <c:otherwise>
        <div id="reply"></div>
        </c:otherwise>
        </c:choose>

        <tr>
            <div class="container">
                <div class="image-upload" id="image-upload">
                    <input type="file" id="chooseFile" name="file" accept="image/*" onchange="loadFile(this)">
                    <div class="fileContainer">
                        <div class="fileInput">
                            <p>FILE NAME: </p>
                            <p id="fileName"></p>
                        </div>
                        <div class="buttonContainer"></div>
                    </div>
                </div>
                <div class="image-show" id="image-show"></div>
            </div>
        </tr>
</form>
<tr>
    <td colspan="2">
        <input type="submit" id="submit" value="저장" />
        <a href="/list?category=&num=1" class="btn btn-primary">게시판</a>
        <a class="btn btn-primary">삭제</a>
    </td>
</tr>
</table>

</body>
</html>