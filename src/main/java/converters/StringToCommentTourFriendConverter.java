package converters;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.convert.converter.Converter;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import domain.CommentTourFriend;
import repositories.CommentTourFriendRepository;

@Component
@Transactional
public class StringToCommentTourFriendConverter implements Converter<String, CommentTourFriend>{
	
	@Autowired
	CommentTourFriendRepository commentTourFriendRepository;

	@Override
	public CommentTourFriend convert(String text) {
		CommentTourFriend result;
		int id;

		try {
			if (StringUtils.isEmpty(text)) {
				result = null;
			} else {
				id = Integer.valueOf(text);
				result = commentTourFriendRepository.findOne(id);
			}
		} catch (Throwable oops) {
			throw new IllegalArgumentException(oops);
		}

		return result;
	}
}