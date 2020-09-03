set(HEADERS serdescpp.h serdescpp-avro.h)
set(SOURCES Serdes.cpp)

add_library(serdes++
  ${HEADERS}
  ${SOURCES}
)

if(BUILD_SHARED_LIBS)
  target_compile_definitions(serdes++ PRIVATE SERDES_DLL_EXPORTS)
endif()

add_library(${PROJECT_NAME}::serdes++ ALIAS serdes++)

target_link_libraries(serdes++
  ${DEPS} serdes
)

set_target_properties(serdes++ PROPERTIES PUBLIC_HEADER "${HEADERS}")
target_include_directories(serdes++ PUBLIC
  $<BUILD_INTERFACE:${CMAKE_CURRENT_LIST_DIR}>
  $<INSTALL_INTERFACE:include>
  PRIVATE ${CMAKE_CURRENT_LIST_DIR}
)
install(
  TARGETS serdes++
  EXPORT ${PROJECT_NAME}Targets
  RUNTIME
    DESTINATION "bin"
  LIBRARY
    DESTINATION "lib"
  ARCHIVE
    DESTINATION "lib"
  PUBLIC_HEADER
    DESTINATION "include/libserdes"
)
