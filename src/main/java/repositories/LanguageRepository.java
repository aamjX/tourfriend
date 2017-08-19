package repositories;


import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import domain.Language;

@Repository
public interface LanguageRepository extends JpaRepository<Language, Integer> {
	
}
