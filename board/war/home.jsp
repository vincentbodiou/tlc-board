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

<form action="/sign" method="post" enctype='multipart/form-data'>
	
	<table id="tableAnnonce" name="tableAnnonce"> 
	<thead>	
	<tr>
		<td>
			Votre annonce
		</td>
		<td>
			Prix
		</td>
	</tr>
	</thead>
	<tbody id="body" >
	<td>
		<input type="text" value="toto" name="titi"/>
	</td>
	</tbody>
	</table>
	
	<div>
		Votre annonce : <br></b><textarea id ="annonce" name="contentInput" rows="3" cols="60"></textarea>
	</div>
	<div>
		Prix : <input name="priceInput" id="prix" type="text" placeholder="prix"></input>
	</div>
	
	<div>
		<input type="submit" value="Publier" />
	</div>
	<div>
		<input type="button" value="Ajouter" onClick="javascript:addRow('tableAnnonce');" />
	</div>
	
	<script type="text/javascript">
	function addRow(tableau){
		
		var ad = document.getElementById('annonce');
		var price = document.getElementById('prix');		
	    tableau = document.getElementById(tableau);
	    var body = document.getElementById("body");
	     
	    var tr = document.createElement('tr'); //On créé une ligne d'annonce
	    //On ajoute autant les cellules
	    
	    var td = document.createElement('td');
        tr.appendChild(td);
        td.innerHTML = ad.value + " <input name='i' type=\"hidden\" value='"+ad.value+"' /> ";
        
        var td = document.createElement('td');
        tr.appendChild(td);
        td.innerHTML = price.value;
        
        ad.value = "";
        price.value = "";        

	    body.appendChild(tr);
	}
</script>
</form>
<%
		PersistenceManager pm = PMF.get().getPersistenceManager();
		String query = "select from " + Greeting.class.getName() +" ANCESTOR IS " + user;//+ " where author.email=='test@example.com'" ;
		System.out.println(user.getNickname());
		
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
				if (g.getAuthor() != null) {
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





