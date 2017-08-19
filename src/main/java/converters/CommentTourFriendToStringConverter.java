package converters;

import org.springframework.core.convert.converter.Converter;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import domain.CommentTourFriend;

@Component
@Transactional
public class CommentTourFriendToStringConverter implements Converter<CommentTourFriend, String>{
	@Override
	public String convert(CommentTourFriend commentTourFriend) {
		String result;

		if (commentTourFriend == null) {
			result = null;
		} else {
			result = String.valueOf(commentTourFriend.getId());
		}
		return result;
	}
}