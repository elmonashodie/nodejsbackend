'use strict'

const mongoose = require('mongoose')

let isConnected = false

/**
 * Connect to MongoDB database
 *
 */
const connect = () => {
  mongoose.connect(process.env.MONGODB_URI, {
    useNewUrlParser: true
  }).catch(e => console.log(e))
}

/**
 * Connection to mongoose database.
 *
 */
module.exports.run = () => {
  mongoose.connection.on('connected', () => {
    isConnected = true
    console.log('Mongoose connection is open.')
  })

  mongoose.connection.on('disconnected', () => {
    if (!isConnected) {
      console.log('Disconnected retrying in 5 seconds')
      setTimeout(() => connect(), 5000)
    } else {
      console.log('Mongoose connection is disconnected.')
    }
  })

  // If the Node process ends, close the Mongoose connection.
  process.on('SIGINT', () => {
    mongoose.connection.close(() => {
      console.log('Mongoose connection is disconnected due to application termination.')
      process.exit(0)
    })
  })

  mongoose.connection.on('error', err => console.error(`Mongoose connection error has occured: ${err}`))

  connect()
}