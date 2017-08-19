package services;

import java.util.Collection;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.Assert;

import domain.Coupon;
import domain.TourFriend;
import repositories.CouponRepository;

@Service
@Transactional
public class CouponService {

	// Repositories -----------------------------------------------------------

	@Autowired
	private CouponRepository couponRepository;
	@Autowired
	private TourFriendService tourFriendService;

	// Supporting services ----------------------------------------------------

	// Constructors -----------------------------------------------------------

	// Simple CRUD methods ----------------------------------------------------

	public Coupon create() {
		Coupon result;

		result = new Coupon();

		result.setIsDisabled(false);

		return result;
	}

	public Coupon save(Coupon coupon) {
		Assert.notNull(coupon);

		return couponRepository.saveAndFlush(coupon);
	}

	public Coupon findOne(int couponID) {
		Coupon result;

		result = couponRepository.findOne(couponID);
		Assert.notNull(result);

		return result;

	}

	public Collection<Coupon> findAll() {

		return couponRepository.findAll();
	}



	public Boolean exchange(int couponId) {
		Boolean result = false;
		TourFriend principal;
		Coupon coupon;

		principal = tourFriendService.findByPrincipal();
		coupon = findOne(couponId);

		if (principal.getAvailablePoints() >= coupon.getPoints()) {
			principal.setAvailablePoints(principal.getAvailablePoints() - coupon.getPoints());
			principal.setAvailableBalance(principal.getAvailableBalance() + coupon.getValue());
			tourFriendService.save(principal);
			result = true;
		}

		return result;
	}

	// Other business methods -------------------------------------------------

	public void enable(int couponID) {
		Coupon coupon;

		coupon = findOne(couponID);

		Assert.notNull(coupon);
		Assert.isTrue(coupon.getIsDisabled() == true);

		coupon.setIsDisabled(false);
		save(coupon);
	}

	public void disable(int couponID){
		Coupon coupon;
		
		coupon = findOne(couponID);

		Assert.notNull(coupon);
		Assert.isTrue(coupon.getIsDisabled() == false);
		
		coupon.setIsDisabled(true);
		save(coupon);
	}
	
	public Collection<Coupon> getEnabledCoupon(){
		Collection<Coupon> result;
		
		result = couponRepository.getEnabledCoupons();
		
		return result;
	}
}
