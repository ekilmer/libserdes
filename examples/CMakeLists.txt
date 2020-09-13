if(NOT DEFINED PROJECT_NAME)
  cmake_minimum_required(VERSION 3.1)

  project(SerdesExamples C CXX)
  set(CMAKE_CXX_STANDARD 11)

  find_package(Serdes CONFIG REQUIRED)
endif()

find_package(RdKafka CONFIG REQUIRED)

if(WIN32)
  set(GET_OPT_SRC win32/wingetopt.c)
endif()

add_executable(serdes-kafka-avro-client
  serdes-kafka-avro-client.c ${GET_OPT_SRC}
)
target_link_libraries(serdes-kafka-avro-client PRIVATE
  RdKafka::rdkafka Serdes::serdes
)

add_executable(serdes-tool
  serdes-tool.cpp ${GET_OPT_SRC}
)
target_link_libraries(serdes-tool PRIVATE
  Serdes::serdes++
)

add_executable(kafka-serdes-avro-console-consumer
  kafka-serdes-avro-console-consumer.cpp ${GET_OPT_SRC}
)
target_link_libraries(kafka-serdes-avro-console-consumer PRIVATE
  RdKafka::rdkafka++ Serdes::serdes++
)

add_executable(kafka-serdes-avro-console-producer
  kafka-serdes-avro-console-producer.cpp ${GET_OPT_SRC}
)
target_link_libraries(kafka-serdes-avro-console-producer PRIVATE
  RdKafka::rdkafka++ Serdes::serdes++
)
