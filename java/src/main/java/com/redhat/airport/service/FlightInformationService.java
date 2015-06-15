package com.redhat.airport.service;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import javax.enterprise.context.ApplicationScoped;
import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.redhat.airport.data.CouponProducer;
import com.redhat.airport.model.Flight;

@ApplicationScoped
public class FlightInformationService {

	private static final Logger logger = LoggerFactory.getLogger(FlightInformationService.class);

	@Inject
	private CouponProducer cProducer;

	private Flight flight;

	/*
	 * Service for mobile app
	 */
	public Flight getFlightInfo(int flightNo) {
		logger.info("Retrieving Flight Info...");
		List<Flight> flightList = parseFlightInformation(false);
		flight = flightList.get(0);
		return flight;
	}

	/*
	 * Service for digital signage
	 */
	public List<Flight> getFlightList() {
		logger.info("Retrieving Flight List...");
		List<Flight> flightList = new ArrayList<Flight>();
		flightList = parseFlightInformation(true);
		return flightList;
	}

	/*
	 * Parse JSON files for dummy data
	 */
	public List<Flight> parseFlightInformation(boolean flightList) {
		List<Flight> flightInfo = new ArrayList<Flight>();
		ObjectMapper mapper = new ObjectMapper();
		mapper.configure(DeserializationFeature.ACCEPT_SINGLE_VALUE_AS_ARRAY, true);
		String jsonName = flightList ? "flightList.json" : "flight.json";
		try {
			flightInfo = mapper.readValue(this.getClass().getClassLoader().getResource(jsonName), new TypeReference<List<Flight>>() {
			});
			flightInfo = demoTimeParser(flightInfo);
		} catch (JsonParseException e) {
			logger.error("Error parsing JSON");
		} catch (JsonMappingException e) {
			logger.error("Error mapping JSON");
		} catch (IOException e) {
			logger.error("Couldn't load file");
		}
		logger.info("Flight Info Found");
		return flightInfo;
	}

	/*
	 * Set flight times. For demo use only
	 */
	public List<Flight> demoTimeParser(List<Flight> flightList) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");

		for (int i = 0; i < flightList.size(); i++) {
			Calendar calendar = Calendar.getInstance();
			flightList.get(i).setCurrentTime(sdf.format(calendar.getTime()));
			if (i == 0) {
				calendar.add(Calendar.MINUTE, 10);
				flightList.get(i).setBoarding(sdf.format(calendar.getTime()));
				calendar.add(Calendar.MINUTE, 20);

			} else {
				calendar.add(Calendar.HOUR, i);
				calendar.set(Calendar.MINUTE, 0);
				calendar.add(Calendar.MINUTE, -20);
				flightList.get(i).setBoarding(sdf.format(calendar.getTime()));
				calendar.add(Calendar.MINUTE, 20);
			}
			flightList.get(i).setDeparture(sdf.format(calendar.getTime()));
			calendar.add(Calendar.MINUTE, 100);
			flightList.get(i).setArrival(sdf.format(calendar.getTime()));
		}
		return flightList;
	}
}