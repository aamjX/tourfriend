package converters;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.convert.converter.Converter;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import domain.CommentEvent;
import repositories.CommentEventRepository;

@Component
@Transactional
public class StringToCommentEventConverter implements Converter<String, CommentEvent>{
	
	@Autowired
	CommentEventRepository commentEventRepository;

	@Override
	public CommentEvent convert(String text) {
		CommentEvent result;
		int id;

		try {
			if (StringUtils.isEmpty(text)) {
				result = null;
			} else {
				id = Integer.valueOf(text);
				result = commentEventRepository.findOne(id);
			}
		} catch (Throwable oops) {
			throw new IllegalArgumentException(oops);
		}

		return result;
	}
}
