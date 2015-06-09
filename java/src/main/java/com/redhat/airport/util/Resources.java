package com.redhat.airport.util;

import javax.enterprise.context.ApplicationScoped;
import javax.enterprise.inject.Produces;

import org.jboss.aerogear.unifiedpush.SenderClient;

public class Resources {

	@Produces
	@ApplicationScoped
	public SenderClient getSenderClient() {

		return new SenderClient.Builder("https://aerogear-fguanlao.rhcloud.com/ag-push/").build();
	}
}
