package com.wb.hb;

import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;


import com.wb.hb.bible.dao.BibleDAO;
import com.wb.hb.bible.model.Bible;
import com.mysql.jdbc.Connection;
import com.mysql.jdbc.Statement;


/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/main.do", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		
		//test
    	ApplicationContext context = 
        		new ClassPathXmlApplicationContext("Spring-Module.xml");
        	 
            BibleDAO bibleDAO = (BibleDAO) context.getBean("bibleDAO");
            
            Bible bible = bibleDAO.findByBibleId(17772);
            System.out.println(bible);
		
		
		return "home";
	}
	
	@RequestMapping(value = "/main2.do", method = RequestMethod.GET)
	public String home2(Locale locale, Model model) throws ClassNotFoundException, SQLException {
		logger.info("hi");
		
		java.sql.Connection con= null;
		java.sql.Statement stmt = null;
		ResultSet rset = null;
		String url="jdbc:mysql://106.10.53.202:3306/mysql";
		String query=null;
		
		Class.forName("com.mysql.jdbc.Driver");
		con = DriverManager.getConnection(url,"root","qwer1234");
		stmt = con.createStatement();
		query="select CONTENTS from mysql.TB_BIBLE where seq = '17772'";
		rset = stmt.executeQuery(query);
		
		while(rset.next()) {
			System.out.println("ㅇㅇㅇㅇ");
		}
		logger.info("bye");
		
		return "home";
	}
	
}
