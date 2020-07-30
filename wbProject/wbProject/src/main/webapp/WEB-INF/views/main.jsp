<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ page session="false" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>

<!-- Global site tag (gtag.js) - Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=UA-168903909-1"></script>
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
</script>

<html>
	<form method = 'POST' id = 'mainData'>
		<input type='hidden' name="type" id="type" value = ""/>
	    <input type='hidden' name="gospel" id="gospel" value = ""/>
	    <input type='hidden' name="chapter" id="chapter" value = ""/>
	    <input type='hidden' name="totalList" id="totalList" value = "${totalList}"/>
	</form>
	<head>
		<meta charset="utf-8">
	    <meta http-equiv="X-UA-Compatible" content="IE=edge">
	    <meta name="viewport" content="width=device-width, initial-scale=1">	
	    <title>Welcome to LIGHT BIBLE!</title>
	    <link href="css/bootstrap.min.css" rel="stylesheet">
	    <link href="css/style.css" rel="stylesheet">
		<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
		<script src="http://code.jquery.com/jquery-1.11.2.min.js"></script>
	    <script src="js/jquery.min.js"></script>
	    <script src="js/bootstrap.min.js"></script>
    	<script src="js/scripts.js"></script>
    	
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
		
		<div class="col-md-20" style = "padding-top: 10rem; ">
			<div class="col-6" style = "margin-left :auto; margin-right:auto;">
				<a href="http://106.10.53.202:8080/wbProject/main.do"><img src="./img/logo.jpg" width="100%"></a>
			</div>
			<center>
				<div class="col-12" style = "display: table-cell; padding-top: 1.5rem; margin-left :auto; margin-right:auto;">
					<div class="search-bar">
						<div class="dropdown">
							<button class="btn-main dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown" text =''>
								<span v-if = "type =='' || type =='BC'">구약</span><span v-else>신약</span>
							</button>
							<div class="dropdown-menu" aria-labelledby="dropdownMenuButton" >
								 <a  class="dropdown-item" value = 'BC' v-on:click = select("BC")>구약</a> 
								 <a class="dropdown-item" vaule = 'AD' v-on:click = select("AD")>신약</a>
							</div>
						</div>
						<div class="dropdown" style="float:left;">
							 
							<button class="btn-main dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown">
								<span v-if = "gospel ==''">창세기</span><span v-else>{{ gospel }}</span>
							</button>
							<div class="dropdown-menu" id ='Gospel' aria-labelledby="dropdownMenuButton" >
								 <a v-for ="item in items" v-show ='isGospel(item) !=null'class="dropdown-item" v-on:click = "selectGospel(isGospel(item))">{{ isGospel(item)  }}</a>
							</div>
						</div>
						<div class="dropdown" style="float:left;">
							<button class="btn-main dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown">
								<span v-if = "chapter ==''">1</span><span v-else>{{ chapter }}</span>
							</button>
							<div class="dropdown-menu" id = 'Chapter' aria-labelledby="dropdownMenuButton">
								 <a v-for ="item in items" v-show = 'isChapter(item) != null'class="dropdown-item" v-on:click = "selectChapter(isChapter(item))">{{ isChapter(item)  }}</a>
							</div>
						</div>
						<div v-on:click="search" class="btn-main-search"><img src="./img/search.jpg" width="100%"></div>
					</div>
				</div>
			</center>
		</div>
	<div>
	</div>
	</div>
  </body>
</html>
<script>
var totalList=${totalList};
var vm1 = new Vue({
	 el: '#bible',
	  data: {
	    type: 'BC',
	    items: totalList,
	    chapter: '1',
	    gospel: '창세기',
	    verses: '',
	    fontSize: 1,
	    chapterSize: ''
	  },
		methods:{
			isGospel : function(item){
				//console.log(item);
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
			search : function(){
				search();
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
				//search();
			}
		}
	});
		
	function search(){
		var url = '/wbProject/home.do';
		$("#type").attr("value" , vm1.type);
		$("#gospel").attr("value" , vm1.gospel);
		$("#chapter").attr("value" , vm1.chapter);

		//console.log("vm1.items : "+vm1.items);
		$("#mainData").attr({action:url, method:'post'}).submit();
	}
</script>