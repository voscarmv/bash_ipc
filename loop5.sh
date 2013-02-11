	printf '0' > ${BYTE_COUNT} &
#  bash_IPC_middleman, Copyright 2013 Vicente Oscar Mier Vela
#     This file is part of bash_IPC_middleman.
# 
#     bash_IPC_middleman is free software: you can redistribute it and/or modify
#     it under the terms of the GNU General Public License as published by
#     the Free Software Foundation, either version 3 of the License, or
#     (at your option) any later version.
# 
#     bash_IPC_middleman is distributed in the hope that it will be useful,
#     but WITHOUT ANY WARRANTY; without even the implied warranty of
#     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#     GNU General Public License for more details.
# 
#     You should have received a copy of the GNU General Public License
#     along with bash_IPC_middleman.  If not, see <http://www.gnu.org/licenses/>.
	while : ; do
		echo writing MIDDLE to INPUT2
		cat ${MIDDLE} > ${INPUT2}
		printf '0' > ${I1_PAUSE}
		echo Done writing MIDDLE to INPUT2

#		Only once MIDDLE is written to, the following is executed:

		N_BYTES="`cat ${BYTE_COUNT}`"
		echo N_BYTES before sum is $N_BYTES
		N_BYTES=`expr "${N_BYTES}" + 1`
		printf "${N_BYTES}" > ${BYTE_COUNT} &
		echo N_BYTES is now $N_BYTES
	done
