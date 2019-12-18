<%@page import="java.util.List"%>
<%@page import="model.Contact"%>
<%@page import="model.Person"%>
<%@page import="model.Phone"%>
<%@page import="javax.persistence.Query"%>
<%@page import="javax.persistence.EntityManager"%>
<%@page import="javax.persistence.Persistence"%>
<%@page import="javax.persistence.EntityManagerFactory"%>
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
			<th>Contact Type</th>
			<th>Service Provider</th>
			<th>Contact No.</th>
		</tr>

		<%
			EntityManagerFactory emf = Persistence.createEntityManagerFactory("pu");
			EntityManager em = emf.createEntityManager();
			Person person = em.find(Person.class, Integer.parseInt(request.getParameter("person_id")));
			
			List<Phone> phone = person.getPhone();
			
			
			for (Phone ph : phone) {
				
				out.println("<tr>");
				Contact contact = ph.getContact();
				
				out.println("<td>"+ph.getPhone_id()+"</td>");
				out.println("<td>"+ph.getPhone_type()+"</td>");
				out.println("<td>"+ph.getService_provider()+"</td>");
				out.println("<td>"+contact.getPhone_no()+"</td>");
				
				out.println("</tr>");
				
					
				
				
			}
		%>


	</table>


	<%@include file="footer.jsp"%>



</body>
</html>