cat pass.txt | /sparrow5_client/sparrow-client.sh -P JUST -U "$SP_ID" -S $SP_HOST -SD $BASE_DIR > result
#cat pass.txt | /sparrow5_client/sparrow-client.sh -P JUST -U "$SP_ID" -PW ./pass.txt -S $SP_HOST -SD $BASE_DIR > result
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
