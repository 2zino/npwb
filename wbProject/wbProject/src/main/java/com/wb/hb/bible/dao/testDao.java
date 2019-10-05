package com.wb.hb.bible.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class testDao {

	@Autowired
	SqlSession sql;
	
	public List<HashMap<String,String>> getGospe() {
		HashMap<String,String> input = new HashMap<String, String>();
		input.put("version", "새번역");
		input.put("type", "AD");
		return sql.selectList("sqlBibleMapper.selectGospel",input);	
	}
	
}
