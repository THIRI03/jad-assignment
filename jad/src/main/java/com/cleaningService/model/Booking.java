
package com.cleaningService.model;

public class Booking {

	private int id;
	private int userId;
	
	private String customerName;
	private String customerEmail;
	private String customerPhone;
	
	private String serviceName;
	private String categoryName;

	private String specialRequest;
	private String serviceAddress;

	private int duration;
	private String date;
	private String time;

	private String status;
	private double totalPrice;

	/*
	 * Use Integer instead of int because cleaner_id can be NULL.
	 */
	private Integer cleanerId;

	public Booking() {

	}

	public Booking(int id, int userId, String customerName,
			String serviceName, String categoryName,
			String specialRequest, String serviceAddress,
			int duration, String date, String time,
			String status, double totalPrice, Integer cleanerId) {

		this.id = id;
		this.userId = userId;
		this.customerName = customerName;
		this.serviceName = serviceName;
		this.categoryName = categoryName;
		this.specialRequest = specialRequest;
		this.serviceAddress = serviceAddress;
		this.duration = duration;
		this.date = date;
		this.time = time;
		this.status = status;
		this.totalPrice = totalPrice;
		this.cleanerId = cleanerId;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}
	
	public String getCustomerEmail() {
		return customerEmail;
	}

	public void setCustomerEmail(String customerEmail) {
		this.customerEmail = customerEmail;
	}

	public String getCustomerPhone() {
		return customerPhone;
	}

	public void setCustomerPhone(String customerPhone) {
		this.customerPhone = customerPhone;
	}

	public String getCustomerName() {
		return customerName;
	}

	public void setCustomerName(String customerName) {
		this.customerName = customerName;
	}

	public String getServiceName() {
		return serviceName;
	}

	public void setServiceName(String serviceName) {
		this.serviceName = serviceName;
	}

	public String getCategoryName() {
		return categoryName;
	}

	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}

	public String getSpecialRequest() {
		return specialRequest;
	}

	public void setSpecialRequest(String specialRequest) {
		this.specialRequest = specialRequest;
	}

	public String getServiceAddress() {
		return serviceAddress;
	}

	public void setServiceAddress(String serviceAddress) {
		this.serviceAddress = serviceAddress;
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

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public double getTotalPrice() {
		return totalPrice;
	}

	public void setTotalPrice(double totalPrice) {
		this.totalPrice = totalPrice;
	}

	public Integer getCleanerId() {
		return cleanerId;
	}

	public void setCleanerId(Integer cleanerId) {
		this.cleanerId = cleanerId;
	}
}