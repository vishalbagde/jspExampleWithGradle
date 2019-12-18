package model;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;

@Entity
public class Address {
	
	@Id
	@GeneratedValue
	int address_id;
	int ploat_no;
	String area;
	String street;
	String city;
	
	@OneToMany
	List<Person> person=new ArrayList<Person>();
	
	
	public Address() {
		super();
	}
	public Address(int address_id, int ploat_no, String area, String street, String city) {
		super();
		this.address_id = address_id;
		this.ploat_no = ploat_no;
		this.area = area;
		this.street = street;
		this.city = city;
	}
	public int getAddress_id() {
		return address_id;
	}
	public void setAddress_id(int address_id) {
		this.address_id = address_id;
	}
	public int getPloat_no() {
		return ploat_no;
	}
	public void setPloat_no(int ploat_no) {
		this.ploat_no = ploat_no;
	}
	public String getArea() {
		return area;
	}
	public void setArea(String area) {
		this.area = area;
	}
	public String getStreet() {
		return street;
	}
	public void setStreet(String street) {
		this.street = street;
	}
	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}
	
	
	

}
