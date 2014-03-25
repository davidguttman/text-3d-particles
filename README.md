# Text 3D Particles

Hard to explain, but looks cool.

To see it in action:

    npm run example

Usage:

```js

var text3dParticles = require('text-3d-particles')

var opts = 
  { width: 800
  , height: 400
  , text: '★'
  , fontSize: 400
  , density: 15
  , nodeSize: 20
  , background: '#f6f6f6'
  }

var textGraph = text3dParticles(opts, function() {
  console.log('Animation completed.')
})

document.body.appendChild(textGraph)

```

# License

MIT