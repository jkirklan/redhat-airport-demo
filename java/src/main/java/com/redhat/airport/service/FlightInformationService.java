package com.redhat.airport.service;

import com.redhat.airport.model.Flight;

public class FlightInformationService {
	public Flight getFlightInfo(int flightNo) {
		Flight flight = retrieveFlightInformation(true);

		return flight;
	}

	public Flight retrieveFlightInformation(boolean demoMode) {
		Flight flight = new Flight();
		flight.setFlightNo(70);
		flight.setAirlineCode("AC");
		flight.setDeparture("2015-06-02T12:00");
		flight.setArrival("2015-06-02T13:45");
		flight.setBoarding("2015-06-02T11:40");
		flight.setStartingAirport("BOS");
		flight.setDestinationAirport("YYZ");
		flight.setStartingCity("Boston");
		flight.setDestinationCity("Toronto");
		flight.setFlightStatus("On Time");
		flight.setStartingGate(1);
		flight.setDestinationGate(1);

		flight.setCoupon(null);
		return flight;
	}
}
