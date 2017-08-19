package repositories;

import java.util.Collection;
import java.util.Date;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import domain.Event;
import domain.TourFriend;

@Repository
public interface EventRepository extends JpaRepository<Event, Integer> {

    @Query("select e from Event e where e.isCancelled = false and current_timestamp < e.date order by e.date ASC")
    Collection<Event> findAllAvailables();
    
    @Query("select e from Booking b join b.event e where b.tourFriend.id=?1")
    Collection<Event> findEventBookingByTourfiend(int id);

    @Query("select e from Event e where e.tourFriend.id=?1 and e.date > CURRENT_TIMESTAMP order by e.date")
    Collection<Event> findByTourFriendId(int id);
    
    @Query("select e from Event e where e.tourFriend.id=?1 order by e.date desc")
    Collection<Event> findAllByTourFriendId(int id);
    
    @Query("select e from Event e where e.route.city LIKE %?1% and e.isCancelled = false and current_timestamp < e.date")
    Collection<Event> findByCity(String city);
    
    @Query("select e from Event e where e.date is not null and e.date>=?1 and e.isCancelled = false and current_timestamp < e.date")
    Collection<Event> findByDate(Date date); 
    
    @Query("select e from Event e where e.date > CURRENT_TIMESTAMP and e.isCancelled = false and (?1 is null or (e.date > ?1)) and "
            + "(?2 is null or e.route.city like ?2) and (?3 is null or e.minPeople>=?3) and (?4 is null or e.maxPeople>=?4) and (?5 is null or e.price>=?5) and"
            + "(?6 is null or e.price<=?6) order by e.date ASC")
    List<Event> avancedSearch(Date date, String city, Integer numPersonasMin, Integer numPersonasMax, Double precioMin, Double precioMax);
    
    
    @Query("select avg(e.price) from Event e where YEAR(e.date) = YEAR(CURRENT_DATE)")
    Integer avgPriceOfEventThisYear();
    
    @Query("select avg(e.price) from Event e where YEAR(e.date) = YEAR(CURRENT_DATE)-1")
    Integer avgPriceOfEventPreviousYear();
    
    @Query("select avg(e.price) from Event e where YEAR(e.date) = YEAR(CURRENT_DATE)-2")
    Integer avgPriceOfEventMake2Year();
    
    @Query("select e.tourFriend from Event e where e.id=?1")
    TourFriend findTourFriendCreatorEvenet(int eventId);
    
    //Eventos reportados este mes
    @Query("select count(m) from Message m where (m.subject = 'Reported event' or m.subject = 'Evento reportado') and MONTH(m.sentMoment) = MONTH(CURRENT_DATE)")
    Integer eventReportedThisMonth();
    
  //Eventos reportados el mes pasado
    @Query("select count(m) from Message m where (m.subject = 'Reported event' or m.subject = 'Evento reportado') and MONTH(m.sentMoment) = MONTH(CURRENT_DATE)-1")
    Integer eventReportedPreviousMonth();
    
  //Eventos reportados hace 2 meses
    @Query("select count(m) from Message m where (m.subject = 'Reported event' or m.subject = 'Evento reportado') and MONTH(m.sentMoment) = MONTH(CURRENT_DATE)-2")
    Integer eventReportedMake2Month();
    
}