<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ page session="false" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>

<sql:query var="rs" dataSource="jdbc/mysql">
select CONTENTS from mysql.TB_BIBLE where seq = '17772'
</sql:query>

<html>
<head>
	<title>DB Test</title>
</head>
<body>
<%
Context initCtx = new InitialContext();
Context envCtx = (Context)initCtx.lookup("java:comp/env");
DataSource ds = (DataSource)envCtx.lookup("jdbc/npwbDB");

Connection conn = ds.getConnection();
out.println("conn = >" + conn);

conn.close();

%>
</body>
</html>









  </body>
</html>
