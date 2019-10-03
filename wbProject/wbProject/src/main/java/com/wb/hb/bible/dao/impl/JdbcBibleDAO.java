package com.wb.hb.bible.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.sql.DataSource;
import com.wb.hb.bible.dao.BibleDAO;
import com.wb.hb.bible.model.Bible;

public class JdbcBibleDAO implements BibleDAO {

	
private DataSource dataSource;
	
	public void setDataSource(DataSource dataSource) {
		this.dataSource = dataSource;
	}
	
	public Bible findByBibleId(int bibleId){
		
		String sql = "SELECT * FROM mysql.TB_BIBLE WHERE SEQ = ?";
		
		Connection conn = null;
		
		try {
			conn = dataSource.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1, bibleId);
			Bible bible = null;
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				bible = new Bible(
						rs.getString("contents")
				);
			}
			rs.close();
			ps.close();
			return bible;
		} catch (SQLException e) {
			throw new RuntimeException(e);
		} finally {
			if (conn != null) {
				try {
				conn.close();
				} catch (SQLException e) {}
			}
		}
	}
}
