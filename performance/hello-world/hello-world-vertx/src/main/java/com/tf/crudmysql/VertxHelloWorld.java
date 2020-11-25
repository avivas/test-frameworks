package com.tf.crudmysql;

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
		DeploymentOptions deploymentOptions = new DeploymentOptions();
        deploymentOptions.setInstances(12);
		Vertx vertx = Vertx.vertx();
		vertx.deployVerticle(VertxHelloWorld.class,deploymentOptions);
	}

	@Override public void start() throws Exception {
		Vertx vertx = getVertx();

		HttpServer server = vertx.createHttpServer();
		Router router = Router.router(vertx);
		router.route().handler(BodyHandler.create());

		router.route(HttpMethod.GET, "/").handler(this::get);

		server.requestHandler(router).listen(8081, (result) -> System.out.println(result.succeeded() ? "Inicio exitoso" : "Error al iniciar") );
	}
	
	void get(RoutingContext routingContext) {
		routingContext.response().end("Hello world");
	}
}
