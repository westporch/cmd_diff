#!/bin/bash

SOURCE_TXT=new.txt
SOURCE_TXT_BAK=new.txt.bak
TARGET_TXT=old.txt
NEW_CMDS_TXT=new-OS_cmds.txt
RESULT_TXT=result.txt

txt_lines=`cat $TARGET_TXT | wc -l`

function create_cmd_txt()
{
	arr=("/bin" "/usr/bin" "/sbin" "/usr/sbin" "/usr/local/bin" "/usr/local/sbin")
	
	for ((idx=0; idx < ${#arr[@]}; idx++))
	do
		ls --color=no ${arr[$idx]} | sort >> $NEW_CMDS_TXT
	done
}



function exclude_old_cmds()
{
	readarray -t s_arr < $TARGET_TXT #텍스트 파일의 내용을 배열에 저장한다.

	cp $SOURCE_TXT $SOURCE_TXT_BAK  #원본 문서 백업

	for ((idx=0; idx<txt_lines; idx++))
	do
    	echo -e "${s_arr[$idx]}\n"

    	sed -e "/${s_arr[$idx]}/d" $SOURCE_TXT > $RESULT_TXT

		#   echo -e "\n" >> $RESULT_TXT

    	yes | cp $RESULT_TXT $SOURCE_TXT
done
}

create_cmd_txt
exclude_old_cmds

