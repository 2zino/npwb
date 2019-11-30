<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ page session="false" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<script src="js/vue.js"></script>
<script>
new Vue({
	el: '#app',
	data: {
		posts: []
	},
	created() {
		fetch('/selectDataList.do')
			.then((response) => {
				if(response.ok) {
					return response.json();
				}
			
				throw new Error('Network response was not ok');
			})
			.then((json) => {
				this.posts.push({
					type: $("select[name=type]").value
				});
			})
			.catch((error) => {
				console.log(error);
			});
	}
});

</script>
<html>
	<head>
		<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script><!-- 개발자용 콘솔 추가 버전 -->
		<title>DB Test</title>
	</head>
<body>

<form id='app'>
  <select name="type" >
    <option value="none">=== 선택 ===</option>
    <option value="BC">구약</option>
    <option value="AD">신약</option>
  </select>
</form>

<form>
  <select name="gospel" >
    <option value="none">=== 선택 ===</option>
  </select>
</form>

<form>
  <select name="chapter" >
    <option value="none">=== 선택 ===</option>
  </select>
</form>

<form>
  <select name="verse" >
    <option value="none">=== 선택 ===</option>
  </select>
</form>


  </body>
</html>
