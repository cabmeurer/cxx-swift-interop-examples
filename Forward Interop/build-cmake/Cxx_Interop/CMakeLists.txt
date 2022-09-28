
cmake_minimum_required(VERSION 3.18)

project(Cxx_Interop LANGUAGES CXX Swift)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED YES)
set(CMAKE_CXX_EXTENSIONS OFF)

add_library(cxx-support ./Sources/Cxx/Cxx.cpp)
target_compile_options(cxx-support PRIVATE
  -I${SWIFT_CXX_TOOLCHAIN}/usr/include/c++/v1
  -fno-exceptions
  -fignore-exceptions
  -nostdinc++)
target_include_directories(cxx-support PUBLIC
  ${CMAKE_SOURCE_DIR}/Sources/Cxx)

add_executable(Cxx_Interop ./Sources/Cxx_Interop/main.swift)
target_compile_options(Cxx_Interop PRIVATE
  "SHELL:-Xfrontend -enable-cxx-interop"
  "SHELL:-Xfrontend -validate-tbd-against-ir=none"
  "SHELL:-Xcc -nostdinc++"
  "SHELL:-Xcc -fno-exceptions"
  "SHELL:-Xcc -fignore-exceptions"
  "SHELL:-Xcc -I${SWIFT_CXX_TOOLCHAIN}/usr/include/c++/v1"
  -lc++)
target_link_libraries(Cxx_Interop PRIVATE cxx-support)

