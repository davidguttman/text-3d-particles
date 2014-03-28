# Text 3D Particles

Hard to explain, but looks cool.

![star](http://i.imgur.com/hsVV9I4.gif)

To see it in action:

    npm run example

Usage:

```js

var text3dParticles = require('text-3d-particles')

var opts = 
  { width: 400
  , height: 400
  , text: '★'
  , foreground: '#707070'
  , background: '#f6f6f6'
  , duration: 6000
  }

var textGraph = text3dParticles(opts, function() {
  console.log('Animation completed.')
})

document.body.appendChild(textGraph)

```

# License

MIT