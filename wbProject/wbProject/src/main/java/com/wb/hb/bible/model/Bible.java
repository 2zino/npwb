package com.wb.hb.bible.model;

import java.sql.Timestamp;

public class Bible {
	
	int bibleID;
	String contents;

	public Bible(String a){
		this.contents = a;	
	}
	
	public int getBibleID() {
		return bibleID;
	}

	public void setBibleID(int bibleID) {
		this.bibleID = bibleID;
	}

	public String getContents() {
		return contents;
	}

	public void setContents(String contents) {
		this.contents = contents;
	}

	
}