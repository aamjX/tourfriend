package repositories;

import java.util.Collection;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import domain.Booking;

@Repository
public interface BookingRepository extends JpaRepository<Booking, Integer> {

	@Query("select b from Booking b where b.tourFriend.id = ?1")
	Collection<Booking> findByPrincipal(int id);

	@Query("select b from Booking b where b.tourFriend.id = ?1 and b.event.id = ?2")
	Booking findOneByTourFriendAndEvent(int idTourFriend, int idEvent);

	@Query("select b from Booking b where b.event.id = ?1")
	Collection<Booking> findAllByEvent(int intEvent);

	@Query("select b from Booking b where b.tourFriend.id = ?2 and b.event.id = ?1")
	Booking findBookingOfPrincipalByEvent(int eventId, int tourFriendId);

	// Bookings en este mes
	@Query("select count(b) from Booking b where MONTH(b.bookingMoment) = MONTH(CURRENT_DATE) and b.isCancelled = false and b.isPaied = true")
	Integer numBookingThisMonth();

	// Bookings en el anterior mes
	@Query("select count(b) from Booking b where MONTH(b.bookingMoment) = MONTH(CURRENT_DATE)-1 and b.isCancelled = false and b.isPaied = true")
	Integer numBookingPreviousMonth();

	// Bookings hace dos meses
	@Query("select count(b) from Booking b where MONTH(b.bookingMoment) = MONTH(CURRENT_DATE)-2 and b.isCancelled = false and b.isPaied = true")
	Integer numBookingMakeTwoMonth();

	@Query("select b from Booking b where b.code.id = ?1")
	Booking findByCode(int codeId);

	// Bookings en este año
	@Query("select count(b) from Booking b where YEAR(b.bookingMoment) = YEAR(CURRENT_DATE) and b.isCancelled = false and b.isPaied = true")
	Integer numBookingThisYear();

	// Bookings en el anterior año
	@Query("select count(b) from Booking b where YEAR(b.bookingMoment) = YEAR(CURRENT_DATE)-1 and b.isCancelled = false and b.isPaied = true")
	Integer numBookingPreviousYear();

	// Bookings hace dos años
	@Query("select count(b) from Booking b where YEAR(b.bookingMoment) = YEAR(CURRENT_DATE)-2 and b.isCancelled = false and b.isPaied = true")
	Integer numBookingMakeTwoYear();

	// Ciudades con mas reservas
	@Query("select r.city,count(b) from Route r join r.events e join e.bookings b where b.isPaied =true and b.isCancelled = false group by r.city order by count(b) DESC")
	Collection<Object[]> cityMoreBookings();

	// Ciudades con menos reservas
	@Query("select r.city,count(b) from Route r join r.events e join e.bookings b where b.isPaied =true and b.isCancelled = false group by r.city order by count(b) ASC")
	Collection<Object[]> cityLessBookings();

}
