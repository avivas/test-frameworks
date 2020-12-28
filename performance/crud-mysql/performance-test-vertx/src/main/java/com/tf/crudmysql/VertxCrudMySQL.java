package com.tf.crudmysql;

import io.vertx.core.AbstractVerticle;
import io.vertx.core.DeploymentOptions;
import io.vertx.core.Vertx;
import io.vertx.core.http.HttpMethod;
import io.vertx.core.http.HttpServer;
import io.vertx.core.json.JsonObject;
import io.vertx.ext.web.Router;
import io.vertx.ext.web.RoutingContext;
import io.vertx.ext.web.handler.BodyHandler;
import io.vertx.mysqlclient.MySQLConnectOptions;
import io.vertx.mysqlclient.MySQLPool;
import io.vertx.sqlclient.PoolOptions;
import io.vertx.sqlclient.Row;
import io.vertx.sqlclient.Tuple;

public class VertxCrudMySQL extends AbstractVerticle {
	private static MySQLPool client;
	public static void main(String[] args) {
		MySQLConnectOptions connectOptions = new MySQLConnectOptions().setPort(23306).setHost("127.0.0.1").setDatabase("crud").setUser("user").setPassword("password");
		PoolOptions poolOptions = new PoolOptions().setMaxSize(100);
		client = MySQLPool.pool(connectOptions, poolOptions);
		DeploymentOptions deploymentOptions = new DeploymentOptions().setInstances(12);
		Vertx.vertx().deployVerticle(VertxCrudMySQL.class,deploymentOptions);
	}
	@Override public void start() throws Exception {
		HttpServer server = getVertx().createHttpServer();
		Router router = Router.router(getVertx());
		router.route().handler(BodyHandler.create());
		router.route(HttpMethod.POST, "/").handler(this::post);
		router.route(HttpMethod.GET, "/:id").handler(this::get);
		router.route(HttpMethod.PUT, "/:id").handler(this::put);
		router.route(HttpMethod.DELETE, "/:id").handler(this::delete);
		server.requestHandler(router).listen(8081, (result) -> System.out.println(result.succeeded() ? "Inicio exitoso" : "Error al iniciar") );
	}
	void post(RoutingContext routingContext) {
		JsonObject json = routingContext.getBodyAsJson();
		Tuple tuple = Tuple.of(json.getValue("name"), json.getValue("description"));
		client.preparedQuery("INSERT INTO user (name,description) values(?,?) ").execute(tuple, ar -> {
			if (ar.succeeded()) {
				routingContext.response().setStatusCode(201).end(json.encode());
			} else {
				routingContext.response().end(ar.cause().getMessage());
			} });
	}
	void get(RoutingContext routingContext) {
		client.preparedQuery("SELECT id,name,description FROM user WHERE id=?").execute(Tuple.of(routingContext.request().getParam("id")), ar -> {
			if (ar.succeeded()) {
				JsonObject json = new JsonObject();
				if (ar.result().size() > 0) {
					Row row = ar.result().iterator().next();
					json.put("id", row.getLong("id")).put("description", row.getString("description")).put("name", row.getString("name"));
					routingContext.response().end(json.encode());
				} else {
					routingContext.response().setStatusCode(404).end("");
				}
			} else {
				routingContext.response().end(ar.cause().getMessage());
			} });
	}
	void put(RoutingContext routingContext) {
		JsonObject json = routingContext.getBodyAsJson();
		Tuple tuple = Tuple.of(json.getValue("name"), json.getValue("description"), routingContext.request().getParam("id"));
		client.preparedQuery("UPDATE user set name=?,description=? WHERE id=?").execute(tuple, ar -> {
			if (ar.succeeded()) {
				routingContext.response().end(json.encode());
			} else {
				routingContext.response().end(ar.cause().getMessage());
			} });
	}
	void delete(RoutingContext routingContext) {
		Tuple tuple = Tuple.of(routingContext.request().getParam("id"));
		client.preparedQuery("DELETE FROM user WHERE id=?").execute(tuple, ar -> {
			if (ar.succeeded()) {
				routingContext.response().end("");
			} else {
				routingContext.response().end(ar.cause().getMessage());
			} });
	}
}
