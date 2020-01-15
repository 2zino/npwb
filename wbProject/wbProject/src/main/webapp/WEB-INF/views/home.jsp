<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ page session="false" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<script src="js/vue.js"></script>


<html>
	<head>
		
		<title>DB Test</title>
		<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
		<script src="http://code.jquery.com/jquery-1.11.2.min.js"></script>
	</head>
	
	<body>
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