package converters;

import org.springframework.core.convert.converter.Converter;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import domain.CommentEvent;

@Component
@Transactional
public class CommentEventToStringConverter implements Converter<CommentEvent, String>{
	@Override
	public String convert(CommentEvent commentEvent) {
		String result;

		if (commentEvent == null) {
			result = null;
		} else {
			result = String.valueOf(commentEvent.getId());
		}
		return result;
	}
}
