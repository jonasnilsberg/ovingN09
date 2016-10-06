

# Finne MX-informasjonen
echo -------------- MX - informasjon ----------------
nslookup -type=mx $* | grep $*
# Finne ip-adresser
echo ------------ Navn og Ip-adresser --------------
dig $* +nocomments +noquestion +noauthority +noadditional +nostats | grep 'IN'
echo ------------ Reversoppslag -------------------
# Reversoppslag ip 
Ip="$(dig $* +short)"
set -f
arrayIP=(${Ip//\n/ })
for i in "${!arrayIP[@]}"
do
	adresse=$(dig -x "${arrayIP[i]}" +short)
	if [ -n "$adresse" ]; then
		 echo "${arrayIP[i]}" - $adresse
	else
		 echo "${arrayIP[i]}" - Unknown
	fi
done
echo ---------------- SPF ------------------------
nslookup -type=txt $* | grep 'v='
echo ------------- Kan sende post ----------------
./include.sh $*
# Se alle recordtypes
echo ------------- Alle recordtypes ------------------
dig $* ANY +noall +answer | grep 'IN'

		
