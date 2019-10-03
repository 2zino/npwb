package com.wb.hb.bible.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import com.wb.hb.bible.model.Bible;

public class JdbcBibleDAO implements BibleDAO {
	
	public Bible findByBibleId(int bibleId){
		
		String sql = "SELECT * FROM mysql.TB_BIBLE WHERE SEQ = ?";
		
		Connection conn = null;

		Bible bible = null;
		
		
		try {
			Context initCtx = new InitialContext();
			Context envCtx = (Context)initCtx.lookup("java:comp/env");
			DataSource ds = (DataSource)envCtx.lookup("jdbc/npwbDB");

			conn = ds.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1, bibleId);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				bible = new Bible(
						rs.getString("contents")
				);
			}
			rs.close();
			ps.close();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (conn != null) {
				try {
				conn.close();
				} catch (SQLException e) {}
			}
		}
		return bible;
	}
}
