<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ page session="false" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>

<!-- Global site tag (gtag.js) - Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=UA-168903909-1"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<script src="http://code.jquery.com/jquery-1.11.2.min.js"></script>
<script src="http://www.atlasestateagents.co.uk/javascript/tether.min.js"></script> <!-- Bootstrap tooltips require Tether 오류 수정 -->
<script src="js/jquery.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/scripts.js"></script>
    	
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', 'UA-168903909-1');
</script>

<script type="text/javascript">
	//주소창 숨기기
	window.onload = function() {
	    setTimeout(function() {
	        window.scrollTo(0, 1);}, 100);
	};
	
	var last_top=0;
	$(window).scroll(function(){
		var this_top=$(this).scrollTop();
		if(this_top>last_top){
			//$(".lbNav").addClass("hide");
			$('.lbNav').css({'-webkit-transform':'-webkit-translateY(-56px)','transform':'translateY(-56px)'});
		}else{
			//$(".lbNav").removeClass("hide");
			$('.lbNav').css({'-webkit-transform':'-webkit-translateY(0)','transform':'translateY(0)'});
		}
		last_top=this_top;
	})
	
</script>

<html>
	<head>
		<meta name="apple-mobile-web-app-capable" content="yes" />
		<meta charset="utf-8">
	    <meta http-equiv="X-UA-Compatible" content="IE=edge">
	    <meta name="viewport" content="width=device-width, initial-scale=1">	
	    <title>Welcome to LIGHT BIBLE!</title>
	    <link href="css/bootstrap.min.css" rel="stylesheet">
	    <link href="css/style.css" rel="stylesheet">
		
    	<style>
			@import url('https://fonts.googleapis.com/css2?family=Nanum+Gothic:wght@400;700;800&family=Nanum+Myeongjo:wght@400;700;800&display=swap');
			.nn-gothic4{
				font-family: 'Nanum Gothic', sans-serif;
				font-weight: 400;
			}
			.nn-gothic7{
				font-family: 'Nanum Gothic', sans-serif;
				font-weight: 700;
			}
			.nn-gothic8{
				font-family: 'Nanum Gothic', sans-serif;
				font-weight: 800;
			}
			.nn-myeongjo4{
				font-family: 'Nanum Myeongjo', serif;
				font-weight: 400;			
			}
			.nn-myeongjo7{
				font-family: 'Nanum Myeongjo', serif;
				font-weight: 700;			
			}
			.nn-myeongjo8{
				font-family: 'Nanum Myeongjo', serif;
				font-weight: 800;			
			}
		</style>
	</head>
	
	<body>
	
	
    <div class="container-fluid" id='bible'>
	<div class="lbNav" style ="align :center; background : #266855;">
		<!--  <div class="col-4" style = "text-align: center; vertical-align:text-bottom; padding-top: 0.3rem;">
			<a href="http://106.10.53.202:8080/wbProject/main.do"><img src="./img/logo.jpg" width="100%"></a>
		</div>-->
		<div class="col-12" style = "text-align: center; vertical-align: middle;display: table-cell; padding-top: 0.3rem;">
			<div class=	"dropdown">
				<button class="btn btn-primary dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown" text =''>
					<span v-if = "type =='' || type =='BC'">구약</span><span v-else>신약</span>
				</button>
				<div class="dropdown-menu" aria-labelledby="dropdownMenuButton" >
					 <a  class="dropdown-item" value = 'BC' v-on:click = select("BC")>구약</a> 
					 <a class="dropdown-item" vaule = 'AD' v-on:click = select("AD")>신약</a>
				</div>
			</div>
			<div class="dropdown" style="float:left;">
				 
				<button class="btn btn-primary dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown">
					<span v-if = "gospel ==''">창세기</span><span v-else>{{ gospel }}</span>
				</button>
				<div class="dropdown-menu" id ='Gospel' aria-labelledby="dropdownMenuButton" >
					 <a v-for ="item in items" v-show ='isGospel(item) !=null'class="dropdown-item" v-on:click = "selectGospel(isGospel(item))">{{ isGospel(item)  }}</a>
				</div>
			</div>
			<div class="dropdown" style="float:left;">
				<button class="btn btn-primary dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown">
					<span v-if = "chapter ==''">1</span><span v-else>{{ chapter }}</span>
				</button>
				<div class="dropdown-menu" id = 'Chapter' aria-labelledby="dropdownMenuButton">
					 <a v-for ="item in items" v-show = 'isChapter(item) != null'class="dropdown-item" v-on:click = "selectChapter(isChapter(item))">{{ isChapter(item)  }}</a>
				</div>
			</div>
		</div>
<!--  		<div class="col-3">	 
			<button type="button" v-on:click="search" class="btn btn-md btn-primary">
				<span>찾기</span>
			</button>
		</div>
-->
	</div>
	<div class="row">
		<div class="col-md-12">
			<div class="page-header" style = "border-bottom: 1px solid #266855; ">
				<p class='nn-gothic7' style ="margin-top: 0.5rem; margin-bottom: 0rem; text-align: left; font-size:1.8em" v-if ="chapter ==''"></p>
				<p class='nn-gothic7' style ="letter-spacing: 2px; margin-left: 0.3rem; margin-bottom: 0rem; text-align: left; font-size:1.8em" v-if ="chapter != ''">{{ gospel }} <small class='nn-gothic4' v-if ="chapter != ''">{{ chapter }}장</small></p>
			</div>
		</div>
	</div>
		<div class="col-md-10" style = "padding-top : 1.5rem;">
			<p v-for = "verse in verses" v-bind:style="{ fontSize: fontSize + 'rem'}">
				<span style='font-size:0.9em;' class='nn-myeongjo4' v-html = 'isContents(verse)' ></span>
			</p>
		</div>
	<div>
		<div class="col-md-auto" style = "border-top: 1px solid #266855; padding-bottom : 2rem; padding-top:0.5rem ">
		<center>
			<span v-on:click="fontSize < 0.5? fontSize = 0.25: fontSize -= 0.25" class="badge badge-pill"> - </span><img src="./img/text.jpg" width="20rem"><span v-on:click="fontSize += 0.25" class="badge badge-pill"> + </span>
			<span v-on:click = 'before'class="badge badge-pill"> < </span><img src="./img/book.jpg" width="20rem"><span v-on:click="next" class="badge badge-pill"> > </span>
		</center>
		</div>
	</div>
	</div>
  </body>
</html>
<script>
var totalList=${totalList};
var type = '${type}';
var gospel = '${gospel}'
var chapter = '${chapter}'
var contents = ${contents}
var vm1 = new Vue({
	 el: '#bible',
	  data: {
	    type: type,
	    items: totalList,
	    chapter: chapter,
	    gospel: gospel,
	    verses: contents,
	    fontSize: 1,
	    chapterSize: ''
	  },
		methods:{
			isGospel : function(item){
				if('' == this.type){
					return null;
				}else if(item.CHAPTER == '1' && item.TYPE == this.type){
					return item.GOSPEL;
				}
				return null;
			},
			isChapter :function(item){
				if(''==this.type || ''==this.gospel){
					return null;
				}else if(item.TYPE == this.type && item.GOSPEL == this.gospel){
					this.chapterSize = item.CHAPTER;
					return item.CHAPTER;
				}
				return null;
			},
			isContents :function(verse){
					var contents ="";
					contents = "<span class='text-num'>"+verse.VERSE+'</span>'+" "+ verse.CONTENTS+" "
					return contents;
			},
			/*
			isVerse :function(){
				for(let i=0;i<this.items.length;i++){
					let item = this.items[i];
					if(''==this.type || ''==this.gospel || ''==this.chapter){
						this.verseLength = 0;
					}else if(item.TYPE == this.type && item.GOSPEL == this.gospel && item.CHAPTER==this.chapter){
						this.verseLength = item.VERSE;
						return;
					}
					this.verseLength = 0;	
				}
			},*/
			search : function(){
				search();
			},
			before : function(){
				if(this.chapter > 1){
					this.chapter = Number(this.chapter)-1;
					search();
					$('html, body').stop().animate({scrollTop: 0}, 1000);
				}
			},
			next : function(){
				
				if(Number(this.chapterSize) > Number(this.chapter)){
					this.chapter= Number(this.chapter)+1;
					search();
					$('html, body').stop().animate({scrollTop: 0}, 1000);
				}
			},
			select : function(selected){
				this.type = selected;
				this.gospel = '';
				this.chapter = '';
			},
			selectGospel : function(selected){
				this.gospel = selected;
				if(this.chapter !='' ){
					this.chapter = '';
					}
				
			},
			selectChapter : function(selected){
				this.chapter = selected;
				search();
			}
		}
	});
		
	function search(){
		$.ajax({
			url:'/wbProject/getBible.do',
			type:'POST',
			dataType:"json",
			data :{
				"TYPE": vm1.type,
				"GOSPEL":vm1.gospel,
				"CHAPTER":vm1.chapter
			},
			error:function(){
				vm1._data.verses="error";
			},
			success:function(data){
				vm1._data.verses = data;
			}
		});
	}
</script>