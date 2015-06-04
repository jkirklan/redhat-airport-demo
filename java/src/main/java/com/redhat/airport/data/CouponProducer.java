package com.redhat.airport.data;

import javax.enterprise.context.RequestScoped;

import com.redhat.airport.model.Coupon;

@RequestScoped
public class CouponProducer {

	// @Inject
	// private CouponRepository couponRepo;

	/*
	 * Method for providing dummy data for Coupon
	 */
	public Coupon demoCouponOnDelay() {
		Coupon coupon = new Coupon();
		coupon.setCompany("Starbucks");
		coupon.setCompanyCode("STBK");
		coupon.setPath("images/starbucks-coupon.png");
		coupon.setOffer("Get 1 Free Starbucks Coffee");
		coupon.setDescription("Redeem this coupon at any Starbucks Coffee location at Boston Logan International.");
		coupon.setDelaySeverity(60);
		coupon.setStatusId(2);
		return coupon;
	}
}
