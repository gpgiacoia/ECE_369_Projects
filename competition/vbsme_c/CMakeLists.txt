cmake_minimum_required(VERSION 3.30)
set(CMAKE_C_COMPILER "gcc")
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
project(vbsme C)

add_executable(out main.c)
target_compile_options(out PRIVATE -g)
