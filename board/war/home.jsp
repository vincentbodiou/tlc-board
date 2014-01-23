<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="java.util.List"%>
<%@ page import="javax.jdo.PersistenceManager"%>

<%@ page import="com.google.appengine.api.users.User"%>
<%@ page import="com.google.appengine.api.users.UserService"%>
<%@ page import="com.google.appengine.api.users.UserServiceFactory"%>

<%@ page import="fr.istic.tlc.Greeting"%>
<%@ page import="fr.istic.tlc.PMF"%>
<%@ page import="java.text.SimpleDateFormat" %>

<%
	UserService userService = UserServiceFactory.getUserService();
	User user = userService.getCurrentUser();
	if (user != null) {
%>
<p>
	Bonjour ,
	<%=user.getNickname()%>! (<a
		href="<%=userService.createLogoutURL(request.getRequestURI())%>">Deconnexion</a>.)
</p>

<input type="button" value="Ajouter une annonce" onclick="self.location.href='ajouter.jsp'"> 
<%
	PersistenceManager pm = PMF.get().getPersistenceManager();
		String query = "select from " + Greeting.class.getName();
		List<Greeting> greetings = (List<Greeting>) pm.newQuery(query)
				.execute();
		if (greetings.isEmpty()) {
%>
<p>Il n'y a aucun message.</p>
<%
	} else {
		SimpleDateFormat formater = new SimpleDateFormat("'le' dd/MM/yyyy 'à' hh:mm:ss");
		%>
		<table style="border-collapse: collapse;">
			<tr>
				   <th>Date</th>
			       <th>Auteur</th>
			       <th>Annonce</th>
			       <th>Prix</th>
	   		</tr>
		<%
			for (Greeting g : greetings) {
				if (g.getAuthor() == null) {
					%>
					<p>Un anonyme à écrit:</p>
					<%
						} else {
					%>						
							<tr style="border: 1px solid black;">
									<td><p style="font-size: 10px"><%=formater.format(g.getDate())%></td>
									<td><b><%=g.getAuthor().getNickname()%></b></td>															
									<td><%=g.getContent()%></td>									
									<td>Prix : <%=g.getPrice()%></td>
							</tr>
					<%
						}
			}
		%>
		</table>
		<%
		}
		pm.close();
	} else {
		%><p> Hello! <a href="<%=userService.createLoginURL(request.getRequestURI())%>">Sign in</a>
		 to include your name with greetings you post.</p>
		<%
	}
%>





