package converters;

import org.springframework.core.convert.converter.Converter;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import domain.Poi;

@Component
@Transactional
public class PoiToStringConverter implements Converter<Poi, String> {

	@Override
	public String convert(Poi poi) {
		String result;

		if (poi == null) {
			result = null;
		} else {
			result = String.valueOf(poi.getId());
		}
		return result;
	}

}