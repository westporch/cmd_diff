#!/bin/bash
#Hyungwan Seo

TARGET_DIR_PATH=/mnt/s
#TARGET_DIR_SIZE=`du -s $TARGET_DIR_PATH | grep -o '^[0-9.0-9]*'`
RESULT_FILE=[result]Only-CentOS_cmd_list.txt
S_CMD_LIST=s_cmd_list.txt
CENTOS_APPEND_CMD_LIST=CentOS_append_cmd_list.txt

SBIN=/sbin
USR_SBIN=/usr/sbin


#1. /sbin과 /usr/sbin
#1-1. s
#diff -rq $TARGET_DIR_PATH$SBIN $TARGET_DIR_PATH$USR_SBIN | sort | grep "Only in" | awk -F " " '{print $3, $4}' >> $S_CMD_LIST
diff -rq $TARGET_DIR_PATH$SBIN $TARGET_DIR_PATH$USR_SBIN | sort | grep "Only in" | awk -F " " '{print $4}' >> $S_CMD_LIST

#1-2. CentOS 7 (1503) minimal
#diff -rq $SBIN $TARGET_DIR_PATH$SBIN | sort | grep "Only in $SBIN" | awk -F" " '{print $3, $4}' >> $CENTOS_APPEND_CMD_LIST
diff -rq $SBIN $TARGET_DIR_PATH$SBIN | sort | grep "Only in $SBIN" | awk -F" " '{print $4}' >> $CENTOS_APPEND_CMD_LIST

#1-3. 1-1과 1-2를 diff
diff -y s_cmd_list.txt CentOS_append_cmd_list.txt | grep '|' | awk -F " " '{print $3}' >> $RESULT_FILE
diff -y s_cmd_list.txt CentOS_append_cmd_list.txt | grep '>' | awk -F " " '{print $2}' >> $RESULT_FILE
