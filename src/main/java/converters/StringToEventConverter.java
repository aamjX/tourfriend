package converters;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.convert.converter.Converter;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import domain.Event;
import services.EventService;

@Component
@Transactional
public class StringToEventConverter implements Converter<String, Event> {

	@Autowired
	EventService eventService;

	@Override
	public Event convert(String text) {
		Event result;
		int id;

		try {
			id = Integer.valueOf(text);
			result = eventService.findOne(id);
		} catch (Throwable oops) {
			throw new IllegalArgumentException(oops);
		}

		return result;
	}

}
