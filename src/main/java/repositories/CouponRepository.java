package repositories;

import java.util.Collection;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import domain.Coupon;

@Repository
public interface CouponRepository extends JpaRepository<Coupon, Integer> {
	
	
	@Query("select c from Coupon c where c.isDisabled = false")
	Collection<Coupon> getEnabledCoupons();

}
