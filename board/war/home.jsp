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
		System.out.println(query);
		List<Greeting> greetings = (List<Greeting>) pm.newQuery(query)
				.execute();
		if (greetings.isEmpty()) {
%>
<p>Il n'y a aucun message.</p>
<%
	} else {
		SimpleDateFormat formaterJour = new SimpleDateFormat("'le' dd/MM/yyyy ");
		SimpleDateFormat formaterHeure = new SimpleDateFormat("'à' hh:mm:ss");
		%>
		<table  class="tableau">
			<tr style="border:none;">
				   <th>Date</th>
			       <th>Annonce</th>			      
	   		</tr>
		<%
			for (Greeting g : greetings) {
				if (g.getAuthor() == null) {
					%>
					<p>Un anonyme à écrit:</p>
					<%
						} else {
					%>						
							<tr>
									<td class="colonneDate">
										<span class="Datejour"><%=formaterJour.format(g.getDate())%></span>
										<span class="DateHeure"><%=formaterHeure.format(g.getDate())%></span>
									</td>
									<td class="colonneInfo">																							
										<span class="content"><%=g.getContent()%></span>
										<span class="auteur"><%=g.getAuthor().getNickname()%></span>									
										<span class="prix">Prix : <%=g.getPrice()%></span>
									</td>
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





