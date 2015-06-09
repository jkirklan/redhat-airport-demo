package com.redhat.airport.service;

import javax.ejb.Stateless;
import javax.enterprise.event.Observes;

import org.jboss.aerogear.unifiedpush.JavaSender;
import org.jboss.aerogear.unifiedpush.SenderClient;
import org.jboss.aerogear.unifiedpush.message.MessageResponseCallback;
import org.jboss.aerogear.unifiedpush.message.UnifiedMessage;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.redhat.airport.model.Flight;

@Stateless
public class PushNotificationService {

	private static final Logger logger = LoggerFactory.getLogger(PushNotificationService.class);

	public void sendFlightNotification(@Observes Flight flight) {
		JavaSender sender = new SenderClient.Builder("https://aerogear-fguanlao.rhcloud.com/ag-push/").build();
		logger.info("Sending push notification...");
		UnifiedMessage unifiedMessage = new UnifiedMessage.Builder().pushApplicationId("3a99104b-cc88-4744-9004-d2341d30907d")
				.masterSecret("640f3bd2-3d63-48fb-874a-452b2f7ffdf7").alert("Your flight has been delayed").build();

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
