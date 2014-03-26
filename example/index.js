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
  }

var particles = text3dParticles(opts, function() {
  console.log('Animation completed.')
})

document.body.appendChild(particles)
