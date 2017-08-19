package utilities.paypal;

public class Payer
{
    private String paymentMethod;

 
    public String getPaymentMethod() {
		return paymentMethod;
	}


	public void setPaymentMethod(String paymentMethod) {
		this.paymentMethod = paymentMethod;
	}


	@Override
    public String toString()
    {
        return "ClassPojo [payment_method = "+paymentMethod+"]";
    }
}