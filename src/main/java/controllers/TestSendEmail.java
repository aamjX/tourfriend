package controllers;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import services.EmailService;


@Controller
@RequestMapping("/email")
public class TestSendEmail {
	
	
	
	@RequestMapping(value = "/send")
	public ModelAndView sendMail() {
		ModelAndView m = new ModelAndView("redirect:/welcome/index.do");
		
		
		EmailService emailService = new EmailService();
		try{
			emailService.sendEmail("abarreraroldan@gmail.com", "Testin tourfriend", "Hola soy un mensaje de testing");
		}catch (Exception e) {
			e.printStackTrace();
			System.out.println("Fallo al enviar el email :S");
		}
		
		
		return m;

	}

}
