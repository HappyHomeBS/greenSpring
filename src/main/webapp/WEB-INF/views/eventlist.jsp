<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>이벤트 게시판</title>
    <%@ include file="/WEB-INF/views/header.jsp"%>
    <%@ include file="side.jsp"%>

    <style>
        table             {margin:50px auto;}
        tr:nth-of-type(1) {width:100%; text-align:center;}
        td                {padding:3px}
        a                 { text-decoration-line: none; color: black; }
        .left             { text-align:left !important;}
        .center           { text-align:center !important;}
        .right            { text-align:right !important;}
        .layer            { text-align: center; }
        .layer .content   { display: inline-block; }

    </style>

    <script>

        $.ajax( {
            url  :  '/geteventlist?num=${num}'  ,
            data :  {
                _id : $('#_id').val() ,
                writer : $('#writer').val() ,
                title : $('#title').val(),
                time : $('#time').val() ,
                start_time : $('#start_time').val() ,
                end_time : $('#end_time').val() ,
                readcount : $('#readcount').val() ,

            },
            method   : "GET",
            dataType:  "json"
        } )
            .done(function( result, textStatus, xhr ) {
                console.log( result );
                var resultStr = JSON.stringify( result ); // JSOn -> string

                var html= "<div class='row'>";

                for(var i = 0; i < result.length; i++ ) {
                    var _id = result[i]._id
                    var writer = result[i].writer
                    var title = result[i].title
                    var start_time = result[i].start_time
                    var end_time = result[i].end_time
                    var readcount = result[i].readcount
                    var eventimage = result[i].eventimage

                    var _num = i

                    console.log(writer)


                    html         += "<div class='col-3'>";
                    html         += '<div class="card" style="width: 17rem; margin: 0 900px 0 20px;”">'
                    html         += '<a href ="/eventcont?_id='+_id +'"><img src="http://donipop.com:8000/img/' + eventimage + '" class="card-img-top" style="width:100%; height:130px;"></a>'
                    html         += '<div class="card-body">'
                    html         += '<h5 class="card-title"><a href ="/eventcont?_id='+_id +'">' + title + '</a></h5>'
                    html         += '</div>'
                    html         += '<ul class="list-group list-group-flush">'
                    html         += '<li class="list-group-item">' + start_time +' ~ '+ end_time + '</li>'
                    html         += '</ul>';
                    html         += '</div>';
                    html         += "</div>";
                }
                html += "</div>"
                console.log(html);
                $('#noticeList').html( html );
            })
            .fail(function(error, textStatus, errorThrown ) {
                console.log ( error );
                alert('Error:' + error)
            });

    </script>
</head>
<body>
<div class="container">

    <section>
        <div>
            <div style="text-align: center;">
                <div class="btn-group" role="group" aria-label="Basic radio toggle button group">
                    <input type="radio" class="btn-check" name="btnradio" id="btnradio1" autocomplete="off" checked>
                    <label class="btn btn-outline-primary" for="btnradio1" onclick="location.href='/eventlistform?num=1'">전체 이벤트</label>

                    <input type="radio" class="btn-check" name="btnradio" id="btnradio2" autocomplete="off">
                    <label class="btn btn-outline-primary" for="btnradio2" onclick="location.href='/noweventlist?num=1'">진행중인 이벤트</label>

                    <input type="radio" class="btn-check" name="btnradio" id="btnradio3" autocomplete="off">
                    <label class="btn btn-outline-primary" for="btnradio3" onclick="location.href='/pasteventlist?num=1'">종료된 이벤트</label>
                </div>

                <div>

                    <table class="table">
                        <thead>
                        <tr>
                            <td colspan="5"  style="border-bottom: none;">
                                <h3 class="center">
                                    이벤트
                                </h3>
                            </td>
                        </tr>
                        </thead >
                        <tbody id = "noticeList" class="content">

                        </tbody>

                    </table>


                    <div style="text-align: center;">
                        <!-- 쪽지함 이동 버튼들 -->
                        <ul class="buttons right">

                            <a id='adminlist' href = "/writeeventForm" class="btn btn-primary">글쓰기(관리자용)<a>
                        </ul>


                        <c:if test="${page.prev}">
                            <span>[ <a href="/eventlistform?num=${page.startpagenum - 1}">이전</a> ]</span>
                        </c:if>

                        <c:forEach begin="${page.startpagenum}" end="${page.endpagenum}" var="num">
  <span>
   <c:if test="${select != num}">
       <a href="/eventlistform?num=${num}">${num}</a>
   </c:if>

     <c:if test="${select == num}">
         <b>${num}</b>
     </c:if>
 </span>
                        </c:forEach>

                        <c:if test="${page.next}">
                            <span>[ <a href="/eventlistform?num=${page.endpagenum + 1}">다음</a> ]</span>
                        </c:if>
                    </div>

                </div>

            </div>
        </div>
    </section>
    <script>
        if('${user.role}' != 'ADMIN'){
            $('#adminlist').css('display','none');
        }
    </script>
</div>
</body>
</html>