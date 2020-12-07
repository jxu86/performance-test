
'use strict';
module.exports.info = 'Querying a value.';

const ccname = "landproperty"
const key = "a"

let txIndex = 0;
let limitIndex, bc, contx;

module.exports.init = async function(blockchain, context, args) {
    bc = blockchain;
    contx = context;
    return Promise.resolve();
};

module.exports.run = function() {
    let args = {
        chaincodeFunction: 'Query',
        chaincodeArguments: [key]
    };

    return bc.bcObj.querySmartContract(contx, ccname, 'v1', args, 30)
};

module.exports.end = function() {
    return Promise.resolve();
};
