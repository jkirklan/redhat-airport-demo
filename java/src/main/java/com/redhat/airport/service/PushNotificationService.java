package com.redhat.airport.service;

import javax.ejb.Stateless;
import javax.enterprise.event.Observes;
import javax.inject.Inject;

import org.jboss.aerogear.unifiedpush.SenderClient;
import org.jboss.aerogear.unifiedpush.message.UnifiedMessage;

import com.redhat.airport.model.Flight;

@Stateless
public class PushNotificationService {

	@Inject
	SenderClient sender;

	// here the CDI 'Payment' event is caught and the actual send is triggered
	public void sendFlightNotification(@Observes Flight flight) {
		UnifiedMessage unifiedMessage = new UnifiedMessage.Builder().pushApplicationId("46089868-932b-4d0c-96fa-e9cafdbb97c1")
				.masterSecret("42848659-6343-4c26-a766-db55630ce399").alert("Your flight has been delayed").build();

		sender.send(unifiedMessage);
	}
}
