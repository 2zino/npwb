<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ page session="false" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>


<html>
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
	</head>
	
	<body>
	
	
    <div class="container-fluid" id='bible'>
	<div class="row">
		<div class="col-4" style = "text-align: center;">
			<a href="http://106.10.53.202:8080/wbProject/main.do"><img src="./img/logo.jpg" width="100%"></a>
		</div>
		<div class="col-8" style = "text-align: center; vertical-align: middle;display: table-cell;	">
			<div class="dropdown">
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
			<div class="page-header">
				<h2 style ="margin-top: 0.5rem; margin-bottom: 0rem" v-if ="chapter != ''">{{ gospel }} <small v-if ="chapter != ''">{{ chapter }}장</small></h2>
			</div>
		</div>
	</div>
	<hr class = 'line'> <!-- line추가 -->
	<div class="row2">
		<div class="col-1">
			 <span v-on:click = 'before'class="badge badge-default">이전</span>
		</div>
		<div class="col-md-10">
			<p v-for = "verse in verses" v-bind:style="{ fontSize: fontSize + 'rem' }">
				<span v-html = 'isContents(verse)' ></span>
			</p>
		</div>
		<div class="col-md-1">
			 <span v-on:click="next" class="badge badge-default">다음</span>
		</div>
	</div>
	<hr class = 'line'> <!-- line추가 -->
	<div sytle ="text-align : left">
		<div class="col-md-auto">
			<span v-on:click="fontSize < 0.5? fontSize = 0.25: fontSize -= 0.25" class="badge badge-default">-</span>글자크기조절<span v-on:click="fontSize += 0.25" class="badge badge-default">+</span>
		</div>
	</div>
	</div>
  </body>
</html>
<script>
var totalList=${totalList};
var vm1 = new Vue({
	 el: '#bible',
	  data: {
	    type: '',
	    items:totalList,
	    chapter:'',
	    gospel:'',
	    verses:'',
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
				if(this.chapter>1){
					this.chapter=Number(this.chapter)-1;
					search();
				}
			},
			next : function(){
				if(this.chapterSize > this.chapter){
					this.chapter=Number(this.chapter)+1;
					search();
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
				"TYPE":vm1.type,
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