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
<title>Insert title here</title>
</head>
<body>
<form method="post">
	<%@include file="header.jsp"%>
	<table border=1 width="500px">
		<tr>
			<th colspan="2">Person Details Insert</th>
		<tr>
			<td>First Name</td>
			<td><input type="text" name="fname" /></td>
		</tr>
		<tr>
			<td>Moddile Name</td>
			<td><input type="text" name="mname" /></td>
		</tr>
		<tr>
			<td>Last Name</td>
			<td><input type="text" name="lname" /></td>
		</tr>
		<tr>
			<td>Email</td>
			<td><input type="text" name="email" /></td>
		</tr>
		<tr>
			<td>Address</td>
			<td><input type="radio" name="radio_address" value="address_ref" checked />Address
				Reference <%
				EntityManagerFactory emf = Persistence.createEntityManagerFactory("pu");
				EntityManager em = emf.createEntityManager();
				
				Query q = em.createQuery("from Address", Address.class);
				List<Address> adr = q.getResultList();
				out.println("<select name='address_id'>");

				for (Address address : adr) {
					out.println("<option value=" + address.getAddress_id() + "> " + address.getPloat_no() + "-"
							+ address.getArea() + "-" + address.getCity() + " </option> ");
				}
				out.println("</select>");
			%></td>
		</tr>
		<tr>
			<td>Address</td>
			<td><input type="radio" name="radio_address"  value="address_new" />New Address
				<table>
					<tr>
						<td>Ploat No.</td>
						<td><input type="text" name="ploatno" /></td>
					</tr>
					<tr>
						<td>Area Name.</td>
						<td><input type="text" name="area" /></td>
					</tr>
					<tr>
						<td>Street.</td>
						<td><input type="text" name="street" /></td>
					</tr>
					<tr>
						<td>City.</td>
						<td><input type="text" name="city" /></td>
					</tr>
				</table></td>
		</tr>

		<tr>
			<td><td><input type="submit" name="submit" value="insert" />
			<input type="reset" name="reset" value="reset" /></td></td>

		</tr>
	</table>
	</form>
</body>
</html>

<%
if(request.getParameter("submit")!=null)
{
	
	em.getTransaction().begin();	
	Person per=new Person();
	PersonName pn=new PersonName();
	pn.setFname(request.getParameter("fname"));
	pn.setMname(request.getParameter("mname"));
	pn.setLname(request.getParameter("lname"));
	
	per.setEmail(request.getParameter("email"));
	per.setPersonName(pn);
	if(request.getParameter("radio_address").equals("address_ref"))
	{
		int address_id = Integer.parseInt(request.getParameter("address_id"));
		out.println(address_id);
		
		Address address1=em.find(Address.class,address_id);
		per.setAddress(address1);
		
	}
	if(request.getParameter("radio_address").equals("address_new"))
	{
		Address address1=new Address();
		address1.setPloat_no(Integer.parseInt(request.getParameter("ploatno")));
		address1.setArea(request.getParameter("area"));
		address1.setStreet(request.getParameter("street"));
		address1.setCity(request.getParameter("city"));
		
		em.persist(address1);
		
		per.setAddress(address1);
	}

	em.persist(per);
	
	em.getTransaction().commit();
	em.close();
	emf.close();
	
	out.println("<script>alert('person added successful')</script>");
	

}


%>