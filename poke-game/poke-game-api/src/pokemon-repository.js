const fs = require('fs')
const path = require('path')
const axios = require('axios')
const http = require('https')
const sharp = require('sharp')

const config = require('./config')

const FILE_PATH = 'data.json'
const IMAGE_PATH = 'images'
let pokemons = []
if (fs.existsSync(FILE_PATH)) {
    pokemons = JSON.parse(fs.readFileSync(FILE_PATH, { encoding: 'utf-8' }))
    console.log(`Creating path: ${IMAGE_PATH}`)
}

if (!fs.existsSync(IMAGE_PATH)) {
    console.log(`Creating path: ${IMAGE_PATH}`)
    fs.mkdirSync(IMAGE_PATH)
}

const getFromApi = id => {
    return axios.get(config.remoteApi + id).then(res => {
        return {
            id: id,
            experience: res.data.base_experience,
            height: res.data.height,
            name: res.data.name,
            weight: res.data.weight,
            image: res.data.sprites.other['official-artwork'].front_default,
            stats: res.data.stats.map(p => ({
                name: p.stat.name,
                value: p.base_stat,
                effort: p.effort
            })),
            types: res.data.types.map(p => ({
                name: p.type.name,
                slot: p.slot,
                url: p.type.url
            }))
        }
    })
}

const getPokemon = id => {
    return new Promise((resolve, reject) => {
        const pokemon = pokemons.filter(p => p.id === id)[0]
        if (pokemon) {
            console.log(`Loaded ${id} from cache!`)
            resolve(pokemon)
        } else {
            getFromApi(id).then(p => {
                if (!pokemons.filter(p => p.id === id)[0])
                    pokemons.push(p)
                fs.writeFileSync(FILE_PATH, JSON.stringify(pokemons), { encoding: 'utf-8' })
                resolve(p)
            }).catch(err => {
                console.log(err)
                reject(err)
            })
        }
    })
}

const downloadFile = (url, filePath, resizedPath) => {
    return new Promise((resolve, reject) => {
        const file = fs.createWriteStream(filePath)
        http.get(url, res => {
            console.log('Resize to', resizedPath)
            res.pipe(file)
            setTimeout(() => {
                sharp(filePath)
                    .resize(150, 150)
                    .toFile(resizedPath)
                    .then(() => resolve())
                    .catch(err => {
                        console.log(err)
                        console.log('ERRO AQUI')
                        reject(err)
                    })
            }, 1000)
        })
    })
}

const getPokemonImage = async id => {
    let pokemon = pokemons.filter(p => p.id === id)[0]
    if (!pokemon) {
        pokemon = await getPokemon(id)
    }

    if (!pokemon)
        return

    const resizedPath = path.join(IMAGE_PATH, id + '_small' + '.png')

    if (fs.existsSync(resizedPath)) {
        console.log(`Loading image from cache: ${resizedPath}`)
        return resizedPath
    }

    const filePath = path.join(IMAGE_PATH, id + '.png')
    await downloadFile(pokemon.image, filePath, resizedPath)
    console.log(`Downloaded file to ${filePath}`)
    return resizedPath
}

module.exports = {
    getPokemon,
    getPokemonImage
}