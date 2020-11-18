package com.tf.crudmysql;

import java.util.Optional;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.data.repository.CrudRepository;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.transaction.annotation.EnableTransactionManagement;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import lombok.Getter;
import lombok.Setter;

@RestController
@EnableTransactionManagement
@SpringBootApplication
public class SpringBootCrudMySQL {
	@Setter
	@Getter
	@Entity
	@Table
	static class User {
		@Id @GeneratedValue(strategy = GenerationType.AUTO) private Long id;
		@Column private String name;
		@Column private String description;
	}

	@Autowired private UserRepository userRepository;

	@PostMapping("/") ResponseEntity<User> post(@RequestBody User user) {
		this.userRepository.save(user);
		return new ResponseEntity<SpringBootCrudMySQL.User>(user, HttpStatus.CREATED);
	}
	
	@GetMapping("/{id}") ResponseEntity<Optional<User>> get(@PathVariable("id") Long id) {
		return new ResponseEntity<Optional<User>>(this.userRepository.findById(id), HttpStatus.OK);
	}

	@PutMapping("/{id}") ResponseEntity<User> put(@PathVariable("id") Long id, @RequestBody User user) {
		user.setId(id);
		this.userRepository.save(user);
		return new ResponseEntity<User>(user, HttpStatus.OK);
	}

	@DeleteMapping("/{id}") ResponseEntity<Void> delete(@PathVariable("id") Long id) {
		this.userRepository.deleteById(id);
		return new ResponseEntity<Void>(HttpStatus.OK);
	}

	public static void main(String[] args) {
		SpringApplication.run(SpringBootCrudMySQL.class, args);
	}
}

interface UserRepository extends CrudRepository<SpringBootCrudMySQL.User, Long> {
}