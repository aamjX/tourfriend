package repositories;

import java.util.Collection;
import java.util.Date;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import domain.Code;
import domain.Event;

@Repository
public interface CodeRepository extends JpaRepository<Code, Integer> {
	
    @Query("select b.code from Event e join e.bookings b where e.id=?1")
	Collection<Code> findByEvent(int eventId);

}
