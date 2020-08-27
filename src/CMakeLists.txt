if (avro-c_FOUND)
  set(SRCS_W_AVRO_C serialize-avro.c deserialize-avro.c schema-avro.c)
  set(HDRS_W_AVRO_C serdes-avro.h)
endif()

set(HEADERS serdes.h serdes-common.h ${HDRS_W_AVRO_C})
set(SOURCES serdes.c rest.c schema-cache.c framing.c tinycthread.c ${SRCS_W_AVRO_C})

add_library(serdes
  ${HEADERS}
  ${SOURCES}
)

if(BUILD_SHARED_LIBS)
  target_compile_definitions(serdes PRIVATE SERDES_DLL_EXPORTS)
endif()

if(WIN32)
  target_include_directories(serdes SYSTEM PRIVATE compat)
endif()

add_library(Serdes::serdes ALIAS serdes)

target_link_libraries(serdes
  ${DEPS}
)

set_target_properties(serdes PROPERTIES PUBLIC_HEADER "${HEADERS}")
target_include_directories(serdes PUBLIC
  $<BUILD_INTERFACE:${CMAKE_CURRENT_LIST_DIR}>
  $<INSTALL_INTERFACE:include>
  PRIVATE ${CMAKE_CURRENT_LIST_DIR}
)
install(
  TARGETS serdes
  EXPORT "SerdesTargets"
  RUNTIME
    DESTINATION "bin"
  LIBRARY
    DESTINATION "lib"
  ARCHIVE
    DESTINATION "lib"
  PUBLIC_HEADER
    DESTINATION "include/libserdes"
)

