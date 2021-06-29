package com.tf.crudmysql.loom;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.net.InetSocketAddress;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
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

		HttpServer server = HttpServer.create(new InetSocketAddress("localhost", 8080), 0);
		server.createContext("/", new CrudMySQLLoom());
		ExecutorService threadPoolExecutor = Executors.newVirtualThreadExecutor();
		server.setExecutor(threadPoolExecutor);
		server.start();
		System.out.println(" Server started on port 8080");
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
			String message = e.toString();
			httpExchange.sendResponseHeaders(500, message.length());
			outputStream.write(message.getBytes());
			System.out.println(message);
		}

		outputStream.flush();
		outputStream.close();
	}

	void get(HttpExchange httpExchange) throws IOException, SQLException {
		String path = httpExchange.getRequestURI().getPath();
		String id = path.substring(path.lastIndexOf('/')+1);
		OutputStream outputStream = httpExchange.getResponseBody();
		try (Connection connection = dataSource.getConnection(); PreparedStatement preparedStatement = connection.prepareStatement("SELECT * FROM user WHERE id=?");) {
			preparedStatement.setString(1, id);
			ResultSet resultSet = preparedStatement.executeQuery();
			if(resultSet.next()) {
				Map<String, Object> map = new HashMap<>();
				map.put("id", resultSet.getInt("id"));
			    map.put("name", resultSet.getString("name"));
			    map.put("description", resultSet.getString("description"));
			    String result = mapper.writeValueAsString(map);
			    httpExchange.sendResponseHeaders(200, result.length());
			    outputStream.write(result.getBytes());
			} else {
				httpExchange.sendResponseHeaders(404, "".length());
				outputStream.write("".getBytes());
			}
			resultSet.close();
		}
	}

	@SuppressWarnings("unchecked") void post(HttpExchange httpExchange) throws IOException, SQLException {
		OutputStream outputStream = httpExchange.getResponseBody();
		InputStream inputStreamBody = httpExchange.getRequestBody();
		Map<String, String> jsonMap = mapper.readValue(inputStreamBody, Map.class);
		String response = jsonMap.toString();
		try (Connection connection = dataSource.getConnection(); PreparedStatement preparedStatement = connection.prepareStatement("INSERT INTO user (name,description) values(?,?)");) {
			preparedStatement.setString(1, jsonMap.get("name"));
			preparedStatement.setString(2, jsonMap.get("description"));
			preparedStatement.execute();

			httpExchange.sendResponseHeaders(200, response.length());
			outputStream.write(response.getBytes());
		}
	}

	@SuppressWarnings("unchecked") void put(HttpExchange httpExchange) throws IOException, SQLException {
		OutputStream outputStream = httpExchange.getResponseBody();
		InputStream inputStreamBody = httpExchange.getRequestBody();
		String path = httpExchange.getRequestURI().getPath();
		String id = path.substring(path.lastIndexOf('/')+1);
		Map<String, String> jsonMap = mapper.readValue(inputStreamBody, Map.class);
		String response = jsonMap.toString();
		try (Connection connection = dataSource.getConnection(); PreparedStatement preparedStatement = connection.prepareStatement("UPDATE user set name=?,description=? WHERE id=?");) {
			preparedStatement.setString(1, jsonMap.get("name"));
			preparedStatement.setString(2, jsonMap.get("description"));
			preparedStatement.setString(3, id);
			preparedStatement.execute();

			httpExchange.sendResponseHeaders(200, response.length());
			outputStream.write(response.getBytes());
		}
	}

	void delete(HttpExchange httpExchange) throws IOException, SQLException {
		String path = httpExchange.getRequestURI().getPath();
		String id = path.substring(path.lastIndexOf('/')+1);
		OutputStream outputStream = httpExchange.getResponseBody();
		try (Connection connection = dataSource.getConnection(); PreparedStatement preparedStatement = connection.prepareStatement("DELETE FROM user WHERE id=?");) {
			preparedStatement.setString(1, id);
			preparedStatement.executeUpdate();
			httpExchange.sendResponseHeaders(200, "".length());
			outputStream.write("".getBytes());
		}
	}
}