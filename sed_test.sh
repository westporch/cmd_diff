#!/bin/bash

SOURCE_TXT=new.txt
SOURCE_TXT_BAK=new.txt.bak
TARGET_TXT=old.txt
RESULT_TXT=result.txt

txt_lines=`cat $TARGET_TXT | wc -l`

readarray -t s_arr < $TARGET_TXT #텍스트 파일의 내용을 배열에 저장한다.


cp $SOURCE_TXT $SOURCE_TXT_BAK  #원본 문서 백업

for ((idx=0; idx<txt_lines; idx++))
do
    echo -e "${s_arr[$idx]}\n"

    sed -e "/${s_arr[$idx]}/d" $SOURCE_TXT > $RESULT_TXT

#   echo -e "\n" >> $RESULT_TXT

    yes | cp $RESULT_TXT $SOURCE_TXT

done

