package com.tf.helloworld.vertex;

import io.vertx.core.AbstractVerticle;
import io.vertx.core.DeploymentOptions;
import io.vertx.core.Vertx;
import io.vertx.core.http.HttpMethod;
import io.vertx.core.http.HttpServer;
import io.vertx.ext.web.Router;
import io.vertx.ext.web.RoutingContext;
import io.vertx.ext.web.handler.BodyHandler;

public class VertxHelloWorld extends AbstractVerticle {
	public static void main(String[] args) {
		DeploymentOptions deploymentOptions = new DeploymentOptions().setInstances(12);
		Vertx.vertx().deployVerticle(VertxHelloWorld.class,deploymentOptions);
	}
	@Override public void start() throws Exception {
		HttpServer server = getVertx().createHttpServer();
		Router router = Router.router(getVertx());
		router.route().handler(BodyHandler.create());
		router.route(HttpMethod.GET, "/").handler(this::get);
		server.requestHandler(router).
		listen(8080, (result) -> System.out.println(result.succeeded() ? "Inicio exitoso" : "Error al iniciar") );
	}
	void get(RoutingContext routingContext) {
		routingContext.response().end("Hello world");
	}
}
