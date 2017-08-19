package controllers.admin;

import java.util.Collection;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import controllers.AbstractController;
import domain.Coupon;
import services.CouponService;

@Controller
@RequestMapping("/coupon/admin")
public class CouponController extends AbstractController{
	
	// Supporting services ----------------------------------------------------
	
	@Autowired
	private CouponService couponService;

	// Constructors -----------------------------------------------------------
	
	public CouponController(){
		super();
	}

	// Listing ----------------------------------------------------------------
	
	@RequestMapping(value = "/list.do", method = RequestMethod.GET)
	public ModelAndView list() {
		ModelAndView result;

		Collection<Coupon> coupons = couponService.findAll();
		
		result = new ModelAndView("coupon/list");

		result.addObject("coupons", coupons);
		result.addObject("requestURI", "coupon/list.do");

		return result;
	}

	// Creating ---------------------------------------------------------------
	
	@RequestMapping(value="/create", method=RequestMethod.GET)
	public ModelAndView create(){
		ModelAndView result;
		Coupon coupon;
		
		coupon = couponService.create();
		
		result = createModelAndView(coupon);
		
		return result;
		
	}
	
	@RequestMapping(value = "/create", method = RequestMethod.POST, params = "save")
	public ModelAndView save(@Valid Coupon coupon, BindingResult binding) {
		ModelAndView result; 
		
		if (binding.hasErrors()) {
			result = createModelAndView(coupon);
		} else {
			try {
				couponService.save(coupon);
				result = new ModelAndView("redirect:../admin/list.do");
			} catch (Throwable oops) {
				result = createModelAndView(coupon, "coupon.commit.error");
			}
		}

		return result;
	}
	
	// Disable / enable coupons ----------------------------------------------
	
	@RequestMapping(value="/enable", method=RequestMethod.GET)
	public ModelAndView enable(@RequestParam int couponId){
		ModelAndView result;
		
		couponService.enable(couponId);
		
		result = new ModelAndView("redirect:../admin/list.do");
		
		return result;
		
	}
	
	@RequestMapping(value="/disable", method=RequestMethod.GET)
	public ModelAndView disable(@RequestParam int couponId){
		ModelAndView result;
		
		couponService.disable(couponId);
		
		result = new ModelAndView("redirect:../admin/list.do");
		
		return result;
		
	}

	// Ancillary methods ------------------------------------------------------

	protected ModelAndView createModelAndView(Coupon coupon) {
		ModelAndView result;

		result = createModelAndView(coupon, null);

		return result;
	}

	protected ModelAndView createModelAndView(Coupon coupon, String message) {
		ModelAndView result;

		result = new ModelAndView("coupon/create");
		result.addObject("coupon", coupon);
		result.addObject("message", message);

		return result;
	}
}
