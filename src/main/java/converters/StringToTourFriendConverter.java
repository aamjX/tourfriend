package converters;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.convert.converter.Converter;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import domain.TourFriend;
import repositories.TourFriendRepository;

@Component
@Transactional
public class StringToTourFriendConverter implements Converter<String, TourFriend> {

	@Autowired
	TourFriendRepository	tourFriendRepository;


	@Override
	public TourFriend convert(String text) {
		TourFriend result;
		int id;

		try {
			if (StringUtils.isEmpty(text)) {
				result = null;
			} else {
				id = Integer.valueOf(text);
				result = tourFriendRepository.findOne(id);
			}
		} catch (Throwable oops) {
			throw new IllegalArgumentException(oops);
		}

		return result;
	}

}

