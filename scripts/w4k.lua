require("scripts/postdata")

-- wrk.method = "POST"
-- wrk.headers["Content-Type"] = "application/json"
-- wrk.headers["Cookie"] = "Hm_lvt_7174bade1219f9cc272e7978f9523fc8=1597371023; mysession=MTYwNzI1MjE2OHxOd3dBTkRkUVdFUkJXbEpFUlZSSU4xZEJWbEl6VVVJM1UxVTBWRmRWUTFWS1dqUTNSa1ZDTlROUlJFUkNUalZRTmxwSk1rZERWVUU9fAlaLYZ4DPaKYQBRfCjPm5abZT_QKiWu8fhNz2iV7HL8; Admin-Token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE2MDcyNTU3NjgsImlhdCI6MTYwNzI1MjE2OCwidXNlcklkIjoxfQ.Y7R8Ad6Ju7Fx4xt3x2Opf2GrBmwB_AAIfVYTerhibUQ"

-- local data = '{"args": "InvokeTest,%s,%s","chaincodeName": "land","channelId": 7,"created": 1606960883,"fcn": "InvokeTest","fcntype": "invoke","githubPath": "github.com/baaschaincodes/admin/j007/c2/land/1","id": 10,"policy": "OR(\'J007orgMSP.member\')","status": 1,"userAccount": "admin", "version": "1"}'
-- wrk.body = string.format(data, 'abc', postdata.d4k)


-- writeapi = "/api/v1/cc/invoke"


-- function write()
--     local body = '{"args": "InvokeTest,10000,%s","chaincodeName": "land","channelId": 7,"created": 1606960883,"fcn": "InvokeTest","fcntype": "invoke","githubPath": "github.com/baaschaincodes/admin/j007/c2/land/1","id": 10,"policy": "OR(\'J007orgMSP.member\')","status": 1,"userAccount": "admin", "version": "1"}'
--     return wrk.format("POST", writeapi, nil, body)
-- end
writeapi = "/api/chaincode/invoke"
counter = 500
bodyData = '{"args": "InvokeTest,%s,%s","chaincodeName": "land","channelId": 7,"created": 1606960883,"fcn": "InvokeTest","fcntype": "invoke","githubPath": "github.com/baaschaincodes/admin/j007/c2/land/1","id": 10,"policy": "OR(\'J007orgMSP.member\')","status": 1,"userAccount": "admin", "version": "1"}'
-- wrk request interface
request = function()
    local key = tostring(counter)
    counter = counter + 1
    body = string.format(bodyData, key, postdata.d4k)
    -- wrk.method = "POST"
    wrk.headers["Content-Type"] = "application/json"
    wrk.headers["Cookie"] = "Hm_lvt_7174bade1219f9cc272e7978f9523fc8=1597371023; mysession=MTYwNzI1NDQ2OXxOd3dBTkRkUVdFUkJXbEpFUlZSSU4xZEJWbEl6VVVJM1UxVTBWRmRWUTFWS1dqUTNSa1ZDTlROUlJFUkNUalZRTmxwSk1rZERWVUU9fNhhA_CWtb5yNWhDX3ZDlNZs6JT_Z48HlB4AqRID3gdc; Admin-Token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE2MDcyNTgwNjksImlhdCI6MTYwNzI1NDQ2OSwidXNlcklkIjoxfQ.zsrYduBJp-Wls97QON3GUBmkHsyFs1TiprklNefMFLU"
    return wrk.format("POST", writeapi, nil, body)
end

response = function(status, headers, body)
    print(status, headers, body)
end