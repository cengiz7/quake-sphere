const world = Globe()
  .globeImageUrl('//unpkg.com/three-globe/example/img/earth-blue-marble.jpg')
  .bumpImageUrl('//unpkg.com/three-globe/example/img/earth-topology.png')
  .backgroundImageUrl('//unpkg.com/three-globe/example/img/night-sky.png')
  (document.getElementById('globeSphere'));

// custom globe material
const globeMaterial = world.globeMaterial();
globeMaterial.bumpScale = 12;
new THREE.TextureLoader().load('//unpkg.com/three-globe/example/img/earth-water.png', texture => {
  globeMaterial.specularMap = texture;
  globeMaterial.specular = new THREE.Color('Gray');
  globeMaterial.shininess = 15;
});

setTimeout(() => { // wait for scene to be populated (asynchronously)
  const directionalLight = world.scene().children.find(obj3d => obj3d.type === 'DirectionalLight');
  directionalLight && directionalLight.position.set(1, 1, 1); // change light position to see the specularMap's effect
});


// Gen random data
/*
const N = 10;
const gData = [...Array(N).keys()].map(() => ({
  lat: (Math.random() - 0.5) * 180,
  lng: (Math.random() - 0.5) * 360,
  maxR: Math.random() * 20 + 3,
  propagationSpeed: (Math.random() - 0.5) * 20 + 1,
  repeatPeriod: Math.random() * 2000 + 200
}));
*/
const gData = [
  {
    lat: 36.88429922,
    lng: 30.70221813,
    maxR: 3,
    propagationSpeed: -3,
    repeatPeriod: 500,
  },
  {
    lat: 40.88429922,
    lng: 30.70221813,
    maxR: 3,
    propagationSpeed: -5,
    repeatPeriod: 400
  }
]

// const colorInterpolator = t => `rgba(255,100,50,${Math.sqrt(1-t)})`;
const colorInterpolator = t => `rgba(255,255,0,1)`;

world.ringsData(gData)
  .ringColor(() => colorInterpolator)
  .ringMaxRadius('maxR')
  .ringPropagationSpeed('propagationSpeed')
  .ringRepeatPeriod('repeatPeriod')
  .ringResolution(48)
  .ringAltitude(0.002)