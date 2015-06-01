package com.redhat.airport.push;

import org.jboss.aerogear.unifiedpush.JavaSender;
import org.jboss.aerogear.unifiedpush.message.MessageResponseCallback;
import org.jboss.aerogear.unifiedpush.message.UnifiedMessage;

public class PushNotificationService implements JavaSender {

	@Override
	public void send(UnifiedMessage unifiedMessage, MessageResponseCallback callback) {

	}

	@Override
	public void send(UnifiedMessage unifiedMessage) {

	}

	@Override
	public String getServerURL() {
		// TODO Auto-generated method stub
		return null;
	}
}
