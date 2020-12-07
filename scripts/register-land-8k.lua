require("scripts/postdata")

wrk.method = "POST"
wrk.headers["Content-Type"] = "application/json"
wrk.body = postdata.d8k1000101
