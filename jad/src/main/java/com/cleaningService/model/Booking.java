/*Name: Thiri Lae Win
	Class: DIT/FT/2A/23
	ADM Num: 2340739*/
package com.cleaningService.model;

public class Booking {
	private int id;
	private String serviceName;
	private String specialRequest;
	private String serviceAddress;
	private String customerName;
	private String serviceImage;
	private double total_price;
	private int duration;
	private String date;
	private String time;
	private String categoryName;
	private String status;

	public Booking() {

	}



	public Booking(int id, String serviceName, String specialRequest, String serviceAddress, String customerName, int duration, String date,
			String time, String categoryName, String status, double total_price) {
		this.id = id;
		this.serviceName = serviceName;
		this.specialRequest = specialRequest;
		this.serviceAddress = serviceAddress;
		this.customerName = customerName;
		this.duration = duration;
		this.date = date;
		this.time = time;
		this.categoryName = categoryName;
		this.status = status;
		this.total_price = total_price;
	}



	public String getStatus() {
		return status;
	}



	public void setStatus(String status) {
		this.status = status;
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

	public void setTime(String i) {
		this.time = i;
	}

	public String getServiceAddress() {
		return serviceAddress;
	}

	public void setServiceAddress(String serviceAddress) {
		this.serviceAddress = serviceAddress;
	}

	public String getServiceImage() {
		return serviceImage;
	}



	public void setServiceImage(String serviceImage) {
		this.serviceImage = serviceImage;
	}



	public double getTotal_price() {
		return total_price;
	}



	public void setTotal_price(double total_price) {
		this.total_price = total_price;
	}
}

