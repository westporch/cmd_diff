#!/bin/bash

#Hyungwan Seo

SECOND_OS_DIR_PATH=/mnt/s
OLD_CMDS_TXT=old-OS_cmds.txt
NEW_CMDS_TXT=new-OS_cmds.txt
NEW_CMDS_TXT_PROCESSING=$NEW_CMDS_TXT.bak

RESULT_TXT=result.txt

function create_cmd_txt()
{
	    #arr=("/bin" "/usr/bin" "/sbin" "/usr/sbin" "/usr/local/bin" "/usr/local/sbin")

	    arr=("/usr/bin") # [ 명령어는 삭제해야 함. [를 지우지 않으면 중복된 명령어를 제거하지 못함.
	    for ((idx=0; idx < ${#arr[@]}; idx++))
	    do
	        ls --color=no $SECOND_OS_DIR_PATH${arr[$idx]} | sort >> $OLD_CMDS_TXT
	        ls --color=no ${arr[$idx]} | sort >> $NEW_CMDS_TXT                                                
	    done
}

function exclude_old_cmds()
{
	    txt_lines=`cat $OLD_CMDS_TXT | wc -l`
	    readarray -t s_arr < $OLD_CMDS_TXT #텍스트 파일의 내용을 배열에 저장한다.

	    cp $NEW_CMDS_TXT $NEW_CMDS_TXT_PROCESSING #sed 작업할 문서 생성

	    for ((idx=0; idx<txt_lines; idx++))
	    do
	        echo -e "${s_arr[$idx]}\n"

	        sed -e "/${s_arr[$idx]}/d" $NEW_CMDS_TXT_PROCESSING > $RESULT_TXT

 	       yes | cp $RESULT_TXT $NEW_CMDS_TXT_PROCESSING
	    done

		rm -rf $NEW_CMDS_TXT_PROCESSING #작업 파일 삭제
}

#create_cmd_txt
exclude_old_cmds
