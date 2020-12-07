-- example HTTP POST script which demonstrates setting the
-- HTTP method, body, and adding a header
wrk.method = "POST"
require("scripts/postdata")

wrk.method = "POST"
wrk.headers["Content-Type"] = "application/json"
wrk.body = postdata.d4k2000101
