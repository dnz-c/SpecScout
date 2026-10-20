cmake_minimum_required(VERSION 3.21)
project(SpecScout LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Toggle the Triton-backed speculative engine. Off lets the loader/CFG stages
# build and be tested before the (heavy) Triton dependency finishes installing.
option(SPECSCOUT_WITH_TRITON "Build the Triton-backed speculative engine" OFF)

find_package(LIEF CONFIG REQUIRED)
find_package(capstone CONFIG REQUIRED)

set(SPECSCOUT_SOURCES
    src/main.cpp
    src/Loader.cpp
    src/Cfg.cpp
)

set(SPECSCOUT_LIBS
    LIEF::LIEF
    capstone::capstone
)

if(SPECSCOUT_WITH_TRITON)
    # triton::triton carries z3 and capstone transitively (see tritonConfig.cmake)
    find_package(triton CONFIG REQUIRED)
    list(APPEND SPECSCOUT_SOURCES src/SpecEngine.cpp src/Sinks.cpp
                                  src/TaintSources.cpp src/QspectreClassifier.cpp
                                  src/Report.cpp)
    list(APPEND SPECSCOUT_LIBS triton::triton)
    add_compile_definitions(SPECSCOUT_WITH_TRITON=1)
endif()

add_executable(specscout ${SPECSCOUT_SOURCES})
target_include_directories(specscout PRIVATE src)
target_link_libraries(specscout PRIVATE ${SPECSCOUT_LIBS})

# Standalone dynamic Flush+Reload confirmer (phase 2); no Triton dependency.
add_executable(specscout_confirm confirm/harness.cpp)
if(MSVC)
    target_compile_definitions(specscout_confirm PRIVATE _CRT_SECURE_NO_WARNINGS)
endif()

if(MSVC)
    target_compile_options(specscout PRIVATE /W4 /permissive- /EHsc)
    target_compile_definitions(specscout PRIVATE _CRT_SECURE_NO_WARNINGS NOMINMAX)
endif()
