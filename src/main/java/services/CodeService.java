package services;

import java.util.Collection;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.Assert;

import repositories.CodeRepository;
import domain.Code;
import domain.Actor;

@Service
@Transactional
public class CodeService {

	// Managed repository -------------------------------------------

	@Autowired
	private CodeRepository codeRepository;
	
	// Supporting services ------------------------------------------
	@Autowired
	private ActorService actorService;
	
	// Constructor --------------------------------------------------
	
	public CodeService(){
		super();
	}
	
	// Simple CRUD methods ------------------------------------------
	
	public Collection<Code> findByEventId(int eventId){
		
		return this.codeRepository.findByEvent(eventId);
	}
	
	public Code create(){
		// Reglas de negocio asociadas:
		//  - Debe ser creado automaticamente al realizar una reserva
		Code result;
		
		String alphanumericString = generateCode();
		
		result = new Code();
		result.setValue(alphanumericString);
		
		return result;
	}
	
	public Code save(Code code){
		// Reglas de negocio asociadas:
		// - El codigo pasado como parametro no puede ser null
		// - Debe de haber algun usuario autenticado para que pueda generarse el codigo de reserva
		
		Assert.notNull(code);
		
		Actor principal;
		
		principal = getUserPrincipal();
		
		Assert.notNull(principal);
		
		return codeRepository.saveAndFlush(code);
	}
	
	// Other business methods ---------------------------------------
	
	private Actor getUserPrincipal() {
		Actor principal;
		
		principal = actorService.findByPrincipal();
		
		return principal;
	}
	
	
	private String generateCode(){
		
		int[] digits;
		char[] characters;
		int randomNumber;
		String code = "";
		int character = 48;
		int tmp;
		
		digits = new int[10];
		characters = new char[59];
		
		for (int i1 = 0; i1 < 10; i1++) {
			digits[i1] = i1;
		}

		for (int i2 = 0; i2 < 25; i2++) {
			tmp = i2 + 65;
			characters[i2] = (char) tmp;
		}

		for (int i3 = 25; i3 < 50; i3++) {
			tmp = i3 + 72;
			characters[i3] = (char) tmp;
		}

		for (int i3 = 50; i3 < 59; i3++) {

			characters[i3] = (char) character;

			character++;
		}
		
		for (int i3 = 0; i3 < 3; i3++) {
			randomNumber = (int) Math.floor(Math.random()
					* (0 - digits.length) + digits.length);
			code = code + digits[randomNumber];
		}
		
		for (int i4 = 0; i4 < 5; i4++) {
			int valorEntero = (int) Math.floor(Math.random()
					* (0 - characters.length + 1) + characters.length);

			code = code + characters[valorEntero];
		}
		
		return code;	
	}
}
