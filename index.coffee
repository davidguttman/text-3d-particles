Spriter = require './spriter.coffee'

module.exports = (opts = {}, cb = ->) ->
  opts.density ?= 20
  opts.background ?= '#f6f6f6'
  opts.width ?= 800
  opts.height ?= 400
  opts.text ?= 'D'
  opts.fontSize ?= opts.height
  opts.nodeSize ?= opts.height / 20
  opts.loop ?= false
  
  canvas = document.createElement 'canvas'
  canvas.width = w = opts.width
  canvas.height = h = opts.height

  context = canvas.getContext '2d'

  context.font = "bold #{opts.fontSize}px Georgia"
  context.textAlign = 'center'
  context.fillText opts.text, w/2, h/2 + opts.fontSize/4

  spriter = new Spriter canvas, opts, cb
  spriter.el.classList.add 'text-graph-3d'
  return spriter
