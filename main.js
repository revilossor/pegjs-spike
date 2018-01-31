const peg = require('pegjs')
const fs = require('fs')
const util = require('util')
const path = require('path')

const getParsers = () => {
  let parsers = {}
  return new Promise((resolve, reject) => {
    util.promisify(fs.readdir)(path.join(__dirname, './parsers')).then(result => {
      Promise.all(result.map(filename => {
        return util.promisify(fs.readFile)(path.join(__dirname, './parsers', filename)).then(parser => {
          parsers[filename.split('.')[0]] = peg.generate(`${parser}`)
        }).catch(reject)
      })).then(res => {
        resolve(parsers)
      })
    }).catch(reject)
  })
}

const state = {
  firstname: 'Oliver',
  lastname: 'Ross',
  job: 'Software Engineer'
}

getParsers().then(parsers => {
  console.log(parsers.state.parse('firstname==Oliver', state))
})
