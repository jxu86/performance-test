require("scripts/keys4k")

KEYS = keys4k.KEYS

function read()
  return wrk.format("GET", queryapi)
end

counter = 1
queryapi = ""

request = function ()
  local key = KEYS[counter]
  queryapi = string.format("/api/v1/cc/query?arg=%s&ccid=landproperty", key)
  counter = counter + 1
  if(counter > #KEYS)
  then
    counter = 1
  end
  return read()
end