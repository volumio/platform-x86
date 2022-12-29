FIRMWARE_INSTALL_DIR="mylib/firmware"
VERSION="5.100.138"
BROADCOM_WL="broadcom-wl-5.100.138"
WL_APSTA="${BROADCOM_WL}/linux/wl_apsta.o"
DOWNLOAD="${BROADCOM_WL}.tar.bz2
B43="b43"
catalog="$HOME/catalog"

if [ "${DOWNLOAD}" != "${WL_APSTA}" ]; then
	if ! tar xvjf "${DOWNLOAD}" "${WL_APSTA}"; then
		echo "$0: Unpacking firmware file failed, unable to continue (is /tmp full?)." 1>&2
		exit 1
	fi
fi
mkdir -p "${FIRMWARE_INSTALL_DIR}/${B43}"
retcode=0
b43-fwcutter -w "${FIRMWARE_INSTALL_DIR}" "${WL_APSTA}" | while read line
do	echo "${line}"
	file="${line#Extracting }"
	if [ "${file}" != "${line}" ]; then
	   if [ "${retcode}" -ne 0 ]; then
          rm "${FIRMWARE_INSTALL_DIR}/${file}"
       elif [ -z "${FIRMWARE_INSTALL_DIR}/${file}" ] || \
		     ! printf %s/%s\\000 "${FIRMWARE_INSTALL_DIR}" "${file}" >> "${catalog}"
		  then
             echo "$0: Failed during extraction of ${file} from ${WL_APSTA}" 1>&2
		     echo "$0: Warning, manual removal/cleaning of ${FIRMWARE_INSTALL_DIR}/${B43} may be needed!" 1>&2
		     rm "${FIRMWARE_INSTALL_DIR}/${file}"
		     retcode=1
	   fi
	fi
done
