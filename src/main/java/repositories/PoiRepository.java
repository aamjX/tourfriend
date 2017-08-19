package repositories;

import java.util.Collection;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import domain.Poi;

@Repository
public interface PoiRepository extends JpaRepository<Poi, Integer> {
	
	@Query("select p from Poi p where (p.name like %?1% or p.description like %?1% or p.place like %?1%) and p.tourFriendCreator.id=?2")
	Collection<Poi> searchPoi(String keyword,int tourFriendId);
	
	@Query("select p from Poi p where p.tourFriendCreator.id=?1")
	Collection<Poi> findMyPois(int tourFriendId);

}
