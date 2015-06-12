package com.redhat.airport.model;

import java.util.Calendar;

public class Flight {
	private int flightNo;
	private String airlineCode;
	private Calendar departure;
	private Calendar arrival;
	private Calendar boarding;
	private String startingAirport;
	private String destinationAirport;
	private String startingCity;
	private String destinationCity;
	private String flightStatus;
	private int startingGate;
	private int destinationGate;
	private Coupon coupon;

	public int getFlightNo() {
		return this.flightNo;
	}

	public void setFlightNo(int flightNo) {
		this.flightNo = flightNo;
	}

	public String getAirlineCode() {
		return this.airlineCode;
	}

	public void setAirlineCode(String airlineCode) {
		this.airlineCode = airlineCode;
	}

	public Calendar getDeparture() {
		return this.departure;
	}

	public void setDeparture(Calendar departure) {
		this.departure = departure;
	}

	public Calendar getArrival() {
		return this.arrival;
	}

	public void setArrival(Calendar arrival) {
		this.arrival = arrival;
	}

	public Calendar getBoarding() {
		return this.boarding;
	}

	public void setBoarding(Calendar boarding) {
		this.boarding = boarding;
	}

	public String getStartingAirport() {
		return this.startingAirport;
	}

	public void setStartingAirport(String startingAirport) {
		this.startingAirport = startingAirport;
	}

	public String getDestinationAirport() {
		return this.destinationAirport;
	}

	public void setDestinationAirport(String destinationAirport) {
		this.destinationAirport = destinationAirport;
	}

	public String getStartingCity() {
		return this.startingCity;
	}

	public void setStartingCity(String startingCity) {
		this.startingCity = startingCity;
	}

	public String getDestinationCity() {
		return this.destinationCity;
	}

	public void setDestinationCity(String destinationCity) {
		this.destinationCity = destinationCity;
	}

	public String getFlightStatus() {
		return this.flightStatus;
	}

	public void setFlightStatus(String flightStatus) {
		this.flightStatus = flightStatus;
	}

	public int getStartingGate() {
		return this.startingGate;
	}

	public void setStartingGate(int startingGate) {
		this.startingGate = startingGate;
	}

	public int getDestinationGate() {
		return this.destinationGate;
	}

	public void setDestinationGate(int destinationGate) {
		this.destinationGate = destinationGate;
	}

	public Coupon getCoupon() {
		return this.coupon;
	}

	public void setCoupon(Coupon coupon) {
		this.coupon = coupon;
	}

}
