<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>받은 쪽지함</title>

        <link rel="stylesheet" href="/css/messageBox.css">
        <script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>

        <script>


        		   $.ajax( {
        			   url  :  '/getreceptnote?recept=1234'  ,
        			   data :  {
        				   _id : $('#_id').val() ,
        				   content : $('#content').val(),
        				   send : $('#send').val() ,
        				   time : $('#time').val() ,
        		       },
        		       method   : "GET",
        		       dataType:  "json"
        		   } )
        		   .done(function( result, textStatus, xhr ) {
        			   console.log( result );
        			   var resultStr = JSON.stringify( result ); // JSOn -> string

                        var html= "";
        			  for(var i = 0; i < result.length; i++ ) {
                     var _id = result[i]._id
                     var content = result[i].content
                     var send = result[i].send
                     var time = 1234

                     console.log(send)


        			   html         += "<tr>";
        			   html         += '<td><input type ="checkbox" name = "chk_list"></td>';
        			   html         += '<td style="text-align: center;">' + _id + '</td>';
        			   html         += '<td style="text-align: center; padding-left:30px;">';
        			   html         += '<div class="cc">';
        			   html         += '<a href ="/readNote?id='+_id +'">'+ content +'</a>';
        			   html         += '</div></td>';
        			   html         += '<td style="width:170px; text-align: center;">'+ send +'</td>';
        			   html         += '<td style="width:200px; text-align: center;">'+ time +'</td>';
        			   html         += "</tr>";
                      }
                      console.log(html);
                        $('#noteList').html( html );
        		   })
        		   .fail(function(error, textStatus, errorThrown ) {
        			   console.log ( error );
        			   alert('Error:' + error)
        		   });





        </script>
    </head>
    <body>
        
        
        <section>
            <div id="main_content">
                <div id="message_box">
                    <h3>
                       받은 쪽지함
                    </h3>


                    <div>
                           
      <table class="table_box" >
	<colgroup><col width="5%">
		<col width="10%">
		<col width="40%">
		<col width="25%">
		<col width="20%">
	</colgroup>
	
	<thead>
		<tr>
		    <th></th>	
		    <th>번호</th>
		    <th>내용</th>
			<th>보낸사람</th>
			<th>등록일</th>
				
		</tr>
	</thead >
	        <tbody id = "noteList">

	        </tbody>

</table>
<hr>
                        <!-- 쪽지함 이동 버튼들 -->
                        <ul class="buttons">
                            <li><button onclick="location.href='/SendMessage'">삭제</button></li>
                            <li><button onclick="location.href='/sendNote?send=1234'">보낸 쪽지함</button></li>
                            <li><button onclick="location.href='/writeNoteForm'">쪽지 보내기</button></li>
                        </ul>
                    </div>
 
                </div>
            </div>
        </section>
 
    </body>
</html>