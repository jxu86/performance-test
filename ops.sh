#!/bin/bash


EXE_NMON="./bin/nmon"
EXE_NMON_CHART="./bin/nmonchart"
EXE_WRK="/usr/local/bin/wrk"

NMON_LOG="nmonlog"
NMON_REPOSITY="nmon_reposity"
NMON_OUT="nmon_out"

PORT=""


# query script
QUERY_LAND_4K="scripts/query-land-4k.lua"
QUERY_LAND_8K="scripts/query-land-8k.lua"

# insert script
REGISTER_LAND_4K="scripts/register-land-4k.lua"
REGISTER_LAND_8K="scripts/register-land-8k.lua"

TRANSFER_LAND_4K="scripts/transfer-land-4k.lua"
TRANSFER_LAND_8K="scripts/transfer-land-8k.lua"

QUERY_TEST="scripts/query-test.lua"
REGISTER_TEST="scripts/register-test.lua"

INVOKE_TEST="scripts/w4k.lua"


# read write script
RW_4k="scripts/rw-4k.lua"
RW_8k="scripts/rw-8k.lua"

function setAPI(){
  if [ -z $PORT ]; then 
    PORT="7992"
    IP="127.0.0.1"
  fi

  HOST="http://${IP}:${PORT}"
  # INVOKE_API="http://localhost:${PORT}/api/v1/cc/invoke"
  INVOKE_API="http://${IP}:${PORT}/api/chaincode/invoke"
  QUERY_API="http://${IP}:${PORT}/api/chaincode/query"
  REGSIGER_API="http://${IP}:${PORT}/api/chaincode/invoke"
}

function startMonitor(){
  # create dir
  if [ ! -d $NMON_LOG ]; then
    mkdir $NMON_LOG
  fi

  # clean dir
  rm -rf $NMON_LOG/*

  # start nmon
  $EXE_NMON -ft -s 1 -c 180 -m $NMON_LOG
}

function drawChart(){
  $EXE_NMON_CHART $NMON_LOG/*.nmon $NMON_LOG/out.html
}

# c   :500
# api :invoke
function qa1(){
    if [ $POST_8K = true ]; then 
      echo "Use 8k data"
      script=${REGISTER_LAND_8K}
    else
      echo "Use 4k data"
      script=${REGISTER_LAND_4K}
    fi

    $EXE_WRK -t1 -c2 -d2 --timeout 10s --latency \
      -s ${script} ${INVOKE_API}
}

# c   :500
# api :invoketest
function qa2(){
    if [ $POST_8K = true ]; then 
      echo "Use 8k data"
      script=${QUERY_LAND_8K}
    else
      echo "Use 4k data"
      script=${QUERY_LAND_4K}
    fi

    $EXE_WRK -t8 -c500 -d10 --timeout 10s --latency -s $script $HOST
}

function qt(){
  script=${QUERY_TEST}
  $EXE_WRK -t8 -c100 -d10 --timeout 10s --latency -s $script $HOST
}

function rt(){
  script=${REGISTER_TEST}
  $EXE_WRK -t2 -c3 -d10 --timeout 10s --latency \
      -s ${script} ${REGSIGER_API}
}

function wt() {
  script=${INVOKE_TEST}
  $EXE_WRK -t8 -c100 -d10 --timeout 10s --latency -s ${script} ${HOST}
}

# c   :500
# api :invoke
function qa3(){
    if [ $POST_8K = true ]; then 
      echo "Use 8k data"
      script=${TRANSFER_LAND_8K}
    else
      echo "Use 4k data"
      script=${TRANSFER_LAND_4K}
    fi

    $EXE_WRK -t8 -c500 -d10 --timeout 10s --latency \
      -s ${script} ${INVOKE_API}
}

# c   :1000
# api :invoke
function qa4(){
    if [ $POST_8K = true ]; then 
      echo "Use 8k data"
      script=${REGISTER_LAND_8K}
    else
      echo "Use 4k data"
      script=${REGISTER_LAND_4K}
    fi

    $EXE_WRK -t8 -c1000 -d10 --timeout 10s --latency \
      -s ${script} ${INVOKE_API}
}

# c   :1000
# api :invoketest
function qa5(){
    if [ $POST_8K = true ]; then 
      echo "Use 8k data"
      script=${QUERY_LAND_8K}
    else
      echo "Use 4k data"
      script=${QUERY_LAND_4K}
    fi

    $EXE_WRK -t8 -c1000 -d10 --timeout 10s --latency -s ${script} ${HOST}
}

# c   :1000
# api :invoke
function qa6(){
    if [ $POST_8K = true ]; then 
      echo "Use 8k data"
      script=${TRANSFER_LAND_8K}
    else
      echo "Use 4k data"
      script=${TRANSFER_LAND_4K}
    fi

    $EXE_WRK -t8 -c1000 -d10 --timeout 10s --latency \
      -s ${script} ${INVOKE_API}
}

# long run
function longrun(){
  if [ $POST_8K = true ]; then 
    echo "Use 8k data"
    script=${INSERT_LAND_8K}
  else
    echo "Use 4k data"
    script=${INSERT_LAND_4K}
  fi

  $EXE_WRK -t8 -c1000 -d1800 --timeout 10s --latency \
      -s ${script} ${INVOKE_API}
}

# read write qa test
function qarw(){
  if [ $POST_8K = true ]; then 
    echo "Use 8k data"
    script=${RW_8k}
  else
    echo "Use 4k data"
    script=${RW_4k}
  fi  
  $EXE_WRK -t5 -c10 -d10 --timeout 10s --latency -s ${script} ${HOST}
}

function qaall(){
  echo "Runing qa1..."
  qa1
  sleep 5

  echo "Runing qa2..."
  qa2
  sleep 5

  echo "Runing qa3..."
  qa3
  sleep 5

  echo "Runing qa4..."
  qa4
  sleep 5

  echo "Runing qa5..."
  qa5
  sleep 5

  echo "Runing qa6..."
  qa6

  echo "All job done!"
}

# push .nmon to reposity
function pushnmon(){
  IP=$(ip a | grep eth0 | grep inet | awk '{print $2}' | awk -F/ '{print $1}')

  if [ -z $IP ]; then
    IP=$(ip a | grep ens | grep inet | awk '{print $2}' | awk -F/ '{print $1}')
  fi

  files=$(ls $NMON_LOG)
  for filename in $files
  do
    newfilename="$IP-$filename" 
    scp -P 2184 $NMON_LOG/$filename root@58.62.207.50:~/monitor/$NMON_REPOSITY/$newfilename
  done
}

# parse nmon
function parse(){
  if [ ! -d $NMON_OUT ]; then
    mkdir $NMON_OUT
  fi

  TARGET=$NMON_REPOSITY
  # parse all
  files=$(ls $TARGET)
  for filename in $files
  do
    $EXE_NMON_CHART $TARGET/$filename $NMON_OUT/$filename.html
  done
}

function help(){
  echo "Usage: ops.sh <cmd>"
  echo "cmd:"
  echo "  nmon      :start monitor"
  echo "  chart     :generate chart"
  echo "  qa1       :run qa type 1"
  echo "  qa2       :run qa type 2"
  echo "  qa3       :run qa type 3"
  echo "  qa4       :run qa type 4"
  echo "  qa5       :run qa type 5"
  echo "  qa6       :run qa type 6"
  echo "  longrun   :longrun test"
  echo "  qarw      :run read write at same time"
  echo "  qaall     :run qa all type"
  echo "  push      :push nmon file to reposity"
  echo "  parse     :parse reposity files"
  echo "  commit    :commit change"
  echo "flag:"
  echo "  --p8k     :specify post data"
  echo "  --repeat  :repeat qa time"
  echo "  --port    :specify port number"
}

MODE="$1"
shift

# flags
POST_8K=false
REPEAT=1

# parse flags
while [[ $# -ge 1 ]]; do
  opt="$1"
  case $opt in
    --p8k)
      POST_8K=true
      ;;
    --repeat)
      REPEAT="$2"
      shift
      ;;
    --port )
      PORT="$2"
      shift
      ;;
    *)
      echo "unkonwn flag: $opt"
      help
      exit 1
  esac
  shift
done

setAPI

case $MODE in
  nmon )
    startMonitor
    ;;
  chart )
    drawChart
    ;;
  qt )
    qt
    ;;
  rt )
    rt
    ;;
  # qa1 )
  #   for i in $(seq 1 $REPEAT); do 
  #     qa1
  #   done
  #   ;;
  wt )
    wt
    ;;
  qa1 )
    qa1
    ;;
  qa2 )
    for i in $(seq 1 $REPEAT); do 
      qa2
    done
    ;;
  qa3 )
    for i in $(seq 1 $REPEAT); do 
      qa3
    done
    ;;
  qa4 )
    for i in $(seq 1 $REPEAT); do 
      qa4
    done
    ;;
  qa5 )
    for i in $(seq 1 $REPEAT); do 
      qa5
    done
    ;;
  qa6 )
    for i in $(seq 1 $REPEAT); do 
      qa6
    done
    ;;
  longrun )
    longrun
    ;;
  qarw )
    qarw
    ;;
  qaall)
    qaall
    ;;
  push)
    pushnmon
    ;;
  parse )
    parse
    ;;
  commit )
    git add -A
    git commit -am "modify"
    ;;
  * )
    help
    exit 1
esac