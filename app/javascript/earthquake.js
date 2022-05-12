const ringAltitude = 0.0015

const world = Globe()
  .globeImageUrl('//unpkg.com/three-globe/example/img/earth-blue-marble.jpg')
  .bumpImageUrl('//unpkg.com/three-globe/example/img/earth-topology.png')
  .backgroundImageUrl('//unpkg.com/three-globe/example/img/night-sky.png')
  (document.getElementById('globeSphere'));
  
world.pointOfView({ lat: 36.88429922, lng: 30.70221813, altitude: 0.5 }, 2000)

// custom globe material
const globeMaterial = world.globeMaterial();
globeMaterial.bumpScale = 12;
new THREE.TextureLoader().load('//unpkg.com/three-globe/example/img/earth-water.png', texture => {
  globeMaterial.specularMap = texture;
  globeMaterial.specular = new THREE.Color('Gray');
  globeMaterial.shininess = 11;
});

setTimeout(() => { // wait for scene to be populated (asynchronously)
  const directionalLight = world.scene().children.find(obj3d => obj3d.type === 'DirectionalLight');
  directionalLight && directionalLight.position.set(1, 1, 1); // change light position to see the specularMap's effect
});

function deneme(label, event, options) {
  console.log(label)
  gData.push({
    lat: 50.88429922,
    lng: 35.70221813,
    maxR: 1.5,
    propagationSpeed: -0.9,
    repeatPeriod: 350,
  })
  world.labelsData(gData)
}

let gData = [
  {
    lat: 36.88429922,
    lng: 30.70221813,
    maxR: 1,
    propagationSpeed: 0.8,
    repeatPeriod: 350,
  }
]

// const colorInterpolator = t => `rgba(255,100,50,${Math.sqrt(1-t)})`;
const ringColor = t => `rgba(255,255,0,1)`;

world.ringsData(gData)
  .ringColor(() => ringColor)
  .ringMaxRadius('maxR')
  .ringPropagationSpeed('propagationSpeed')
  .ringRepeatPeriod('repeatPeriod')
  .ringResolution(48)
  .ringAltitude(ringAltitude)



world
  .labelsData(gData)
  .labelLat(d => d.lat)
  .labelLng(d => d.lng)
  .labelLabel(d => `<b>${d.lat}</b> earthquakes in the past month:<ul><li>Hello</li><li>HMeeeello</li></ul>
                    <br><a href="google.com" target="_blank">Google.com</a>`)
  .labelText(d => '')
  .labelSize(0.5)
  .labelResolution(3)
  .labelDotRadius(d => d.maxR / 2)
  .labelColor(() => 'rgba(255, 50, 50, 0.75)')
  .labelResolution(64)
  .labelAltitude(ringAltitude + 0.001) // prevent ring waves from cut. the label anim.
  .onLabelRightClick(deneme)


setTimeout(()=>{world.pointOfView({ lat: 56.88429922, lng: 60.70221813, altitude: 0.7 }, 2000)
}, 5000)