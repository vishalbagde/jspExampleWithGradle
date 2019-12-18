<%@page import="model.Contact"%>
<%@page import="model.Phone"%>
<%@page import="model.PersonName"%>
<%@page import="model.Person"%>
<%@page import="java.util.List"%>
<%@page import="model.Address"%>
<%@page import="javax.persistence.Query"%>
<%@page import="javax.persistence.EntityManager"%>
<%@page import="javax.persistence.EntityManagerFactory"%>
<%@page import="javax.persistence.Persistence"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Contact Add</title>
</head>
<body>

	<form method="post">
		<%@include file="header.jsp"%>
		<table border=1 width="500px">
			<tr>
				<th colspan="2">Person Contact Add</th>
			</tr>

			<tr>
				<td>User</td>
				<td>
					<%
						EntityManagerFactory emf = Persistence.createEntityManagerFactory("pu");
						EntityManager em = emf.createEntityManager();
						
						
						Query q = em.createQuery("from Person", Person.class);
						List<Person> per = q.getResultList();

						out.println("<select name='person_id' width='200px'>");
						for (Person person : per) {
							PersonName pn = person.getPersonName();
							out.println("<option value=" + person.getPerson_id() + "> " + pn.getFname() + " " + pn.getMname() + " "
									+ pn.getLname() + " </option> ");
						}
						out.println("</select>");
						
											
						em.close();
						emf.close();
					%>
				</td>
			</tr>
			<tr>
				<td>Contact Details</td>
				<td>
					<table>
						<tr>
							<td>Phone Type.</td>
							<td><input type="text" name="phone_type" /></td>
						</tr>
						<tr>
							<td>Service Provider.</td>
							<td><input type="text" name="service_provider" /></td>
						</tr>
						<tr>
							<td>Contact No.</td>
							<td><input type="text" name="contact_no" /></td>
						</tr>
					</table>
				</td>
			</tr>

			<tr>
				<td>
				<td><input type="submit" name="submit" value="Add" /> <input
					type="reset" name="reset" value="reset" /></td>
				</td>

			</tr>
		</table>
	</form>

</body>
</html>


<%
	if (request.getParameter("submit") != null) {
		
		
		emf = Persistence.createEntityManagerFactory("pu");
		em = emf.createEntityManager();
				
		int person_id = Integer.parseInt(request.getParameter("person_id"));
		Person person = em.find(Person.class,person_id);
		
		List<Phone> phonelist = person.getPhone();
		
		Phone phone =new Phone();
		

		phone.setPhone_type(request.getParameter("phone_type"));
		phone.setService_provider(request.getParameter("service_provider"));
		
		Contact contact=new Contact();
		contact.setPhone_no(request.getParameter("contact_no"));
		phone.setContact(contact);
		
		
		em.persist(phone);
		em.persist(contact);
		
		phonelist.add(phone);
		
		person.setPhone(phonelist);
		
				
		em.getTransaction().begin();
		
		em.persist(person);
		
		em.getTransaction().commit();
	

		out.println("<script>alert('contact Added successful')</script>");
		//response.sendRedirect("display.jsp");

	}
%>