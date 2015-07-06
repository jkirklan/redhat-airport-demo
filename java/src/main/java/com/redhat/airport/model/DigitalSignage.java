package com.redhat.airport.model;

/*
 *  Object for updating digital signage
 */
public class DigitalSignage {
	private int demoSign;
	private String signHeader;
	private String signMessage;
	private Flight flight;

	public int getDemoSign() {
		return demoSign;
	}

	public void setDemoSign(int demoSign) {
		this.demoSign = demoSign;
	}

	public String getSignHeader() {
		return signHeader;
	}

	public void setSignHeader(String signHeader) {
		this.signHeader = signHeader;
	}

	public String getSignMessage() {
		return signMessage;
	}

	public void setSignMessage(String signMessage) {
		this.signMessage = signMessage;
	}

	public Flight getFlight() {
		return flight;
	}

	public void setFlight(Flight flight) {
		this.flight = flight;
	}

}
