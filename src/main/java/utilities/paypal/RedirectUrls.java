package utilities.paypal;

public class RedirectUrls
{
    private String cancelUrl;

    private String returnUrl;

   

    public String getCancelUrl() {
		return cancelUrl;
	}



	public void setCancelUrl(String cancelUrl) {
		this.cancelUrl = cancelUrl;
	}



	public String getReturnUrl() {
		return returnUrl;
	}



	public void setReturnUrl(String returnUrl) {
		this.returnUrl = returnUrl;
	}



	@Override
    public String toString()
    {
        return "ClassPojo [cancel_url = "+cancelUrl+", return_url = "+returnUrl+"]";
    }
}