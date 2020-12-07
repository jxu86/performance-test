'use strict';

const data1000101 = require("./1000101.json")

module.exports.info = 'Querying a value.';

const ccname = "landproperty"

let bc, contx;

module.exports.init = async function (blockchain, context, args) {
  bc = blockchain;
  contx = context;
  return Promise.resolve();
};

module.exports.run = function () {
  const bizCode = "1000101"
  const val = JSON.stringify(data1000101)
  let args = {
    chaincodeFunction: 'Register',
    chaincodeArguments: [bizCode, val]
  };

  return bc.invokeSmartContract(contx, ccname, 'v1', args, 30)
    .catch(err => {
      console.error("got an error")
    })
};

module.exports.end = function () {
  return Promise.resolve();
};
