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
	</head>
	
	<body>
		<!-- TYPE 신약/구약 -->
		<div id='test1'>
			  <select v-model="selected">
			    <option value="BC">구약</option>
			    <option value="AD">신약</option>
			  </select>
		<!-- GOSPEL 복음서 -->
				<select id='Gospel'>
			   		<option v-if= "selected == 'BC'" v-for="item in items" v-show ='isBCGospel(item) != null'>
			   			{{ isBCGospel(item) }}
					</option>
					<option v-if= "selected == 'AD'" v-for="item in items" v-show ='isADGospel(item) != null'>
			   			{{ isADGospel(item) }}
					</option>
			  </select>
		<!-- CHAPTER 장 -->	  
			  <select>
			  		<option value =''> </option>
				  	<option>
				  	{{ isChapter() }}
					</option>
			  </select>
	</div>		 

  </body>
</html>
<script>
var totalList=${totalList};
new Vue({
	 el: '#test1',
	  data: {
	    selected: '',
	    items:totalList
	  },
		methods:{
			isADGospel : function(item){
				if(item.CHAPTER === '1' && item.TYPE === 'AD'){
					//console.log('item.CHAPTER : '+item.CHAPTER + ' item.TYPE : '+item.TYPE + ' item.GOSPEL : '+ item.GOSPEL);
					return item.GOSPEL;
				}
				return null;
			},
			isBCGospel :function(item){
				if(item.CHAPTER === '1' && item.TYPE === 'BC'){
					//console.log('item.CHAPTER : '+item.CHAPTER + ' item.TYPE : '+item.TYPE + ' item.GOSPEL : '+ item.GOSPEL);
					return item.GOSPEL;
				}
				return null;
			},
			isChapter :function(item){
				var i;
				console.log(item);		
				//if()
				//for(i=1; i<totalList.VERSE+1;i++)
				//	return i;
				//}
			}
		}
	});
//vue 인스턴스는 한개만 선언해서 사용해야함 .. !! 

</script>