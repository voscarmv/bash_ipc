#!/bin/bash
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

INPUT1=in_pipe_1
I1_OPEN_PAUSE=in_open_pause_1
I1_PAUSE=in_pause_1

MIDDLE=middle_pipe
KILL_MIDDLEMAN=middleman_asassin
BYTE_COUNT=counter_pipe
BC_OPEN_PAUSE=counter_pauser_pipe

INPUT2=in_pipe_2
I2_OPEN_PAUSE=in_open_pause_2
I2_PAUSE=in_pause_2

IN_BYTE=byte_pipe

mkfifo ${INPUT1} ${I1_OPEN_PAUSE} ${I1_PAUSE} ${MIDDLE} ${BYTE_COUNT} ${INPUT2} \
${I2_OPEN_PAUSE} ${I2_PAUSE} ${IN_BYTE} ${BC_OPEN_PAUSE} ${KILL_MIDDLEMAN}

#	Keep I1, BC, I2 open:


{
	while : ; do
	echo iteration loop 1 1>&2
		cat ${I1_OPEN_PAUSE} > /dev/null
		echo Breakins loop 1 1>&2
		break
	done > ${INPUT1}
} &
echo $!

{
	while : ; do
	echo iteration loop 2 1>&2
		cat ${I2_OPEN_PAUSE} > /dev/null
		echo Breaking loop 2 1>&2
		break
	done > ${INPUT2}
} &
echo $!

#	Set pipe reader loops

{
	cat ${INPUT1} | while BYTE="`od -An -tx1 -N1 | sed 's/ //g'`" ; do
	echo iteration loop 3
		printf '\x'"${BYTE}" > ${MIDDLE}
		if test "`cat \"${I1_PAUSE}\"`" != '0' ; then
			echo Breaking loop 3
			break
		fi
	done
} &
echo $!

{
	cat ${INPUT2} | while BYTE="`od -An -tx1 -N1 | sed 's/ //g'`" ; do
	echo iteration loop 4
		printf '\x'"${BYTE}" > ${IN_BYTE}
		if test "`cat \"${I2_PAUSE}\"`" != '0' ; then
			echo Breaking loop 4
			break
		fi
	done
} &
echo $!

#	Middleman

printf 'false' > ${KILL_MIDDLEMAN} &
printf '0' > ${BYTE_COUNT} &
{
	while : ; do
	echo iteration loop 5
	echo BOOLE is now ${BOOLE}
		cat ${MIDDLE} > ${INPUT2}
		KILLBOOLE="`cat ${KILL_MIDDLEMAN}`"
		if ${KILLBOOLE} ; then
			echo Breaking middleman
			printf '1' > ${I1_PAUSE}
			break
		fi

#		Only if MIDDLE has been written to, and KILL_MIDDLEMAN is 'false',
#		the following is executed:

		printf '0' > ${I1_PAUSE}
		printf "${KILLBOOLE}" > "${KILL_MIDDLEMAN}" &
		N_BYTES="`cat ${BYTE_COUNT}`"
		N_BYTES=`expr "${N_BYTES}" + 1`
		printf "${N_BYTES}" > ${BYTE_COUNT} &
	done
} &
echo $!

PROMPT='n'
while test "${PROMPT}" != 'q' ; do

#	Peek:
	echo Peeking BYTE_COUNT

	N_BYTES="`cat ${BYTE_COUNT}`"
	printf "${N_BYTES}" > ${BYTE_COUNT} &
	echo N_BYTES=${N_BYTES}
	echo press q to exit
	read -n 1 PROMPT
done

cat ${KILL_MIDDLEMAN}
printf ':' > ${KILL_MIDDLEMAN} &
printf 'x' > ${INPUT1}
# I1_PAUSE is written to by Middleman
# printf '1' > ${I1_PAUSE}
cat ${IN_BYTE}
cat ${BYTE_COUNT}
printf '1' > ${I1_OPEN_PAUSE}
printf '1' > ${I2_OPEN_PAUSE}
printf '1' > ${I2_PAUSE}
echo DONE!
