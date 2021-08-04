#!/bin/sh

# sparrow-client.sh 의 출력에서 risk 단계가 1, 2인 이슈(고위험 이슈)의 수를 비교하고
# 고위험 이슈가 많으면 실행 종료 시 exit code로 2를 리턴.
# exit codes:
# 0 - success
# 1 - something wrong
# 2 - too many issues

/sparrow5_client/sparrow-client.sh -P JUST -U "$SP_ID" -PW ./pass.txt -S $SP_HOST -SD $BASEDIR > result
rc=$?
risk1=`grep -P '1\s+\S+\s+\d+' result | awk '{s+=$3} END {print s}'`
risk2=`grep -P '2\s+\S+\s+\d+' result | awk '{s+=$3} END {print s}'`
cat result

[ "0$rc" -ne 0 ] && {
	echo "Error: sparrow return $rc."
	exit 1
}
[ "0$risk1" -gt "0$SP_R1" -o "0$risk2" -gt "0$SP_R2" ] && {
	echo "Error: Too many high risk issues: $(($risk1 + $risk2))"
	exit 2
}
exit 0
