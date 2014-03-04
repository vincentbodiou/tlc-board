package fr.istic.tlc;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.logging.Logger;

import javax.jdo.PersistenceManager;
import javax.servlet.http.*;

import com.google.appengine.api.users.User;
import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;

public class SignGuestbookServlet extends HttpServlet {

	private static final long serialVersionUID = -4861102627005018652L;
	//private static final Logger log = Logger.getLogger(SignGuestbookServlet.class.getName());

    public void doPost(HttpServletRequest req, HttpServletResponse resp)
                throws IOException {
        UserService userService = UserServiceFactory.getUserService();
        User user = userService.getCurrentUser();

        String[] content = req.getParameterValues("content");
        if(content==null) 
        {
        	System.err.println("NULL");
        	resp.sendRedirect("/guestbook.jsp"); 
        	return;
        }
        System.out.println(content[0]);
        Date date = new Date();
        String[] price = req.getParameterValues("price");
        
        for(int i=0;i<content.length;i++)
        {        	
        	System.out.println(content[i]);
             System.out.println(price[i]);
        	Greeting greeting = new Greeting(user, content[i], price[i], date);
        	PersistenceManager pm = PMF.get().getPersistenceManager();
            try {
                pm.makePersistent(greeting);
            } finally {
                pm.close();
            }
        }
        
        resp.sendRedirect("/guestbook.jsp");
    }
}