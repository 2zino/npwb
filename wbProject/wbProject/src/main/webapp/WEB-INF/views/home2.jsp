<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ page session="false" %>
<script src="js/vue.js"></script>

<html>
	<head>
		<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script><!-- 개발자용 콘솔 추가 버전 -->
		<title>vue Test</title>
	</head>
	<body>
		<div id="gsp">
			<ol>
				<li v-for="item in items">
					{{item.GOSPEL}}
				</li>
			</ol>
		</div>
		
		
	</body>
</html>
<script>

	var gospelList=${gospelList};
	console.log(gospelList);
	var gsp=new Vue({
		el :'#gsp',
		data:{
			items:gospelList
		}
	})

</script>