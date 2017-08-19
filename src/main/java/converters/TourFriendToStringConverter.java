package converters;

import org.springframework.core.convert.converter.Converter;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import domain.TourFriend;

@Component
@Transactional
public class TourFriendToStringConverter implements Converter<TourFriend, String> {

	@Override
	public String convert(TourFriend tourFriend) {
		String result;

		if (tourFriend == null) {
			result = null;
		} else {
			result = String.valueOf(tourFriend.getId());
		}
		return result;
	}


}
