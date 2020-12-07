--
--wrk api:
--function wrk.format(method, path, headers, body)
--

-- require("scripts/keys4k")
require("scripts/postdata")

-- KEYS = keys4k.KEYS

-- set header
wrk.headers["Content-Type"] = "application/json"

-- global variabl
writeapi = "/api/chaincode/invoke"
readapi = "/api/chaincode/query"
counter = 1


function read()
  local key = tostring(counter)
  -- counter = counter + 1
  print("key: ", key)
  local bodyData  = '{"args": "Query,%s","chaincodeName": "land","channelId": 7,"created": 1606960883,"fcn": "Query","fcntype": "query","githubPath": "github.com/baaschaincodes/admin/j007/c2/land/1","id": 10,"policy": "OR(\'J007orgMSP.member\')","status": 1,"userAccount": "admin","version": "1"}'
  local body = string.format(bodyData, key)
  wrk.headers["Content-Type"] = "application/json"
  wrk.headers["Cookie"] = "Hm_lvt_7174bade1219f9cc272e7978f9523fc8=1597371023; mysession=MTYwNzI1NDQ2OXxOd3dBTkRkUVdFUkJXbEpFUlZSSU4xZEJWbEl6VVVJM1UxVTBWRmRWUTFWS1dqUTNSa1ZDTlROUlJFUkNUalZRTmxwSk1rZERWVUU9fNhhA_CWtb5yNWhDX3ZDlNZs6JT_Z48HlB4AqRID3gdc; Admin-Token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE2MDcyNTgwNjksImlhdCI6MTYwNzI1NDQ2OSwidXNlcklkIjoxfQ.zsrYduBJp-Wls97QON3GUBmkHsyFs1TiprklNefMFLU"
  return wrk.format("POST", readapi, nil, body)
end

function write()
  local key = tostring(counter)
  counter = counter + 1
  local body = string.format(bodyData, key, postdata.d4k)
  wrk.headers["Content-Type"] = "application/json"
  wrk.headers["Cookie"] = "Hm_lvt_7174bade1219f9cc272e7978f9523fc8=1597371023; mysession=MTYwNzI1NDQ2OXxOd3dBTkRkUVdFUkJXbEpFUlZSSU4xZEJWbEl6VVVJM1UxVTBWRmRWUTFWS1dqUTNSa1ZDTlROUlJFUkNUalZRTmxwSk1rZERWVUU9fNhhA_CWtb5yNWhDX3ZDlNZs6JT_Z48HlB4AqRID3gdc; Admin-Token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE2MDcyNTgwNjksImlhdCI6MTYwNzI1NDQ2OSwidXNlcklkIjoxfQ.zsrYduBJp-Wls97QON3GUBmkHsyFs1TiprklNefMFLU"
  return wrk.format("POST", writeapi, nil, body)
end


-- wrk request interface
request = function()
  -- local key = KEYS[counter]
  -- queryapi = string.format("/api/v1/cc/query?arg=%s&ccid=landproperty", key)
  -- counter = counter + 1
  -- if(counter > #KEYS)
  -- then
  --   counter = 1
  -- end
  counter = counter + 1
  local r = {}
  r[1] = read()
  -- r[2] = write()
  req = table.concat(r)
  return req
end

-- response = function(status, headers, body)
--   print(body.code)
-- end
