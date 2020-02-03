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
				h3. Lorem ipsum dolor sit amet.
			</h3>
		</div>
	</div>
	<div class="row">
		<div class="col-md-5">
			<div class="row">
				<div class="col-md-3">
					<div class="dropdown">
						 
						<button class="btn btn-primary dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown"  v-model="type">
							구약
						</button>
						<div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
							 <a class="dropdown-item disabled" href="#">구약</a> <a class="dropdown-item" href="#">신약</a>
						</div>
					</div>
				</div>
				<div class="col-md-3">
					<div class="dropdown">
						 
						<button class="btn btn-primary dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown">
							Action
						</button>
						<div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
							 <a class="dropdown-item disabled" href="#">Action</a> <a class="dropdown-item" href="#">Another action</a> <a class="dropdown-item" href="#">Something else here</a>
						</div>
					</div>
				</div>
				<div class="col-md-3">
					<div class="dropdown">
						 
						<button class="btn btn-primary dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown">
							Action
						</button>
						<div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
							 <a class="dropdown-item disabled" href="#">Action</a> <a class="dropdown-item" href="#">Another action</a> <a class="dropdown-item" href="#">Something else here</a>
						</div>
					</div>
				</div>
				<div class="col-md-3">
					 
					<button type="button" class="btn btn-md btn-primary">
						Button
					</button>
				</div>
			</div>
		</div>
		<div class="col-md-7">
			<div class="page-header">
				<h1>
					LayoutIt! <small>Interface Builder for Bootstrap</small>
				</h1>
			</div>
		</div>
	</div>
	<div class="row">
		<div class="col-md-1">
			 <span class="badge badge-default">Label</span>
		</div>
		<div class="col-md-10">
			<p>
				Lorem ipsum dolor sit amet, <strong>consectetur adipiscing elit</strong>. Aliquam eget sapien sapien. Curabitur in metus urna. In hac habitasse platea dictumst. Phasellus eu sem sapien, sed vestibulum velit. Nam purus nibh, lacinia non faucibus et, pharetra in dolor. Sed iaculis posuere diam ut cursus. <em>Morbi commodo sodales nisi id sodales. Proin consectetur, nisi id commodo imperdiet, metus nunc consequat lectus, id bibendum diam velit et dui.</em> Proin massa magna, vulputate nec bibendum nec, posuere nec lacus. <small>Aliquam mi erat, aliquam vel luctus eu, pharetra quis elit. Nulla euismod ultrices massa, et feugiat ipsum consequat eu.</small>
			</p>
		</div>
		<div class="col-md-1">
			 <span class="badge badge-default">Label</span>
		</div>
	</div>
	</div>
	
	
	
	
	
		<!-- TYPE 신약/구약 -->
		<div id='test1'>
				<div id='menu'>
					<select v-model="type">
						<option value="BC">구약</option>
					    <option value="AD">신약</option>
					</select>
					<!-- GOSPEL 복음서 -->
					<select id='Gospel' v-model="gospel">
						<option v-for="item in items" v-show ='isGospel(item) != null'>
							{{ isGospel(item) }}
						</option>
					</select>
					<!-- CHAPTER 장 -->	  
					<select id='Chapter' v-model="chapter"> <!-- v-on:change="isVerse()"> --> 
						<option v-for="item in items" v-show ='isChapter(item) != null'>
					 		{{ isChapter(item) }}
						</option>
					</select>
					<!-- VERSE 절 -->	  
					<!-- 
					<select id='Verse' v-model = "verse">
						<option v-for="i in verseLength" v-on:change="selVerse()" >
							{{i}}
						</option>
					</select>
					 -->
					<button v-on:click="search">찾기</button>
				 </div>
				<div>
				<div style="width:11%;float:left" v-on:click="before">이전</div>
				<div style="width:78%;float:left">
					<div v-for="verse in verses"> {{ isContents(verse) }}</div>
				</div>
				<div style="width:11%;float:left" v-on:click="next">다음</div>
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