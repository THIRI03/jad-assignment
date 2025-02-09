/*Name: Thiri Lae Win
	Class: DIT/FT/2A/23
	ADM Num: 2340739*/
package com.cleanerThirdParty.model;

public class Cleaner {

	private int id;
	private String email;

	public Cleaner() {

	}

	public Cleaner(int id, String email){
		this.id = id;
		this.email = email;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}
}
