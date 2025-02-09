/*Name: Thiri Lae Win
	Class: DIT/FT/2A/23
	ADM Num: 2340739*/
package com.cleaningService.model;

public class Feedback {
	private int id;
	private String comments;
	private int booking_id;
	private String username;
	private String serviceName;
	private int rating;

	public Feedback() {

	}

	public Feedback(int id, String comments, int booking_id, String username, String serviceName, int rating) {
		this.id = id;
		this.comments = comments;
		this.booking_id = booking_id;
		this.username = username;
		this.serviceName = serviceName;
		this.rating = rating;
	}



	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getComments() {
		return comments;
	}

	public void setComments(String comments) {
		this.comments = comments;
	}

	public int getBooking_id() {
		return booking_id;
	}

	public void setBooking_id(int booking_id) {
		this.booking_id = booking_id;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getServiceName() {
		return serviceName;
	}

	public void setServiceName(String serviceName) {
		this.serviceName = serviceName;
	}

	public int getRating() {
		return rating;
	}

	public void setRating(int rating) {
		this.rating = rating;
	}




}
