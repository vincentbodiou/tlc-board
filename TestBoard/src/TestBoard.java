import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.URL;


public class TestBoard {

	public static void main(String[] args) throws Exception
	  {
	 
	    for (int i = 0; i < 50; i++)
	    {
	    	long tempsDebut = System.currentTimeMillis();
	        URL oracle = new URL("http://tlc-board.appspot.com/guestbook.jsp");
	        BufferedReader in = new BufferedReader(
	        new InputStreamReader(oracle.openStream()));

	        String inputLine;
	        while ((inputLine = in.readLine()) != null)
	        {}
	        in.close();
	        long tempsFin = System.currentTimeMillis();
	        System.out.println(Float.toString((tempsFin - tempsDebut)));
	    }
	  
	  }

}
