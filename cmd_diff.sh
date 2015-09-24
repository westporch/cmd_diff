#!/bin/bash

#Hyungwan Seo

SECOND_OS_DIR_PATH=/mnt/s

OLD_CMDS_TXT_INCLUDE_Lbracket=old-OS_cmds-Lbracket.txt
NEW_CMDS_TXT_INCLUDE_Lbracket=new-OS_cmds-Lbracket.txt

OLD_CMDS_TXT=old-OS_cmds.txt
NEW_CMDS_TXT=new-OS_cmds.txt
NEW_CMDS_TXT_PROCESSING=$NEW_CMDS_TXT.bak

RESULT_TXT=result.txt

function create_cmd_txt()
{

	    #old OS의 디렉토리에 있는 명령어들을 하나의 텍스트 파일에 저장함.
	    oldOS_dir_arr=("/bin" "/usr/bin" "/sbin" "/usr/sbin" "/usr/local/bin" "/usr/local/sbin")

	    for ((idx=0; idx < ${#oldOS_dir_arr[@]}; idx++))
	    do
        	ls --color=no $SECOND_OS_DIR_PATH${oldOS_dir_arr[$idx]} | sort >> $OLD_CMDS_TXT_INCLUDE_Lbracket
	    done

 	   #new OS의 디렉토리에 있는 명령어들을 하나의 텍스트 파일에 저장함.
 	   newOS_dir_arr=("/bin" "/sbin" "/usr/sbin" "/usr/local/bin" "/usr/local/sbin")

 	   for ((idx=0; idx < ${#newOS_dir_arr[@]}; idx++))
 	   do
	       ls --color=no ${newOS_dir_arr[$idx]} | sort >> $NEW_CMDS_TXT_INCLUDE_Lbracket
	   done   
}

function delete_left_bracket()
{
	    Lbracket_fname_arr=($OLD_CMDS_TXT_INCLUDE_Lbracket $NEW_CMDS_TXT_INCLUDE_Lbracket)
	    fname_arr=($OLD_CMDS_TXT $NEW_CMDS_TXT)

	    for ((idx=0; idx < ${#Lbracket_fname_arr[@]}; idx++))
	    do
	        sed -e "/\[/d" ${Lbracket_fname_arr[$idx]} > ${fname_arr[$idx]}
	    done

	    #Left bracket([)를 포함한 파일 삭제
	    rm -rf $OLD_CMDS_TXT_INCLUDE_Lbracket $NEW_CMDS_TXT_INCLUDE_Lbracket
}

function delete_old_cmds()
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

create_cmd_txt
delete_left_bracket
delete_old_cmds
