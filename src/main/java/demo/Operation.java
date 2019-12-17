package demo;

import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.Query;

import model.Address;
import model.Contact;
import model.Person;
import model.PersonName;
import model.Phone;

public class Operation {
	

	public static void main(String[] args) {
		int ch;
		
		EntityManagerFactory emf = Persistence.createEntityManagerFactory("pu");
		EntityManager em = emf.createEntityManager();

		do {
			Scanner in = new Scanner(System.in);
			System.out.println("1.INSERT");
			System.out.println("2.UPDATE");
			System.out.println("3.DELETE");
			System.out.println("4.DISPLAY");
			System.out.println("5.EXIT");
			System.out.print("Select Option:");
			ch = in.nextInt();

			switch (ch) {
			case 1:
				em.getTransaction().begin();

				System.out.println("INSERT");

				Person per = new Person();
				PersonName pname = new PersonName();
				System.out.println("Enter First Name:");
				pname.setFname(in.next());
				System.out.println("Enter Middle Name:");
				pname.setMname(in.next());
				System.out.println("Enter Last Name:");
				pname.setLname(in.next());

				per.setPersonName(pname);

				System.out.println("Enter Email:");
				per.setEmail(in.next());
	
				System.out.println("1.select Reference");
				System.out.println("2.New Address");
				System.out.print("select Address Option :");
				int addr = in.nextInt();
				if (addr == 1) {
					Address address1 = new Address();
					
					Query q = em.createQuery("from Address",Address.class);
					List<Address> adr = q.getResultList();	
					
					System.out.println("\nAddress id \t Area \t Street \t city");
					for(Address a:adr)
					{
						System.out.print(a.getAddress_id()+"\t");
						System.out.print(a.getArea()+"\t");
						System.out.print(a.getStreet()+"\t");
						System.out.println(a.getCity()+"\t");
					}
					
					System.out.print("select Address Id :");
					int address_id = in.nextInt();
					address1=em.find(Address.class,address_id);
					per.setAddress(address1);
					
				} else {

					Address address = new Address();
					System.out.println("Enter Ploat No.:");
					address.setPloat_no(in.nextInt());

					System.out.println("Enter Area:");
					address.setArea(in.next());

					System.out.println("Enter Street:");
					address.setStreet(in.next());

					System.out.println("Enter City:");
					address.setCity(in.next());

					em.persist(address);
					per.setAddress(address);

				}

				
				List<Phone> phone = new ArrayList<Phone>();

				boolean pcheck = true;
				do {
					Phone p = new Phone();
					System.out.println("Enter Phone Type:");
					p.setPhone_type(in.next());

					System.out.println("Enter Service Provider:");
					p.setService_provider(in.next());

					Contact c = new Contact();
					System.out.println("Enter phone number:");
					c.setPhone_no(in.next());

					p.setContact(c);

					em.persist(c);

					phone.add(p);

					em.persist(p); // persist

					System.out.print("You have another phone (Y=1 OR N=0) : ");
					int check = in.nextInt();
					if (check == 1)
						pcheck = true;
					else
						pcheck = false;

				} while (pcheck != false);

				per.setPhone(phone);

				em.persist(per);
				em.getTransaction().commit();

				break;
			case 2:	
				//update
				break;
			case 3:

				em.getTransaction().begin();

				System.out.println("Delete");
				System.out.println("Enter person_Id");
				int p_id = in.nextInt();
				Person pr = em.find(Person.class, p_id);
				if (pr == null) {
					System.out.println("invalid Person id");
				} else {
					em.remove(pr);
					em.getTransaction().commit();
				}
				break;
			case 4:
				try {
					System.out.println("Display");
					System.out.println("Enter person_Id");
					int per_id = in.nextInt();
					Person p = em.find(Person.class, per_id);
					if (p == null) {
						System.out.println("invalid Person id");
					} else {
						System.out.println("\nP id \t Fname \t Mname \t LName \t Email  \n");
						System.out.println("------------------------------------------------");
						PersonName pn = p.getPersonName();
						System.out.print(p.getPerson_id() + "\t");
						System.out.print(pn.getFname() + "\t");
						System.out.print(pn.getMname() + "\t");
						System.out.print(pn.getLname() + "\t");
						System.out.println(p.getEmail());

						Address ad = p.getAddress();
						System.out.println("\nPloat No\t Area \t Street \t City  \n");
						System.out.println("------------------------------------------------");
						System.out.print(ad.getPloat_no() + "\t");
						System.out.print(ad.getArea() + "\t");
						System.out.print(ad.getStreet() + "\t");
						System.out.print(ad.getCity() + "\t");

						List<Phone> plist = p.getPhone();

						System.out.println("\nPhone Type\t service Provider \t phone No \n");
						System.out.println("------------------------------------------");

						for (Phone ph : plist) {
							Contact cn = ph.getContact();
							System.out.print(ph.getPhone_type() + "\t");
							System.out.print(ph.getService_provider() + "\t");
							System.out.println(cn.getPhone_no() + "\t");

						}

					}
				} catch (Exception e) {
					System.out.println(e.fillInStackTrace().toString());
				}

				break;
			case 5:

				System.out.println("Exit");
				break;
			default:

			}

		} while (ch != 5);
		em.close();
		emf.close();

	}

}
