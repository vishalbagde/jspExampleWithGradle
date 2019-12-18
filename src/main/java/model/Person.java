package model;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.SequenceGenerator;
import javax.xml.ws.Action;

import org.hibernate.annotations.Cascade;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

@Entity
public class Person {
	
	@Id
	@GeneratedValue(generator = "person_sequence",strategy = GenerationType.SEQUENCE)
	@SequenceGenerator(sequenceName = "person_sequence",allocationSize = 1,initialValue = 0, name = "person" )
	int person_id;
	
	String person_key;
	
	PersonName personName;
	String email;
	
	@ManyToOne
	Address address;
	
	@OneToMany (fetch = FetchType.EAGER,cascade = CascadeType.REMOVE,orphanRemoval = true)
	List<Phone> phone=new ArrayList<Phone>();

	public Person(int person_id, PersonName personName, String email, Address address,
			List<Phone> phone) {
		super();
		this.person_id = person_id;
		this.personName = personName;
		this.email = email;
	
		this.address = address;
		this.phone = phone;
	}

	public Person() {
		super();
	}

	public int getPerson_id() {
		return person_id;
	}

	public void setPerson_id(int person_id) {
		this.person_id = person_id;
	}

	public PersonName getPersonName() {
		return personName;
	}

	public void setPersonName(PersonName personName) {
		this.personName = personName;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	

	public Address getAddress() {
		return address;
	}

	public void setAddress(Address address) {
		this.address = address;
	}

	public List<Phone> getPhone() {
		return phone;
	}

	public void setPhone(List<Phone> phone) {
		this.phone = phone;
	}

	@Override
	public String toString() {
		return "Person [person_id=" + person_id + ", personName=" + personName + ", email=" + email + ", address=" + address + ", phone=" + phone + "]";
	}
	
	
	
	
	
	
	
	
}
