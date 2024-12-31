cmake_minimum_required(VERSION 3.4.1)  # Minimum version for Android NDK

add_library(llama SHARED llama.cpp)    # Add the llama.cpp library
add_library(bridge SHARED bridge.cpp)  # Add the C++ bridge code

find_library(log-lib log)              # Android log library

target_link_libraries(
    bridge
    llama
    ${log-lib}                         # Link the log library for debugging
)
