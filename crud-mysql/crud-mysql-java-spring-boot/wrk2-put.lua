
wrk.scheme  = "http"
wrk.host    = "127.0.0.1"
wrk.port    = 8080
wrk.method  = "PUT"
wrk.path    = "/1"
wrk.headers["Content-Type"]="application/json"
wrk.body    = '{"description":"description-put","name":"name-put"}'
