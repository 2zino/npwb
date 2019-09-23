<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ page session="false" %>

<sql:query var="rs" dataSource="jdbc/npwbDB">
select CONTENTS from mysql.TB_BIBLE where seq = '17772'
</sql:query>

<html>
<head>
	<title>DB Test</title>
</head>
<body>
<h1>
	Hello world!  
</h1>

  <h2>Results</h2>

<c:forEach var="row" items="${rs.rows}">
     ${row.CONTENTS}<br/>
</c:forEach>

<P>  The time on the server is ${serverTime}. </P>
<P> deploy test ! </P>
</body>
</html>









  </body>
</html>
