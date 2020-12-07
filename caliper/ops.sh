#!/bin/bash

FABRIC_VERSION=2.1.0

BENCHMARK_CONFIG="benchmarks/config.yaml"
NETWORK_CONFIG="networks/config.yaml"

function launch(){
  CFG="$1"
  if [ -z $CFG ]; then
    echo "Benchconfig not set."
    exit 1
  fi

  npx caliper launch master \
    --caliper-benchconfig $CFG \
    --caliper-networkconfig $NETWORK_CONFIG \
    --caliper-workspace ./ \
    --caliper-flow-only-test \
    --caliper-fabric-gateway-usegateway \
    --caliper-fabric-gateway-discovery
}

function help(){
  echo "Usage: ops.sh <cmd>"
  echo "cmd:"
  echo "  bind             :bind sdk"
  echo "  unbind           :unbind sdk"
  echo "  launch           :benchmark fabcar network"
  echo "  commit           :commit change"
}

MODE="$1"
case $MODE in
  bind )
    npx caliper bind --caliper-bind-sut fabric:$FABRIC_VERSION
    ;;
  unbind )
    npx caliper unbind --caliper-bind-sut fabric:$FABRIC_VERSION
    ;;
  launch )
    launch $BENCHMARK_CONFIG
    ;;
  commit )
    git add -A
    git commit -am "commit change"
    ;;
  * )
    help
    exit 1
esac