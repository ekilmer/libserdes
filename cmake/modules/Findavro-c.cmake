INCLUDE(FindPackageHandleStandardArgs)

FIND_PATH(AVRO-C_ROOT_DIR
          NAMES include/avro.h
          PATHS ENV AVRO-C_ROOT
          DOC "AVRO-C library root directory")

FIND_PATH(AVRO-C_INCLUDE_DIR
          NAMES avro.h
          HINTS ${AVRO-C_ROOT_DIR}
          PATH_SUFFIXES include
          DOC "AVRO-C include directory")

FIND_LIBRARY(AVRO-C_LIBRARY_RELEASE
             NAMES avro
             HINTS ${AVRO-C_ROOT_DIR}
             DOC "AVRO-C library file")
FIND_LIBRARY(AVRO-C_LIBRARY_DEBUG
             NAMES avro
             HINTS ${AVRO-C_ROOT_DIR}/debug
             DOC "AVRO-C library file")

include(SelectLibraryConfigurations)
select_library_configurations(AVRO-C)

IF (AVRO-C_LIBRARY AND AVRO-C_INCLUDE_DIR)
    GET_FILENAME_COMPONENT(AVRO-C_LIBRARY_DIR ${AVRO-C_LIBRARY} PATH)
    MARK_AS_ADVANCED(AVRO-C_INCLUDE_DIR AVRO-C_LIBRARY_DIR AVRO-C_LIBRARY)
    FIND_PACKAGE_HANDLE_STANDARD_ARGS(Avro-c DEFAULT_MSG AVRO-C_LIBRARY AVRO-C_INCLUDE_DIR)
ELSE ()
    SET(AVRO-C_FOUND FALSE)
    MESSAGE(FATAL_ERROR "avro-c library not found.")
ENDIF ()
