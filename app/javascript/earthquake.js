const world = Globe()
  .globeImageUrl('//unpkg.com/three-globe/example/img/earth-blue-marble.jpg')
  .bumpImageUrl('//unpkg.com/three-globe/example/img/earth-topology.png')
  .backgroundImageUrl('//unpkg.com/three-globe/example/img/night-sky.png')
  (document.getElementById('globeViz'));

// custom globe material
const globeMaterial = world.globeMaterial();
globeMaterial.bumpScale = 10;
new THREE.TextureLoader().load('//unpkg.com/three-globe/example/img/earth-water.png', texture => {
  globeMaterial.specularMap = texture;
  globeMaterial.specular = new THREE.Color('grey');
  globeMaterial.shininess = 17;
});

setTimeout(() => { // wait for scene to be populated (asynchronously)
  const directionalLight = world.scene().children.find(obj3d => obj3d.type === 'DirectionalLight');
  directionalLight && directionalLight.position.set(1, 1, 1); // change light position to see the specularMap's effect
});
