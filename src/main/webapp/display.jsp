<%@page import="model.PersonName"%>
<%@page import="model.Person"%>
<%@page import="model.Address"%>
<%@page import="javax.persistence.Persistence"%>
<%@page import="javax.persistence.EntityManager"%>
<%@page import="javax.persistence.EntityManagerFactory"%>
<%@page import="java.util.List"%>
<%@page import="javax.persistence.Query"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%@include file="header.jsp"%>

	<table border=1>
		<tr>
			<th>ID</th>
			<th>First Name</th>
			<th>Middle Name</th>
			<th>Last Name</th>
			<th>Email</th>
			<th>Ploat No</th>
			<th>Area</th>
			<th>Street</th>
			<th>City</th>
			<th>Show Contact</th>
			<th>Update</th>
			<th>Delete</th>
		</tr>

		<%
			EntityManagerFactory emf = Persistence.createEntityManagerFactory("pu");
			EntityManager em = emf.createEntityManager();
			Query q = em.createQuery("from Person", Person.class);
			List<Person> per = q.getResultList();
			
			for (Person person : per) {
				out.println("<tr>");
				PersonName pn = person.getPersonName();
				Address adr = person.getAddress();
				
				out.println("<td>"+person.getPerson_id()+"</td>");
				out.println("<td>"+pn.getFname()+"</td>");
				out.println("<td>"+pn.getMname()+"</td>");
				out.println("<td>"+pn.getLname()+"</td>");
				out.println("<td>"+person.getEmail()+"</td>");
				out.println("<td>"+adr.getPloat_no()+"</td>");
				out.println("<td>"+adr.getArea()+"</td>");
				out.println("<td>"+adr.getStreet()+"</td>");
				out.println("<td>"+adr.getCity()+"</td>");
				out.println("<td><a href='showContact.jsp?person_id="+person.getPerson_id()+"' >show Contact</td>");
				out.println("<td><a href='update.jsp?person_id="+person.getPerson_id()+"' >Update</td>");
				out.println("<td><a href='delete.jsp?person_id="+person.getPerson_id()+"' >Delete</td>");
				
				out.println("</tr>");
				
					
				
				
			}
		%>


	</table>


	<%@include file="footer.jsp"%>
</body>
</html>