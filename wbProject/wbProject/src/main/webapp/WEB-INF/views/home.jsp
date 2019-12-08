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
		</div>

  </body>
</html>
<script>
new Vue({
	 el: '#test1',
	  data: {
	    selected: ''
	  }
	});
	
</script>