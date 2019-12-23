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
			<div>{{verse}}</div>
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
	    verse:'abcd'
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
				//ajax해줍쇼 ....
				$.ajax({
					url:'/wb/getBible.do',
					type:'POST',
					dataType:"json",
					data :{
						"TYPE":this.type,
						"GOSPEL":this.gospel,
						"CHAPTER":this.chapter
					},
					error:function(){
						vm1._data.verse="error";
					},
					success:function(data){
						vm1._data.verse=data;
					}
				});
			}
		}
	});
</script>