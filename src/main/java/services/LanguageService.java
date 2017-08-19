package services;

import java.util.Collection;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import domain.Language;
import repositories.LanguageRepository;

@Service
@Transactional
public class LanguageService {
	
	@Autowired
	private LanguageRepository languageRepository;
	
	public Collection<Language> findAll(){
		return languageRepository.findAll();
	}

}
