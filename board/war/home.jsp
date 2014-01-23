<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="javax.jdo.PersistenceManager" %>

<%@ page import="com.google.appengine.api.users.User" %>
<%@ page import="com.google.appengine.api.users.UserService" %>
<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>

<%@ page import="fr.istic.tlc.Greeting" %>
<%@ page import="fr.istic.tlc.PMF" %>

<%
	UserService userService = UserServiceFactory.getUserService();
	User user = userService.getCurrentUser();
	if (user != null) {
%>
<p>
	Bonjour ,
	<%=user.getNickname()%>! (<a href="<%=userService.createLogoutURL(request.getRequestURI())%>">Deconnexion</a>.)
</p>
<%
	} else {
%>
<p>
	Hello! <a
		href="<%=userService.createLoginURL(request.getRequestURI())%>">Sign
		in</a> to include your name with greetings you post.
</p>
<%
	}
%>

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
		for (Greeting g : greetings) {
			if (g.getAuthor() == null) {
%>
<p>Un anonyme à écrit:</p>
<%
	} else {
%>
<div style="border: 1px solid black">
	<p>
		<b><%=g.getAuthor().getNickname()%></b> à écrit :
	<p style="font-size: 10px"><%=g.getDate()%></p>


	<%
	}
%>
<blockquote><%=g.getContent()%></blockquote>
<div>Prix : <%=g.getPrice()%></div>
</div>
<%
	}
	}
	pm.close();
%>
<input type="button" value="Ajouter une annonce" onclick="self.location.href='ajouter.jsp'" >


