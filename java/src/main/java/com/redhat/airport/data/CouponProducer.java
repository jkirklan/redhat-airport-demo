package com.redhat.airport.data;

import javax.enterprise.context.RequestScoped;
import javax.inject.Inject;

import com.redhat.airport.model.Coupon;

@RequestScoped
public class CouponProducer {

	@Inject
	private CouponRepository couponRepo;

	private Coupon coupon;

}
