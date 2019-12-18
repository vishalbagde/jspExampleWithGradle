<%@page import="model.Person"%>
<%@page import="javax.persistence.Persistence"%>
<%@page import="javax.persistence.EntityManager"%>
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
<%

if(request.getParameter("person_id")!=null)
{
	EntityManagerFactory emf = Persistence.createEntityManagerFactory("pu");
	EntityManager em = emf.createEntityManager();
	
	em.getTransaction().begin();
	
	Person per =em.find(Person.class,Integer.parseInt(request.getParameter("person_id")));
	if(per!=null)
	{
		em.remove(per);
	}
	
	em.getTransaction().commit();
	
	em.close();
	emf.close();

	response.sendRedirect("display.jsp");

}

%>

</body>
</html>