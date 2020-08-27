cmake_minimum_required(VERSION 3.1)

project(Serdes LANGUAGES C CXX)

set(CMAKE_CXX_STANDARD 11)

### Dependencies
# Use our custom Find*.cmake files to find dependencies
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_SOURCE_DIR}/cmake/modules/")
# C dependencies
find_package(jansson REQUIRED)
find_package(CURL REQUIRED)
find_package(avro-c)
if(AVRO-C_FOUND)
  include_directories(${AVRO-C_INCLUDE_DIR})
endif()

# C++ dependencies
find_package(avro-cpp)
if(AVRO-CPP_FOUND)
  include_directories(${AVRO-CPP_INCLUDE_DIR})
endif()

set(DEPS jansson::jansson CURL::libcurl ${AVRO-C_LIBRARY} ${AVRO-CPP_LIBRARY})

# Only for examples
#find_package(RdKafka)


### `settings` for global build options
add_library(settings INTERFACE)

if(CMAKE_CXX_COMPILER_ID STREQUAL "MSVC")
  set(CXX_WARNING_OPTIONS /W4)
  set(CXX_WARNINGS_AS_ERRORS_OPTION /WX)
else()
  set(CXX_WARNING_OPTIONS -Wall -pedantic -Wconversion -Wno-unknown-pragmas)
  set(CXX_WARNINGS_AS_ERRORS_OPTION -Werror)
endif()

target_compile_options(settings INTERFACE ${CXX_WARNING_OPTIONS})

# Libraries
add_subdirectory(src)
add_subdirectory(src-cpp)

# Examples
if(BUILD_EXAMPLES)
  add_subdirectory(examples)
endif()
