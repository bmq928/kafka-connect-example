const express = require('express')
const { Kafka } = require('kafkajs')
const {
  SchemaRegistry,
  SchemaType,
} = require('@kafkajs/confluent-schema-registry')

const schema = {
  type: 'record',
  name: 'NameSchema2',
  namespace: 'NamespaceSchema',
  fields: [
    { type: 'string', name: 'action' },
    { type: 'string', name: 'message' },
    { type: 'string', name: 'orgId' },
    { type: 'string', name: 'payload' },
    { type: 'string', name: 'userId' },
  ],
}

const registry = new SchemaRegistry({ host: 'http://localhost:8081' })
const kafka = new Kafka({
  brokers: ['localhost:9092'],
  clientId: 'clientId',
})
const consumer = kafka.consumer({ groupId: 'groupId' })
const producer = kafka.producer()

const incommingTopic = 'incomming6'
const outgoingTopic = 'outgoing6'

main().catch((err) => console.error({ err }))
async function main() {
  const { id: schemaId } = await registry.register({
    type: SchemaType.AVRO,
    schema: JSON.stringify(schema),
  })

  await producer.connect()

  await consumer.connect()
  await consumer.subscribe({ topic: incommingTopic })
  await consumer.run({
    eachMessage: async ({ message }) => {
      const data = await registry.decode(message.value)
      console.log({ consumer: { data, incommingTopic } })

      await producer.send({
        topic: outgoingTopic,
        messages: [
          {
            value: await registry.encode(schemaId, data),
            key: message.key,
          },
        ],
      })

      console.log({ producer: { data, outgoingTopic } })
    },
  })

  startServer()
  async function startServer() {
    const app = express()
    let counter = 0
    app.get('/send', async (req, res) => {
      const dataRaw = {
        userId: (++counter).toString(),
        action: 'kame',
        payload: JSON.stringify({ kame: 'joko' }),
        message: 'kame',
        orgId: 'asdkf',
        ...req.query,
      }
      const data = await registry.encode(schemaId, dataRaw)
      await producer.send({
        topic: incommingTopic,
        messages: [{ value: data, key: dataRaw.userId }],
      })
      console.log({ producer: { data, incommingTopic } })
      res.send(dataRaw)
    })

    app.get('/r', async (req, res) => {
      const getSchema = await registry.getSchema(schemaId)

      res.send({ getSchema })
    })

    app.listen(3000, () => console.log('app is started on port 3000'))
  }
}
