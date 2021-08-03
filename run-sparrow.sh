echo start
echo /sparrow5_client/sparrow-client.sh -P JUST -U "$SP_ID" -PW ./pass.txt -S $SP_HOST -SD $BASE_DIR > result
rc=$?
echo in the middle, $rc
ls -l result
risk1=`grep -P '1 \S+ \d+' <result | awk '{s+=$3} END {print s}'`
echo 1111
risk2=`grep -P '2 \S+ \d+' <result | awk '{s+=$3} END {print s}'`
echo 2222
echo $SP_R1 == $SP_R2
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
