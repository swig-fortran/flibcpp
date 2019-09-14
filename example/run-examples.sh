#!/bin/sh

FAIL=0

function overall_result()
{
  exit ${FAIL}
}
trap overall_result EXIT

function run_test()
{
  local TESTNAME=$1
  local EXE=./${TESTNAME}.exe
  local OUT=${TESTNAME}.out
  printf "Run %s..." ${TESTNAME}
  ${EXE} > ${OUT} 2>&1
  if [ $? -eq 0 ]; then
    echo "success!"
  else
    echo "FAILURE!"
    FAIL=1
    while read line
    do
      echo "${TESTNAME}: ${line}"
    done < ${OUT}
  fi
}

run_test sort << EOF
nope
three
10000000000000000
20 ha ha
20
EOF

run_test vecstr << EOF
This is the first string
a second string
and the third
EOF

