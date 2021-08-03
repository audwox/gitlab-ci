/sparrow5_client/sparrow-client.sh -P JUST -U "$SP_ID" -PW ./pass.txt -S $SP_HOST -SD $BASE_DIR > result
rc=$?
grep -P '1\s+\S+\s+\d+' result
grep -P '1\s+\S+\s+\d+' result | awk '{s+=$3} END {print s}'
risk1=`grep -P '1\s+\S+\s+\d+' result | awk '{s+=$3} END {print s}'`
risk2=`grep -P '2\s+\S+\s+\d+' result | awk '{s+=$3} END {print s}'`
cat result

[ "0$rc" -ne 0 ] && {
	echo "Error: sparrow return $rc."
	exit 1
}
[ "0$risk1" -gt "0$SP_R1" -o "0$risk2" -gt "0$SP_R2" ] && {
	echo "Error: Too many risks."
	exit 2
}
exit 0
