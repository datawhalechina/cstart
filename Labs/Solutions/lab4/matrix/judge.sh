#!/bin/bash
make all

# 设置栈大小为无限制
ulimit -s unlimited

# 清理之前的输出文件
rm -f naive.out my.out

# 定义颜色
GREEN='\033[0;32m'  # 绿色
RED='\033[0;31m'    # 红色
NC='\033[0m'        # 无颜色（重置）

# 遍历指定文件夹下的所有 .in 文件
for input_file in testcases/*.in; do
    # 检查文件是否存在
    if [[ ! -f "$input_file" ]]; then
        echo "No input files found in input_files directory."
        break
    fi

    # 记录开始时间
    start_time_naive=$(date +%s.%N)

    # 运行 naive 程序
    ./build/naive < "$input_file" > naive.out

    # 记录结束时间
    end_time_naive=$(date +%s.%N)

    # 计算 naive 程序的运行时间
    runtime_naive=$(echo "$end_time_naive - $start_time_naive" | bc)

    # 记录开始时间
    start_time_my=$(date +%s.%N)

    # 运行 matrix_multiply 程序
    ./build/matrix_multiply < "$input_file" > my.out

    # 记录结束时间
    end_time_my=$(date +%s.%N)

    # 计算 matrix_multiply 程序的运行时间
    runtime_my=$(echo "$end_time_my - $start_time_my" | bc)

    # 比较输出文件
    if diff -q naive.out my.out > /dev/null; then
        echo -e "${GREEN}ACCEPT: $input_file${NC}"
    else
        echo -e "${RED}WRONG: $input_file${NC}"
        echo "Differences:"
        diff naive.out my.out
    fi

    # 输出两个程序的运行时间差异
    echo "Time taken - naive: $runtime_naive seconds, matrix_multiply: $runtime_my seconds"
    echo "---------------------------------------------"
done
