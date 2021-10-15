# curl -X POST -H "Content-Type: application/json" http://localhost:8083/connectors --data '{
# "name": "converter",
# "config": {
# "connector.class": "io.confluent.connect.jdbc.JdbcSinkConnector",
# "connection.url": "jdbc:postgresql://postgres:5432/pg",
# "connection.user":"pg",
# "connection.password":"pg",
# "key.converter": "io.confluent.connect.avro.AvroConverter",
# "key.converter.schema.registry.url": "http://schema-registry:8081",
# "value.converter": "io.confluent.connect.avro.AvroConverter",
# "value.converter.schema.registry.url": "http://schema-registry:8081",
# "topics":"incomming",
# "pk.mode":"record_value",
# "pf.fields":"ad_id",
# "insert.mode":"upsert",
# "auto.create":"true",
# "auto.evolve":"true"
# }
# }' | jq

# curl -X POST -H "Content-Type: application/json" http://localhost:8083/connectors --data '{
# "name": "converter",
# "config": {
# "connector.class": "io.confluent.connect.jdbc.JdbcSinkConnector",
# "connection.url": "jdbc:postgresql://postgres:5432/pg",
# "connection.user":"pg",
# "connection.password":"pg",
# "key.converter": "io.confluent.connect.avro.AvroConverter",
# "key.converter.schema.registry.url": "http://schema-registry:8081",
# "value.converter": "io.confluent.connect.avro.AvroConverter",
# "value.converter.schema.registry.url": "http://schema-registry:8081",
# "topics":"incomming",
# "insert.mode":"upsert",
# "auto.create":"true",
# "pk.mode":"none",
# "auto.evolve":"true"
# }
# }' | jq

# curl -X POST -H "Content-Type: application/json" http://localhost:8083/connectors --data '{
# "name": "converter",
# "config": {
# "connector.class": "io.confluent.connect.jdbc.JdbcSinkConnector",
# "connection.url": "jdbc:postgresql://postgres:5432/pg",
# "connection.user":"pg",
# "connection.password":"pg",
# "key.converter": "io.confluent.connect.avro.AvroConverter",
# "key.converter.key.subject.name.strategy": "io.confluent.kafka.serializers.subject.RecordNameStrategy",
# "key.converter.schema.registry.url": "http://schema-registry:8081",
# "value.converter": "io.confluent.connect.avro.AvroConverter",
# "value.converter.value.subject.name.strategy": "io.confluent.kafka.serializers.subject.RecordNameStrategy",
# "value.converter.schema.registry.url": "http://schema-registry:8081",
# "topics":"incomming4",
# "insert.mode":"upsert",
# "auto.create":"true",
# "pk.mode":"none", 
# "auto.evolve":"true"
# }
# }' | jq

curl -X POST -H "Content-Type: application/json" http://localhost:8083/connectors --data '{
"name": "converter",
"config": {
"connector.class": "io.confluent.connect.jdbc.JdbcSinkConnector",
"connection.url": "jdbc:postgresql://postgres:5432/pg",
"connection.user":"pg",
"connection.password":"pg",
"key.converter": "org.apache.kafka.connect.storage.StringConverter",
"value.converter": "io.confluent.connect.avro.AvroConverter",
"value.converter.value.subject.name.strategy": "io.confluent.kafka.serializers.subject.RecordNameStrategy",
"value.converter.schema.registry.url": "http://schema-registry:8081",
"topics":"incomming6",
"insert.mode":"upsert",
"auto.create":"true",
"pk.mode":"none",
"auto.evolve":"true",
"pk.mode":"record_value",
"pf.fields":"userId"
}
}' | jq