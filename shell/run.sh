#!/usr/bin/env bash

## 导入通用变量与函数
diyreplace_use=diyreplace"$1"
source /push/shell/share.sh

##运行脚本
function run_sh {
  mkdir -p $diy_logs
  source $shell_model/push.sh 2>&1 | tee $log_path
  exit
}

function run_sh_sd {
  cp -rf $config/crontab.list $config/crontab.list.back
  awk '{print "#"$0}' $config/crontab.list > /dev/null 2>&1
  mkdir -p $diy_logs
  source $shell_model/push.sh 2>&1 | tee $log_path
  cp -rf $config/crontab.list.back $config/crontab.list
  exit
}


if [[ $1 == sd ]]; then
    source /push/config/config/config.sh
    run_sh_sd
elif [[ $2 == sd ]]; then
    config_use=config"$1"
    source $file_config
    run_sh_sd $1
else
    config_use=config"$1"
    source $file_config
    run_sh $1
fi
