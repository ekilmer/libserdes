set(HEADERS serdescpp.h serdescpp-avro.h)
set(SOURCES Serdes.cpp)

add_library(serdes++
  ${HEADERS}
  ${SOURCES}
)

add_library(Serdes::serdes++ ALIAS serdes++)

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
  EXPORT "SerdesTargets"
  RUNTIME
    DESTINATION "bin"
  LIBRARY
    DESTINATION "lib/libserdes"
  ARCHIVE
    DESTINATION "lib/libserdes"
  PUBLIC_HEADER
    DESTINATION "include/libserdes/"
)
