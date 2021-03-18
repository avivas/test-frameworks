package com.tf.crudmysql.loom;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.net.InetSocketAddress;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Map;
import java.util.Properties;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

import javax.sql.DataSource;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.sun.net.httpserver.HttpExchange;
import com.sun.net.httpserver.HttpHandler;
import com.sun.net.httpserver.HttpServer;
import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;

public class CrudMySQLLoom implements HttpHandler {
	private static DataSource dataSource;
	private static ObjectMapper mapper = new ObjectMapper();

	public static void main(String[] args) throws IOException, ClassNotFoundException, SQLException {
		Properties properties = new Properties();
		properties.load(CrudMySQLLoom.class.getResourceAsStream("/hikari.properties"));
		properties.put("dataSource.logWriter", new PrintWriter(System.out));
		HikariConfig config = new HikariConfig(properties);
		System.out.println(config.getMaximumPoolSize());
		dataSource = new HikariDataSource(config);

		HttpServer server = HttpServer.create(new InetSocketAddress("localhost", 8085), 0);
		server.createContext("/", new CrudMySQLLoom());
		ExecutorService threadPoolExecutor = Executors.newVirtualThreadExecutor();
		threadPoolExecutor = Executors.newFixedThreadPool(1000);
		server.setExecutor(threadPoolExecutor);
		server.start();
		System.out.println(" Server started on port 8085");
	}

	@Override public void handle(HttpExchange httpExchange) throws IOException {
		OutputStream outputStream = httpExchange.getResponseBody();
		try {

			switch (httpExchange.getRequestMethod().toUpperCase()) {
			case "GET":
				get(httpExchange);
				break;
			case "POST":
				post(httpExchange);
				break;
			case "PUT":
				put(httpExchange);
				break;
			case "DELETE":
				delete(httpExchange);
				break;
			default:
				get(httpExchange);
			}
		} catch (Exception e) {
			outputStream.write(e.toString().getBytes());
		}

		outputStream.flush();
		outputStream.close();
	}

	void get(HttpExchange httpExchange) throws IOException {
		OutputStream outputStream = httpExchange.getResponseBody();
		String htmlResponse = "GET";
		httpExchange.sendResponseHeaders(200, htmlResponse.length());
		outputStream.write(htmlResponse.toString().getBytes());
	}
	
	String response = "OK";

	@SuppressWarnings("unchecked") void post(HttpExchange httpExchange) throws IOException, SQLException {
		OutputStream outputStream = httpExchange.getResponseBody();
		InputStream inputStreamBody = httpExchange.getRequestBody();
		Map<String, String> jsonMap = mapper.readValue(inputStreamBody, Map.class);
		try (Connection connection = dataSource.getConnection();
			PreparedStatement preparedStatement = connection.prepareStatement("INSERT INTO user (name,description) values(?,?)");) {
			preparedStatement.setString(1, jsonMap.get("name"));
			preparedStatement.setString(2, jsonMap.get("description"));
			preparedStatement.execute();
			
			httpExchange.sendResponseHeaders(200, response.length());
			outputStream.write(response.toString().getBytes());
		}
	}

	void put(HttpExchange httpExchange) throws IOException {
		OutputStream outputStream = httpExchange.getResponseBody();
		String htmlResponse = "PUT";
		httpExchange.sendResponseHeaders(200, htmlResponse.length());
		outputStream.write(htmlResponse.toString().getBytes());
	}

	void delete(HttpExchange httpExchange) throws IOException {
		OutputStream outputStream = httpExchange.getResponseBody();
		String htmlResponse = "DELETE";
		httpExchange.sendResponseHeaders(200, htmlResponse.length());
		outputStream.write(htmlResponse.toString().getBytes());
	}
}