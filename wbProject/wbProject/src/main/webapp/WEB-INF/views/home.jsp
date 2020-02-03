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
	
	    <title>Welcome to WB BIBLE!</title>
	<!-- 굳이 . . 
	    <meta name="description" content="Source code generated using layoutit.com">
	    <meta name="author" content="LayoutIt!">
	 -->
	    <link href="css/bootstrap.min.css" rel="stylesheet">
	    <link href="css/style.css" rel="stylesheet">

		<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
		<script src="http://code.jquery.com/jquery-1.11.2.min.js"></script>
	    <script src="js/jquery.min.js"></script>
	    <script src="js/bootstrap.min.js"></script>
    	<script src="js/scripts.js"></script>
	</head>
	
	<body>
	
	
    <div class="container-fluid" id='test1'>
	<div class="row">
		<div class="col-md-12">
			<h3 class="text-center">
				Holy Bible
			</h3>
		</div>
	</div>

	<div class="row">
		<div class="col-md-3">
			<div class="dropdown">
				<button class="btn btn-primary dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown">
				구약
				</button>
				<div class="dropdown-menu" aria-labelledby="dropdownMenuButton" >
					 <a  class="dropdown-item" value = 'BC' v-on:click = select("BC")>구약</a> 
					 <a class="dropdown-item" vaule = 'AD' v-on:click =select("AD")>신약</a>
				</div>
			</div>
		</div>
		<div class="col-md-3">
			<div class="dropdown">
				 
				<button class="btn btn-primary dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown">
					창세기
				</button>
				<div class="dropdown-menu" id ='Gospel' aria-labelledby="dropdownMenuButton" >
					 <a v-for ="item in items" v-show ='isGospel(item) !=null'class="dropdown-item" v-on:click = "selectGospel(isGospel(item))">{{ isGospel(item)  }}</a>
				</div>
			</div>
		</div>
		<div class="col-md-3">
			<div class="dropdown">
				 
				<button class="btn btn-primary dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown">
					1
				</button>
				<div class="dropdown-menu" id = 'Chapter' aria-labelledby="dropdownMenuButton">
					 <a v-for ="item in items" v-show = 'isChapter(item) != null'class="dropdown-item" v-on:click = "selectChapter(isChapter(item))">{{ isChapter(item)  }}</a>
				</div>
			</div>
		</div>
		<div class="col-md-3">
			 
			<button type="button" v-on:click="search" class="btn btn-md btn-primary">
				Button
			</button>
		</div>
	</div>
	<div class="row">
		<div class="col-md-12">
			<div class="page-header">
				<h1>
					창세기 <small>11장</small>
				</h1>
			</div>
		</div>
	</div>
	<div class="row">
		<div class="col-md-1">
			 <span v-on:click = 'before'class="badge badge-default">이전</span>
		</div>
		<div class="col-md-10">
			<p v-for = "verse in verses" >
			{{ isContents(verse) }}
			</p>
		</div>
		<div class="col-md-1">
			 <span v-on:click="next" class="badge badge-default">다음</span>
		</div>
	</div>
	</div>
  </body>
</html>
<script>
var totalList=${totalList};
var vm1 = new Vue({
	 el: '#test1',
	  data: {
	    type: '',
	    items:totalList,
	    chapter:'',
	    verseLength:'',
	    gospel:'',
	    verses:''
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
					return item.CHAPTER;
				}
				return null;
			},
			isContents :function(verse){
					var contents ="";
					contents = verse.VERSE+"."+ verse.CONTENTS+" "
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
				this.chapter=Number(this.chapter)-1;

				search();
			},
			next : function(){
				this.chapter=Number(this.chapter)+1;
				search();
			},
			select : function(selected){
				this.type = selected;
			},
			selectGospel : function(selected){
				this.gospel = selected;
			},
			selectChapter : function(selected){
				this.chapter = selected;
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