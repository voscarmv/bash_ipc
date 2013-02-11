. init.sh
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
echo INPUT1
cat ${INPUT1}
echo I1_OPEN_PAUSE
cat ${I1_OPEN_PAUSE}
echo I1_PAUSE
cat ${I1_PAUSE}

echo MIDDLE
cat ${MIDDLE}
echo KILL_MIDDLEMAN
cat ${KILL_MIDDLEMAN}
echo BYTE_COUNT
cat ${BYTE_COUNT}
echo BC_OPEN_PAUSE
cat ${BC_OPEN_PAUSE}

echo INPUT2
cat ${INPUT2}
echo I2_OPEN_PAUSE
cat ${I2_OPEN_PAUSE}
echo I2_PAUSE
cat ${I2_PAUSE}

echo IN_BYTE
cat ${IN_BYTE}
