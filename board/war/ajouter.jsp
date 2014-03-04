<form action="/sign" method="post">
	
	<table id="tableAnnonce" name="tableAnnonce"> 
	<thead>	
	<tr>
		<td>
			
		</td>
		<td>
			
		</td>
	</tr>
	</thead>
	<tbody id="body">
	<tr>
		<td>
			annonce
		</td>
		<td>
		</td>
		
		<td>
	</tr>
	</tbody>
	</table>
	
	<div>
		Votre annonce : <br></b><textarea id ="annonce" name="content[]" rows="3" cols="60"></textarea>
	</div>
	<div>
		Prix : <input name="price" id="prix" type="text" placeholder="prix"></input>
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
        td.innerHTML = ad.value;
        td.setAttribute("name", "content[]");
        
        var td = document.createElement('td');
        tr.appendChild(td);
        td.innerHTML = price.value;
        td.setAttribute("name", "price[]");
        
        ad.value = "";
        price.value = "";        

	    body.appendChild(tr);
	}
</script>
</form>