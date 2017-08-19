package services;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import utilities.email.MailMail;;

public class EmailService {
	
	
	public EmailService(){
		super();
	}
	
	
	public void sendEmail(String destinatario,String asunto,String mensaje){
		ApplicationContext context = new ClassPathXmlApplicationContext("Spring-Mail.xml");

		MailMail mm = (MailMail) context.getBean("mailMail");
		
	   mm.sendMail("soportetourfriend@gmail.com", destinatario,asunto,mensaje);
	}
	
	
	

}
