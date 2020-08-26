find_package(RdKafka CONFIG REQUIRED)

add_executable(serdes-kafka-avro-client
  serdes-kafka-avro-client.c
)
target_link_libraries(serdes-kafka-avro-client PRIVATE
  RdKafka::rdkafka Serdes::serdes
)

add_executable(serdes-tool
  serdes-tool.cpp
)
target_link_libraries(serdes-tool PRIVATE
  RdKafka::rdkafka++ Serdes::serdes++
)

add_executable(kafka-serdes-avro-console-consumer
  kafka-serdes-avro-console-consumer.cpp
)
target_link_libraries(kafka-serdes-avro-console-consumer PRIVATE
  RdKafka::rdkafka++ Serdes::serdes++
)

add_executable(kafka-serdes-avro-console-producer
  kafka-serdes-avro-console-producer.cpp
)
target_link_libraries(kafka-serdes-avro-console-producer PRIVATE
  RdKafka::rdkafka++ Serdes::serdes++
)
