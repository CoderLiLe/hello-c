cmake_minimum_required(VERSION 3.22)
project(CProject C)
set(CMAKE_C_STANDARD 99)

set(EXCLUDE
    05/01_PointerTest.c
    06/01_FunctionDefine.c 06/03_FunctionDefine.c
    06/31_VariableTest2.c 06/34_ConstTest.c
)

file(GLOB_RECURSE SRC *.c)
list(REMOVE_ITEM SRC ${EXCLUDE})

foreach(F ${SRC})
    cmake_path(GET F stem NAME)
    cmake_path(GET F parent DIR)
    cmake_path(GET DIR filename CH)
    add_executable("${CH}_${NAME}" "${F}")
endforeach()
