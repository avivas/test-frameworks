package com.tf.loom;

import java.io.IOException;
import java.io.OutputStream;
import java.net.InetSocketAddress;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

import com.sun.net.httpserver.HttpExchange;
import com.sun.net.httpserver.HttpHandler;
import com.sun.net.httpserver.HttpServer;

class HelloWorldHttpHandler implements HttpHandler {
	@Override public void handle(HttpExchange httpExchange) throws IOException {
		OutputStream outputStream = httpExchange.getResponseBody();
		String htmlResponse = "Hello world";
		httpExchange.sendResponseHeaders(200, htmlResponse.length());
		outputStream.write(htmlResponse.toString().getBytes());
		outputStream.flush();
		outputStream.close();
	}
}

public class JavaLoomHelloWorld {
	public static void main(String[] args) throws IOException {
		HttpServer server = HttpServer.create(new InetSocketAddress("localhost", 8084), 0);
		server.createContext("/", new HelloWorldHttpHandler());
		ExecutorService threadPoolExecutor = Executors.newVirtualThreadExecutor();
		server.setExecutor(threadPoolExecutor);
		server.start();
		System.out.println(" Server started on port 8084");
	}
}
