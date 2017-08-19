package services;

import domain.Payment;
import domain.enumeration.StatusPayment;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.Assert;
import repositories.PaymentRepository;

import java.util.Collection;
import java.util.Date;

@Service
@Transactional
public class PaymentService {

	@Autowired
	private PaymentRepository paymentRepository;


	public PaymentService() {
		super();
	}

	public Payment create() {

		Payment payment = new Payment();

		payment.setPaymentMoment(new Date());
		payment.setAmount(1.0);
		payment.setStatus(StatusPayment.RETURNED);

		return payment;
	}

	public Payment save(Payment payment) {

		Assert.notNull(payment);

		return paymentRepository.saveAndFlush(payment);
	}

	public Collection<Payment> findAll() {

		return paymentRepository.findAll();
	}

	public Payment findOne(int id) {

		return paymentRepository.findOne(id);
	}

	public void delete(Payment payment) {

		paymentRepository.delete(payment);
	}

	public Payment saveAndFlush(Payment p) {

		Assert.notNull(p);

		return paymentRepository.saveAndFlush(p);
	}
}
