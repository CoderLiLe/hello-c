#!/bin/bash

set -e

CC="${CC:-gcc}"
BUILD_DIR="${BUILD_DIR:-build}"

echo "==========================="
echo " C语言学习项目 - 编译脚本"
echo "==========================="

# 尝试使用 CMake
if command -v cmake &>/dev/null; then
    echo "[1/2] 配置 CMake..."
    cmake -S . -B "$BUILD_DIR" -DCMAKE_BUILD_TYPE=Release
    echo "[2/2] 编译所有目标..."
    cmake --build "$BUILD_DIR" -j"$(nproc 2>/dev/null || sysctl -n hw.ncpu 2>/dev/null || echo 4)"
    echo ""
    echo "完成！可执行文件位于 $BUILD_DIR/ 目录下"
    echo "可单独编译某个目标，例如: cmake --build $BUILD_DIR --target ch01_01_Hello"
    exit 0
fi

# 如果没有 CMake，使用直接编译
echo "未检测到 CMake，使用 $CC 直接编译..."
echo ""

mkdir -p "$BUILD_DIR"

compile_file() {
    local src="$1"
    local name
    name=$(basename "$src" .c)
    local target="$BUILD_DIR/$name"
    echo "编译: $src -> $target"
    $CC "$src" -o "$target" -std=c99 -Wall -Wextra
}

echo "--- 第01章: 入门 ---"
for f in 01/*.c; do compile_file "$f"; done

echo "--- 第02章: 变量与数据类型 ---"
for f in 02/*.c; do compile_file "$f"; done

echo "--- 第03章: 运算符与流程控制 ---"
for f in 03/*.c; do compile_file "$f"; done

echo "--- 第04章: 数组 ---"
for f in 04/*.c; do compile_file "$f"; done

echo "--- 第05章: 指针 ---"
for f in 05/*.c; do
    case "$(basename "$f")" in
        01_PointerTest.c)
            echo "跳过 $f (包含刻意演示的编译错误)"
            ;;
        *)
            compile_file "$f"
            ;;
    esac
done

echo "--- 第06章: 函数 ---"
for f in 06/*.c; do
    case "$(basename "$f")" in
        01_FunctionDefine.c|03_FunctionDefine.c|31_VariableTest2.c|34_ConstTest.c)
            echo "跳过 $f (无main函数，仅作参考)"
            ;;
        *)
            compile_file "$f"
            ;;
    esac
done

echo "--- 第07章: 结构体与共用体 ---"
for f in 07/*.c; do compile_file "$f"; done

echo "--- 第08章: 常用函数 ---"
for f in 08/*.c; do compile_file "$f"; done

echo "--- 第09章: 文件操作 ---"
for f in 09/*.c; do compile_file "$f"; done

echo ""
echo "所有文件编译完成！可执行文件位于 $BUILD_DIR/ 目录下"
