package com.cleaningService.model;

public class Booking {
	private int id;
	private String serviceName;
	private String specialRequest;
	private String customerName;
	private int duration;
	private String date;
	private String time;
	private String categoryName;
	
	public Booking() {
		
	}
	


	public Booking(int id, String serviceName, String specialRequest, String customerName, int duration, String date,
			String time, String categoryName) {
		this.id = id;
		this.serviceName = serviceName;
		this.specialRequest = specialRequest;
		this.customerName = customerName;
		this.duration = duration;
		this.date = date;
		this.time = time;
		this.categoryName = categoryName;
	}



	public String getCategoryName() {
		return categoryName;
	}



	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}



	public String getServiceName() {
		return serviceName;
	}



	public void setServiceName(String serviceName) {
		this.serviceName = serviceName;
	}



	public String getCustomerName() {
		return customerName;
	}



	public void setCustomerName(String custerName) {
		this.customerName = custerName;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getSpecialRequest() {
		return specialRequest;
	}

	public void setSpecialRequest(String specialRequest) {
		this.specialRequest = specialRequest;
	}

	public int getDuration() {
		return duration;
	}

	public void setDuration(int duration) {
		this.duration = duration;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public String getTime() {
		return time;
	}

	public void setTime(String time) {
		this.time = time;
	}
}
