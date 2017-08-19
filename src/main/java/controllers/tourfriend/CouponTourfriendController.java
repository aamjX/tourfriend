package controllers.tourfriend;

import java.util.Collection;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import controllers.AbstractController;
import domain.Coupon;
import services.CouponService;

@Controller
@RequestMapping("/coupon/tourfriend")
public class CouponTourfriendController extends AbstractController{
	
	// Supporting services ----------------------------------------------------
	
	@Autowired
	private CouponService couponService;

	// Constructors -----------------------------------------------------------
	
	public CouponTourfriendController(){
		super();
	}

	// Listing ----------------------------------------------------------------
	
	@RequestMapping(value = "/list.do", method = RequestMethod.GET)
	public ModelAndView list() {
		ModelAndView result;

		Collection<Coupon> coupons = couponService.getEnabledCoupon();
		
		result = new ModelAndView("coupon/list");

		result.addObject("coupons", coupons);
		result.addObject("requestURI", "coupon/list.do");

		return result;
	}

	// Creating ---------------------------------------------------------------

	// Ancillary methods ------------------------------------------------------
	
	@RequestMapping(value = "/exchange", method = RequestMethod.GET)
	public ModelAndView edit(@RequestParam int couponId) {
		ModelAndView result;
		Boolean itsOk;
		Coupon coupon;
		
		itsOk = couponService.exchange(couponId);
		coupon = couponService.findOne(couponId);
		
		result = new ModelAndView("coupon/confirmationCoupon");
		result.addObject("itsOk", itsOk);
		result.addObject("coupon", coupon);

		return result;
		
	}
}
