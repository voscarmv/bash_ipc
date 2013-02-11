	cat ${INPUT2} | while BYTE="`od -An -tx1 -N1 | sed 's/ //g'`" ; do
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
		echo BYTE before writing to IN_BYTE $BYTE
		printf '\x'"${BYTE}" > ${IN_BYTE}
		if test "`cat \"${I2_PAUSE}\"`" = '1' ; then
			break
		fi
	done
