package com.redhat.airport.data;

import javax.enterprise.context.RequestScoped;

import com.redhat.airport.model.Coupon;

@RequestScoped
public class CouponProducer {

	// @Inject
	// private CouponRepository couponRepo;

	public Coupon getCouponOnDelay() {
		Coupon coupon = new Coupon();
		// if (delay > 0 && delay <= 30) {
		// return null;
		// } else if (delay > 30 && delay <= 60) {
		coupon.setCompany("Starbucks");
		coupon.setCompanyCode("STBK");
		coupon.setPath("images/starbucks-coupon.png");
		coupon.setOffer("Get 1 Free Starbucks Coffee");
		coupon.setDescription("Redeem this coupon at any Starbucks Coffee location at Boston Logan International.");
		coupon.setDelaySeverity(60);
		coupon.setStatusId(2);
		return coupon;
		// } else {
		// return coupon;
		// }
	}
}
