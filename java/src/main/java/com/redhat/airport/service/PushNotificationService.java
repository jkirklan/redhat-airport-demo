package com.redhat.airport.service;

import javax.ejb.Stateless;
import javax.enterprise.event.Observes;

import org.jboss.aerogear.unifiedpush.JavaSender;
import org.jboss.aerogear.unifiedpush.SenderClient;
import org.jboss.aerogear.unifiedpush.message.MessageResponseCallback;
import org.jboss.aerogear.unifiedpush.message.UnifiedMessage;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Stateless
public class PushNotificationService {

	private static final Logger logger = LoggerFactory.getLogger(PushNotificationService.class);

	public void sendFlightNotification(@Observes int demoMode) {

		// JavaSender sender = new
		// SenderClient.Builder("https://aerogear-fguanlao.rhcloud.com/ag-push/").build();
		JavaSender sender = new SenderClient.Builder("https://jbossunifiedpush-fguanlao.rhcloud.com/ag-push").build();

		String message;

		/*
		 * Selecting scenario for demo
		 */
		switch (demoMode) {
		case 1:
			message = "You are late for your flight. Your boarding gate staff have been notified that you are on your way";
			break;
		case 2:
			message = "Your flight is delayed. We apologize for the inconvenience. Swipe to collect an offer to ease the pain";
			break;
		case 3:
			message = "Your flight is boarding in 10 minutes. Please make your way to the gate";
			break;
		default:
			message = null;
			logger.error("Invalid Demo type");
			break;
		}

		logger.info("Sending push notification...");
		UnifiedMessage unifiedMessage = new UnifiedMessage.Builder().pushApplicationId("31ab23f8-e430-4956-adaa-b58ee6cf6c1a")
				.masterSecret("c0862d46-9cb0-4bdd-81d2-15e3f5c860eb").alert(message).attribute("NOTIFICATION_TYPE", Integer.toString(demoMode)).build();

		sender.send(unifiedMessage, new MessageResponseCallback() {
			@Override
			public void onComplete(int statusCode) {
				logger.info("Notification sent successfully");
			}

			@Override
			public void onError(Throwable throwable) {
				// an error occured during send
				logger.info("Error sending notification");
			}
		});
	}
}
