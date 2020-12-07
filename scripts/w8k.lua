require("scripts/postdata")

writeapi = "/api/chaincode/invoke"
counter = 300
bodyData = '{"args": "InvokeTest,%s,%s","chaincodeName": "land","channelId": 7,"created": 1606960883,"fcn": "InvokeTest","fcntype": "invoke","githubPath": "github.com/baaschaincodes/admin/j007/c2/land/1","id": 10,"policy": "OR(\'J007orgMSP.member\')","status": 1,"userAccount": "admin", "version": "1"}'
-- wrk request interface
request = function()
    local key = tostring(counter)
    counter = counter + 1
    body = string.format(bodyData, key, postdata.d8k)
    -- wrk.method = "POST"
    wrk.headers["Content-Type"] = "application/json"
    wrk.headers["Cookie"] = "Hm_lvt_7174bade1219f9cc272e7978f9523fc8=1597371023; mysession=MTYwNzI1NDQ2OXxOd3dBTkRkUVdFUkJXbEpFUlZSSU4xZEJWbEl6VVVJM1UxVTBWRmRWUTFWS1dqUTNSa1ZDTlROUlJFUkNUalZRTmxwSk1rZERWVUU9fNhhA_CWtb5yNWhDX3ZDlNZs6JT_Z48HlB4AqRID3gdc; Admin-Token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE2MDcyNTgwNjksImlhdCI6MTYwNzI1NDQ2OSwidXNlcklkIjoxfQ.zsrYduBJp-Wls97QON3GUBmkHsyFs1TiprklNefMFLU"
    return wrk.format("POST", writeapi, nil, body)
end

response = function(status, headers, body)
    print(status, headers, body)
end