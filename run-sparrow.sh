echo start
echo /sparrow5_client/sparrow-client.sh -P JUST -U "$SP_ID" -PW ./pass.txt -S $SP_HOST -SD $BASE_DIR > result
rc=$?
echo in the middle, $rc
ls -l result
risk1=`grep -P '1 \S+ \d+' <result | awk '{s+=$3} END {print s}'`
echo 1111
risk2=`grep -P '2 \S+ \d+' <result | awk '{s+=$3} END {print s}'`
echo 2222
cat result
[ "$rc" -ne 0 ] && {
	echo "Error: sparrow return $rc."
	exit 1
}
[ "$risk1" -gt "$SP_R1" -o "$risk2" -gt "$SP_R2" ] && {
	echo "Error: Too many risks."
	exit 2
}
exit 0
