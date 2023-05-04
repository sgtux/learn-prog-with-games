const path = require('path')
const express = require('express')
const repository = require('./pokemon-repository')

const app = express()

app.get('/pokemon', (req, res) => {
    const id = Number(req.query.id)
    repository.getPokemon(id)
        .then(p => res.json({ ...p, image: `/image?id=${id}` }))
        .catch(err => res.status(err.response.status)
            .end(err.response.status + ' - ' + err.response.statusText))
})

app.get('/pokemon/image', (req, res) => {
    const id = Number(req.query.id)
    repository.getPokemonImage(id)
        .then(filePath => {
            if (filePath)
                res.sendFile(filePath, { root: path.join(__dirname, '..') })
            else
                res.status(404).end('Image Not Found.')
        })
        .catch(err => {
            console.log(err)
            if ((err.response || {}).status === 404)
                return res.status(404).end('Image Not Found.')
            res.status(400).end('ERRO')
        })
})
const port = process.env.PORT || process.env.NODE_PORT || 3000
app.listen(port, () => console.log(`Listening in port ${port}`))