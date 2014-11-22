var text3dParticles = require('../')

var opts = 
  { width: 800
  , height: 400
  , text: '★'
  , fontSize: 400
  , density: 15
  , nodeSize: 20
  , foreground: '#707070'
  , background: '#f6f6f6'
  , duration: 10000
  , thetaStart: 0
  , thetaEnd: 2 * Math.PI
  , loop: true
  }

var particles = text3dParticles(opts, function() {
  console.log('Animation completed.') // would get called if opts.loop != true
})

document.body.appendChild(particles.el)
