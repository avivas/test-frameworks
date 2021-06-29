
wrk.scheme  = "http"
wrk.host    = "127.0.0.1"
wrk.port    = 8081
wrk.method  = "POST"
wrk.path    = "/"
wrk.headers["Content-Type"]="application/json"
wrk.body    = '{"description":"description","name":"name"}'
