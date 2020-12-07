-- require("scripts/postdata")

wrk.method = "POST"
-- wrk.headers["Content-Type"] = "application/json"
-- wrk.headers["Cookie"] = "Hm_lvt_7174bade1219f9cc272e7978f9523fc8=1597371023; mysession=MTYwNjk3Njc3NHxOd3dBTkRkUVdFUkJXbEpFUlZSSU4xZEJWbEl6VVVJM1UxVTBWRmRWUTFWS1dqUTNSa1ZDTlROUlJFUkNUalZRTmxwSk1rZERWVUU9fFYIppWbk3po7L_5noeIgQpfuQ5K93o19P90LRCDSa0k; Admin-Token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE2MDY5ODAzNzQsImlhdCI6MTYwNjk3Njc3NCwidXNlcklkIjoxfQ.P6niwoH3ZBRF-6QVxrTxIStMws79L3OC5aAUm7iw6Xw"
-- wrk.body='{"args": "Query,1","chaincodeName": "land","channelId": 7,"created": 1606960883,"fcn": "Query","fcntype": "query","githubPath": "github.com/baaschaincodes/admin/j007/c2/land/1","id": 10,"policy": "OR(\'J007orgMSP.member\')","status": 1,"userAccount": "admin","version": "1"}'
counter = 1
readapi = "/api/chaincode/query"
request = function()
    local key = tostring(counter)
    -- counter = counter + 1
    -- print("key: ", key)
    local bodyData  = '{"args": "Query,%s","chaincodeName": "land","channelId": 7,"created": 1606960883,"fcn": "Query","fcntype": "query","githubPath": "github.com/baaschaincodes/admin/j007/c2/land/1","id": 10,"policy": "OR(\'J007orgMSP.member\')","status": 1,"userAccount": "admin","version": "1"}'
    local body = string.format(bodyData, key)
    wrk.headers["Content-Type"] = "application/json"
    wrk.headers["Cookie"] = "Hm_lvt_7174bade1219f9cc272e7978f9523fc8=1597371023; mysession=MTYwNzI1NDQ2OXxOd3dBTkRkUVdFUkJXbEpFUlZSSU4xZEJWbEl6VVVJM1UxVTBWRmRWUTFWS1dqUTNSa1ZDTlROUlJFUkNUalZRTmxwSk1rZERWVUU9fNhhA_CWtb5yNWhDX3ZDlNZs6JT_Z48HlB4AqRID3gdc; Admin-Token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE2MDcyNTgwNjksImlhdCI6MTYwNzI1NDQ2OSwidXNlcklkIjoxfQ.zsrYduBJp-Wls97QON3GUBmkHsyFs1TiprklNefMFLU"
    return wrk.format("POST", readapi, nil, body)
end


-- response = function(status, headers, body)
--     -- print(status, headers, body)
--     print(body.code)
-- end

