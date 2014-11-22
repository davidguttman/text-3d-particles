THREE = require 'three'
Emitter = require 'wildemitter'
ease = require 'ease-component'

cameraZ = 600

originVector = new THREE.Vector3 0,0,0

module.exports = Spriter = (@shapeCanvas, @opts = {}, @cb) ->
  Emitter.call this
  {density, background} = @opts
  
  ar = @shapeCanvas.width / @shapeCanvas.height

  @el = document.createElement 'div'

  @camera = new THREE.PerspectiveCamera 75, ar, 1, 5000
  @camera.position.z = cameraZ

  @scene = new THREE.Scene

  @material = new THREE.SpriteMaterial
    map: new THREE.Texture @generateSprite()
    blending: THREE.MultiplyBlending

  @addParticles @shapeCanvas, density

  @renderer = new THREE.CanvasRenderer
  @renderer.setClearColor @opts.background
  @renderer.setSize @shapeCanvas.width, @shapeCanvas.height

  @el.appendChild @renderer.domElement

  @initAnimation()
  unless @opts.autoStart is false
    @playing = true
    @animate()

  return this

Spriter.prototype = new Emitter

Spriter::addParticles = (shapeCanvas, density = 20) ->
  shapeContext = @shapeCanvas.getContext '2d'
  img = shapeContext.getImageData 0, 0, @shapeCanvas.width, @shapeCanvas.height

  for x in [0...@shapeCanvas.width] by density
    for y in [0...@shapeCanvas.height] by density
      color = getColor img, x, y
      if color[3] > 0
        xo = x * 2 - @shapeCanvas.width
        yo = @shapeCanvas.height - (y * 2) 
        particle = @initParticle xo, yo
        @scene.add particle

Spriter::initParticle = (x, y) ->
  particle = new THREE.Sprite @material

  cz = @camera.position.z
  z = gaussRand 0, cz/6

  x1 = x - (x*z/cz)
  y1 = y - (y*z/cz)
  z1 = z
  particle.position.set x1, y1, z1

  particle.scale.x = Math.random() * @opts.nodeSize + @opts.nodeSize/2
  particle.scale.y = particle.scale.x

  return particle

Spriter::initAnimation = ->
  @thetaStart = @opts.thetaStart ? 1.10 * Math.PI
  @thetaEnd = @opts.thetaEnd ? 2 * Math.PI
  @theta = @thetaStart

  @duration = @opts.duration or 10000
  @timeStart = @timeEnd = null

Spriter::animate = ->
  return unless @playing
  requestAnimationFrame @animate.bind(this)
  @render()

Spriter::generateSprite = ->
  canvas = document.createElement 'canvas'
  canvas.width = w = @opts.nodeSize
  canvas.height = h = @opts.nodeSize

  ctx = canvas.getContext '2d'
  
  ctx.fillStyle = @opts.foreground ? 'rgb(46,46,46)'
  
  r = canvas.width/4
  ctx.beginPath()
  ctx.arc w/2, h/2, r, 0, 2 * Math.PI, false
  ctx.fill()
  ctx.closePath()

  return canvas

Spriter::render = (p) ->
  now = Date.now()
  @timeStart = @timeStart or now
  @timeEnd = @timeEnd or @timeStart + @duration

  if @theta >= @thetaEnd * 0.9999
    if @opts.loop
      return @initAnimation()
    else
      @theta = @thetaEnd
      @playing = false
      @cb()

  p = p ? (now - @timeStart) / @duration
  val = ease.inOutSine p
  @theta = @thetaStart + (@thetaEnd - @thetaStart) * val
  
  @camera.position.x = Math.sin(@theta) * cameraZ
  @camera.position.y = Math.sin(@theta) * cameraZ
  @camera.position.z = Math.cos(@theta) * cameraZ
  @camera.lookAt originVector
  @renderer.render @scene, @camera
  @emit 'progress', p

getColor = (img, x, y) ->
  data = img.data
  i = (y * img.width + x) * 4
  [data[i], data[i+1], data[i+2], data[i+3]]

gaussRand = (mean=0.5, stdev=1/9) ->
  r = (Math.random() * 2 - 1) + (Math.random() * 2 - 1) + (Math.random() * 2 - 1)
  gauss = r * stdev + mean
