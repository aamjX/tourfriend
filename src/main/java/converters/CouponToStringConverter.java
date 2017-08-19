package converters;

import org.springframework.core.convert.converter.Converter;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import domain.Coupon;

@Component
@Transactional
public class CouponToStringConverter implements Converter<Coupon, String>{
	@Override
	public String convert(Coupon coupon) {
		String result;

		if (coupon == null) {
			result = null;
		} else {
			result = String.valueOf(coupon.getId());
		}
		return result;
	}
}
