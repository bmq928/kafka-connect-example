const {
  SchemaRegistry,
  SchemaType,
} = require('@kafkajs/confluent-schema-registry')

main()
async function main() {
  const registry = new SchemaRegistry({ host: 'http://localhost:8081' })

  // Upload a schema to the registry
//   const schema = `
//   {
//     "type": "record",
//     "name": "RandomTest1",
//     "namespace": "examples",
//     "fields": [{ "type": "string", "name": "fullName" }]
//   }
// `
  const schema = JSON.stringify({
    type: 'record',
    name: 'RandomTest2',
    namespace: 'examples',
    fields: [{ type: 'string', name: 'fullName' }],
  })
  const { id } = await registry.register({
    type: SchemaType.AVRO,
    schema,
  })

  // Encode using the uploaded schema
  const payload = { fullName: 'John Doe' }
  const encodedPayload = await registry.encode(id, payload)

  // Decode the payload
  const decodedPayload = await registry.decode(encodedPayload)
}
