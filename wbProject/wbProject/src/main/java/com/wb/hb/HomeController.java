package com.wb.hb;

import java.sql.SQLException;
import java.text.DateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.wb.hb.bible.dao.testDao;
import com.wb.hb.common.SessionFactory;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {

	@Autowired
	private testDao dao;
	
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
		/*
			JdbcBibleDAO jdbcbibledao = new JdbcBibleDAO();
            Bible bible = jdbcbibledao.findByBibleId(17772);
            System.out.println(bible.toString());
		*/
		SessionFactory sf = new SessionFactory();
		sf.session();
		
		return "home";
	}
	
	@RequestMapping(value = "/main2.do", method = RequestMethod.GET)
	public String home2(Locale locale, Model model) throws ClassNotFoundException, SQLException {
		
		List<HashMap<String,String>> sqlTest = dao.getGospe();
		System.out.println("##################################################");
		System.out.println(sqlTest.toString());
		System.out.println("##################################################");
		return "home";
		
		
	}
	
}
