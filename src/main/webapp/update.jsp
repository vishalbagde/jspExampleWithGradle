<%@page import="model.Person"%>
<%@page import="model.PersonName"%>
<%@page import="javax.persistence.EntityManagerFactory"%>
<%@page import="javax.persistence.Persistence"%>
<%@page import="model.Address"%>
<%@page import="javax.persistence.Query"%>
<%@page import="javax.persistence.EntityManager"%>
<%@page import="java.util.*"%>



<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Update Person Details</title>
</head>
<body>

	<%
		EntityManagerFactory emf = Persistence.createEntityManagerFactory("pu");
		EntityManager em = emf.createEntityManager();
		Person per;
		PersonName pn;
		Address address;

		if (request.getParameter("person_id")!= null) {

			out.print("person_id call");
			em.getTransaction().begin();

			per = em.find(Person.class, Integer.parseInt(request.getParameter("person_id")));
			session.setAttribute("per",per);
			pn = per.getPersonName();
			address = per.getAddress();

	%>


	<form method="post">
		<%@include file="header.jsp"%>
		<table border=1 width="500px">
			<tr>
				<th colspan="2">Person Details Update</th>
			<tr>
				<td>First Name</td>
				<td><input type="text" name="fname"
					value="<%out.print(pn.getFname());%>" /></td>
			</tr>
			<tr>
				<td>Moddile Name</td>
				<td><input type="text" name="mname"
					value="<%out.print(pn.getMname());%>" /></td>
			</tr>
			<tr>
				<td>Last Name</td>
				<td><input type="text" name="lname"
					value="<%out.print(pn.getLname());%>" /></td>
			</tr>
			<tr>
				<td>Email</td>
				<td><input type="text" name="email"
					value="<%out.print(per.getEmail());%>" /></td>
			</tr>

			<tr>
				<td>Address</td>
				<td>
					<table>
						<tr>
							<td>Ploat No.</td>
							<td><input type="text" name="ploatno"
								value="<%out.print(address.getPloat_no());%>" /></td>
						</tr>
						<tr>
							<td>Area Name.</td>
							<td><input type="text" name="area"
								value="<%out.print(address.getArea());%>" /></td>
						</tr>
						<tr>
							<td>Street.</td>
							<td><input type="text" name="street"
								value="<%out.print(address.getStreet());%>" /></td>
						</tr>
						<tr>
							<td>City.</td>
							<td><input type="text" name="city"
								value="<%out.print(address.getCity());%>" /></td>
						</tr>
					</table>
				</td>
			</tr>

			<tr>
				<td>
				<td><input type="submit" name="update" value="Update" /> <input
					type="reset" name="reset" value="reset" /></td>
				</td>

			</tr>
		</table>
	</form>
</body>
</html>


<%
	}
%>

<%
	if (request.getParameter("update") != null) {
		per=(Person)session.getAttribute("per");
		address = per.getAddress();
		pn=per.getPersonName();
		out.println(per.getEmail());
		
			
			pn.setFname(request.getParameter("fname"));
			pn.setMname(request.getParameter("mname"));
			pn.setLname(request.getParameter("lname"));
			
			per.setEmail(request.getParameter("email"));
			per.setPersonName(pn);
			
			address.setPloat_no(Integer.parseInt(request.getParameter("ploatno")));
			address.setArea(request.getParameter("area"));
			address.setStreet(request.getParameter("street"));
			address.setCity(request.getParameter("city"));
			
			em.persist(address);
			per.setAddress(address);
				
			em.persist(per);
			
			em.getTransaction().commit();
			em.close();
			emf.close();
			
			out.println("<script>alert('Update successful')</script>");
			response.sendRedirect("display.jsp");
		
		
	}
%>