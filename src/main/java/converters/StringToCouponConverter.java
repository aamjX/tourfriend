package converters;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.convert.converter.Converter;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import domain.Coupon;
import repositories.CouponRepository;

@Component
@Transactional
public class StringToCouponConverter implements Converter<String, Coupon>{
	
	@Autowired
	CouponRepository CouponRepository;

	@Override
	public Coupon convert(String text) {
		Coupon result;
		int id;

		try {
			if (StringUtils.isEmpty(text)) {
				result = null;
			} else {
				id = Integer.valueOf(text);
				result = CouponRepository.findOne(id);
			}
		} catch (Throwable oops) {
			throw new IllegalArgumentException(oops);
		}

		return result;
	}

}
