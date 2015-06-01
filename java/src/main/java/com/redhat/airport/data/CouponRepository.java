package com.redhat.airport.data;

import javax.enterprise.context.RequestScoped;
import javax.inject.Inject;
import javax.persistence.EntityManager;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;

import com.redhat.airport.model.Coupon;

@RequestScoped
public class CouponRepository {

	@Inject
	private EntityManager entity;

	// TODO: specify which coupon to select on multiple returns
	public Coupon findCouponByStatusSeverity(int delaySeverity) {
		CriteriaBuilder cb = entity.getCriteriaBuilder();
		CriteriaQuery<Coupon> criteria = cb.createQuery(Coupon.class);
		Root<Coupon> coupon = criteria.from(Coupon.class);
		criteria.select(coupon).where(cb.equal(coupon.get("delay_severity"), delaySeverity));
		return entity.createQuery(criteria).getSingleResult();
	}
}
