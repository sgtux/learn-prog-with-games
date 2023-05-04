const dotenv = require('dotenv')
const result = dotenv.config()


if (result.error && !process.env.POKE_REMOTE_API) {
    throw result.error
}

module.exports = {
    remoteApi: process.env.POKE_REMOTE_API || result.parsed.POKE_REMOTE_API
}