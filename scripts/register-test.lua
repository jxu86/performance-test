require("scripts/postdata")

wrk.method = "POST"
wrk.headers["Content-Type"] = "application/json"
wrk.headers["Cookie"] = "Hm_lvt_7174bade1219f9cc272e7978f9523fc8=1597371023; mysession=MTYwNzA2NjUwN3xOd3dBTkRkUVdFUkJXbEpFUlZSSU4xZEJWbEl6VVVJM1UxVTBWRmRWUTFWS1dqUTNSa1ZDTlROUlJFUkNUalZRTmxwSk1rZERWVUU9fMqRp1vQSxR1C65LXZwA21_r-C_C9BULtOEZx_WUz3k-; Admin-Token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE2MDcwNzAxMDcsImlhdCI6MTYwNzA2NjUwNywidXNlcklkIjoxfQ.kneNFqaR_H1i6np2Y8AFvausHsGGWWPvCpylTRwnSzY"

local data = '{"args": "Register,1000101,%s","chaincodeName": "land","channelId": 7,"created": 1606960883,"fcn": "Register","fcntype": "invoke","githubPath": "github.com/baaschaincodes/admin/j007/c2/land/1","id": 10,"policy": "OR(\'J007orgMSP.member\')","status": 1,"userAccount": "admin", "version": "1"}'
-- wrk.body='{"args": "Register","chaincodeName": "land","channelId": 7,"created": 1606960883,"fcn": "Register","fcntype": "invoke","githubPath": "github.com/baaschaincodes/admin/j007/c2/land/1","id": 10,"policy": "OR(\'J007orgMSP.member\')","status": 1,"userAccount": "admin","version": "1"}'
wrk.body = string.format(data, postdata.t1000101)
