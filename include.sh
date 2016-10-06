includes="$(nslookup -type=txt $* | grep 'v=')"
arrayInclude=(${includes//:/ })
array1=()
for i in "${!arrayInclude[@]}"
do
	include=($(echo "${arrayInclude[i]}" | grep '\.'))
	if [ ! -z "$include" -a "$include" != $* ]; then
    array1+=($include)
	fi
done
for i in "${!array1[@]}"
do
	echo "${array1[i]}"
	./include.sh "${array1[i]}"
done
