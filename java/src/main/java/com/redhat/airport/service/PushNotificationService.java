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
		UnifiedMessage unifiedMessage = new UnifiedMessage.Builder().pushApplicationId("c391d9f5-bc32-4b80-9dc6-0fd7cb382bdc")
				.masterSecret("ece58f47-f6eb-4cca-af22-eb34bc0e1501").alert(message).attribute("NOTIFICATION_TYPE", Integer.toString(demoMode)).build();

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
