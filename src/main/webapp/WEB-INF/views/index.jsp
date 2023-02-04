<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>안녕2</title>
    <%@ include file="/WEB-INF/views/header.jsp" %>
</head>
<body>
<script>
        window.onload = function(){
            //자유게시판 불러오기
            $.ajax({
                url: "/getCommunityList?tag=1",
                type: "GET",
                dataType: "json",
            }).done(function (data) {
                const dom_col = $(".col")[0];
                const dom_ul = dom_col.getElementsByTagName("ul")[0];
                let title = '';
                let commentcount = '';
                let username = '';
                let time = '';
                if(data.length < 5){
                    for(let i = 0; i<data.length; i++){
                    title = data[i].title;
                    commentcount = data[i].commentcount;
                    username = data[i].username;
                    time = data[i].time;
                    let content = '<li class="row m-auto">' +
                            '<a href="#" class="nav-link col-8">' + title + '[' + commentcount + ']</a>'+
                            '<span class="col-4 position-absolute end-0 text-end">' + username + ' | ' + time + '</span>'+
                        '</li>'
                    dom_ul.innerHTML += content;
                    }
                }else{
                    for(let i = 0; i<5; i++){
                    title = data[i].title;
                    commentcount = data[i].commentcount;
                    username = data[i].username;
                    time = data[i].time;
                    let content = '<li class="row m-auto">' +
                            '<a href="#" class="nav-link col-8">' + title + '[' + commentcount + ']</a>'+
                            '<span class="col-4 position-absolute end-0 text-end">' + username + ' | ' + time + '</span>'+
                        '</li>'
                    dom_ul.innerHTML += content;
                    }
                }
            }).fail(function (error) {
                console.log("자유게시판 ajax error");
                console.log(error);
            });

            //반려자랑 불러오기
            $.ajax({
                url: "/getCommunityList?tag=2",
                type: "GET",
                dataType: "json",
            }).done(function (data) {
                const dom_col = $(".col")[1];
                const dom_ul = dom_col.getElementsByTagName("ul")[0];
                let title = '';
                let commentcount = '';
                let username = '';
                let time = '';
                if(data.length < 5){
                    for(let i = 0; i<data.length; i++){
                    title = data[i].title;
                    commentcount = data[i].commentcount;
                    username = data[i].username;
                    time = data[i].time;
                    let content = '<li class="row m-auto">' +
                            '<a href="#" class="nav-link col-8">' + title + '[' + commentcount + ']</a>'+
                            '<span class="col-4 position-absolute end-0 text-end">' + username + ' | ' + time + '</span>'+
                        '</li>'
                    dom_ul.innerHTML += content;
                    }
                }else{
                    for(let i = 0; i<5; i++){
                    title = data[i].title;
                    commentcount = data[i].commentcount;
                    username = data[i].username;
                    time = data[i].time;
                    let content = '<li class="row m-auto">' +
                            '<a href="#" class="nav-link col-8">' + title + '[' + commentcount + ']</a>'+
                            '<span class="col-4 position-absolute end-0 text-end">' + username + ' | ' + time + '</span>'+
                        '</li>'
                    dom_ul.innerHTML += content;
                    }
                }
            }).fail(function (error) {
                console.log("반려자랑 ajax error");
                console.log(error);
            });

            //질문게시판 불러오기
            $.ajax({
                url: "/getCommunityList?tag=3",
                type: "GET",
                dataType: "json",
            }).done(function (data) {
                const dom_col = $(".col")[2];
                const dom_ul = dom_col.getElementsByTagName("ul")[0];
                let title = '';
                let commentcount = '';
                let username = '';
                let time = '';
                if(data.length < 5){
                    for(let i = 0; i<data.length; i++){
                    title = data[i].title;
                    commentcount = data[i].commentcount;
                    username = data[i].username;
                    time = data[i].time;
                    let content = '<li class="row m-auto">' +
                            '<a href="#" class="nav-link col-8">' + title + '[' + commentcount + ']</a>'+
                            '<span class="col-4 position-absolute end-0 text-end">' + username + ' | ' + time + '</span>'+
                        '</li>'
                    dom_ul.innerHTML += content;
                    }
                }else{
                    for(let i = 0; i<5; i++){
                    title = data[i].title;
                    commentcount = data[i].commentcount;
                    username = data[i].username;
                    time = data[i].time;
                    let content = '<li class="row m-auto">' +
                            '<a href="#" class="nav-link col-8">' + title + '[' + commentcount + ']</a>'+
                            '<span class="col-4 position-absolute end-0 text-end">' + username + ' | ' + time + '</span>'+
                        '</li>'
                    dom_ul.innerHTML += content;
                    }
                }
            }).fail(function (error) {
                console.log("질문게시판 ajax error");
                console.log(error);
            });
        }
    </script>
    <section class="pt-4 pb-0 card-grid">
        <div class="container">
            <div class="row g-4">
                <!-- 왼쪽 -->
                <div class="col-lg-6">
                    <div class="card text-bg-dark">
                        <img src="/img/mumu.jpg" class="card-img" alt="image">
                        <div class="card-img-overlay">
                        <h5 class="card-title">이주의 반려동물</h5>
                        </div>
                    </div>
                </div>
                <!-- 오른쪽 -->
                <div class="col-lg-6">
                    <div class="row g-4">

                        <div class="col-12">
                            <div id="carouselExampleControls" class="carousel slide card text-bg-dark card-overlay-bottom card-grid-sm card-bg-scale" data-bs-ride="carousel">
                                <div class="carousel-inner w-auto" style="height: 346px;">
                                  <div class="carousel-item active">
                                    <img src="/img/event1.png" class="d-block w-100" alt="...">
                                  </div>
                                  <div class="carousel-item">
                                    <img src="/img/event2.jpg" class="d-block w-100" alt="...">
                                  </div>
                                  <div class="carousel-item">
                                    <img src="/img/event3.png" class="d-block w-100" alt="...">
                                  </div>
                                </div>
                                <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleControls" data-bs-slide="prev">
                                  <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                                  <span class="visually-hidden">Previous</span>
                                </button>
                                <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleControls" data-bs-slide="next">
                                  <span class="carousel-control-next-icon" aria-hidden="true"></span>
                                  <span class="visually-hidden">Next</span>
                                </button>
                              </div>
                        </div>

                        <div class="col-md-6 w-50">
                            <div class="card text-bg-light card-overlay-bottom card-grid-sm card-bg-scale">
                                <img src="/img/ad.jpg" class="card-img" alt="...">
                                <div class="d-flex align-items-center">
                                  <!--<h5 class="card-title">Card title</h5>-->
                                </div>
                              </div>
                        </div>

                        <div class="col-md-6 w-50 btn">
                            <div class="card text-bg-dark card-overlay-bottom card-grid-sm card-bg-scale" onclick="location.href='/information'">
                                <img src="/img/map.png" class="card-img" alt="...">
                                <div class="d-flex align-items-center">
                                    <!--<h5 class="card-title">지도보기</h5>-->
                                </div>
                              </div>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </section>
    <section class="position-relative pt-lg-5">
        <div class="container">
            <div class="row">
                <div class="col">
                    <a href="#" class="nav-link">
                        <h4 class="text-reset fw-bold border-dark pb-lg-2 border-bottom">자유게시판</h4>
                    </a>
                    <ul class="position-relative" style="list-style: none; padding: 0;">
                         <!-- 자유게시판 리스트 -->
                    </ul>
                </div>
                <div class="col">
                    <a href="#" class="nav-link">
                        <h4 class="text-reset fw-bold border-dark pb-lg-2 border-bottom">반려자랑</h4>
                    </a>
                    <ul class="position-relative" style="list-style: none; padding: 0;">
                        <!-- 반려자랑 리스트 -->
                    </ul>
                </div>
            </div>

            <div class="row">
                <div class="col">
                    <a href="#" class="nav-link">
                        <h4 class="text-reset fw-bold border-dark pb-lg-2 border-bottom">질문게시판</h4>
                    </a>
                    <ul class="position-relative" style="list-style: none; padding: 0;">
                         <!-- 자유게시판 리스트 -->
                    </ul>
                </div>
                <div class="col">
                    <a href="#" class="nav-link">
                </div>
                
            </div>
        </div>
    </section>


    
</body>
</html>