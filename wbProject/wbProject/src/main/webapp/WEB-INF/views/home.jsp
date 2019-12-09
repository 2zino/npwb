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
		<div id='test1'>
			  <select v-model="selected">
			    <option value="none">Please select one</option>
			    <option value="BC">구약</option>
			    <option value="AD">신약</option>
			  </select>
			  <span>Selected: {{ selected }}</span>
			  
			<div>
				<div v-if= "selected == 'BC'">
					<span>BC</span>
					  <select v-model="selected">
					   		<option v-for="item in items">
								{{item}}
							</option>
					  </select>
				</div>
				<div v-else-if= "selected == 'AD'">
					<span>AD</span>
						<select v-model="selected">
					   		<option v-for="item in items">
					   		<span  v-if ="item.TYPE =='AD' && item.VERSE =='1'">
								{{item.GOSPEL}}
							</span>
							</option>
					  </select>
				</div>
			</div>		 
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
	  }
	});
//vue 인스턴스는 한개만 선언해서 사용해야함 .. !! 

</script>