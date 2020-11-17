package com.tf.crudmysql;

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

public class VertxCrudMySQL {
	private static MySQLPool client;

	public static void main(String[] args) {
		Vertx vertx = Vertx.vertx();
		MySQLConnectOptions connectOptions = new MySQLConnectOptions().setPort(23306).setHost("127.0.0.1").setDatabase("crud").setUser("user").setPassword("password");
		PoolOptions poolOptions = new PoolOptions().setMaxSize(5);
		client = MySQLPool.pool(connectOptions, poolOptions);

		HttpServer server = vertx.createHttpServer();
		Router router = Router.router(vertx);
		router.route().handler(BodyHandler.create());

		router.route(HttpMethod.POST, "/").handler(VertxCrudMySQL::post);
		router.route(HttpMethod.GET, "/:id").handler(VertxCrudMySQL::get);
		router.route(HttpMethod.PUT, "/:id").handler(VertxCrudMySQL::put);
		router.route(HttpMethod.DELETE, "/:id").handler(VertxCrudMySQL::delete);

		server.requestHandler(router).listen(8080);
	}

	static void post(RoutingContext routingContext) {
		JsonObject json = routingContext.getBodyAsJson();
		Tuple tuple = Tuple.of(json.getValue("name"), json.getValue("description"));
		client.preparedQuery("INSERT INTO user (name,description) values(?,?) ").execute(tuple, ar -> {
			if (ar.succeeded()) {
				routingContext.response().setStatusCode(201);
				routingContext.response().end(json.encode());
			} else {
				routingContext.response().end(ar.cause().getMessage());
			}
		});
	}

	static void get(RoutingContext routingContext) {
		client.preparedQuery("SELECT id,name,description FROM user WHERE id=?").execute(Tuple.of(routingContext.request().getParam("id")), ar -> {
			if (ar.succeeded()) {
				JsonObject json = new JsonObject();
				if (ar.result().size() > 0) {
					Row row = ar.result().iterator().next();
					json.put("id", row.getLong("id"));
					json.put("description", row.getString("description"));
					json.put("name", row.getString("name"));
					routingContext.response().end(json.encode());
				} else {
					routingContext.response().setStatusCode(404);
					routingContext.response().end("");
				}
			} else {
				routingContext.response().end(ar.cause().getMessage());
			}
		});
	}

	static void put(RoutingContext routingContext) {
		JsonObject json = routingContext.getBodyAsJson();
		Tuple tuple = Tuple.of(json.getValue("name"), json.getValue("description"), routingContext.request().getParam("id"));
		client.preparedQuery("UPDATE user set name=?,description=? WHERE id=?").execute(tuple, ar -> {
			if (ar.succeeded()) {
				routingContext.response().end(json.encode());
			} else {
				routingContext.response().end(ar.cause().getMessage());
			}
		});
	}

	static void delete(RoutingContext routingContext) {
		Tuple tuple = Tuple.of(routingContext.request().getParam("id"));
		client.preparedQuery("DELETE FROM user WHERE id=?").execute(tuple, ar -> {
			if (ar.succeeded()) {
				routingContext.response().end("");
			} else {
				routingContext.response().end(ar.cause().getMessage());
			}
		});
	}
}
