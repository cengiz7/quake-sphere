export default class QuakeSphere {

  constructor(data){
    this.quakeData = this.prepareQuakeData(data)
    this.world = Globe()
    this.bumpScale = 12
    this.shininess = 11
    this.ringResolution = 48
    this.ringAltitude = 0.0015
    this.maxR = 0.5,
    this.propagationSpeed = 0.24,
    this.repeatPeriod = 700
    this.ringColor = t => `rgba(255,255,0,1)` // `rgba(255,100,50,${Math.sqrt(1-t)})

    this.initializeWorld()
    this.setGlobeMaterial()
    setTimeout(this.setLightDirection()) //??? Todo
    this.setGlobeRings()
    this.setGlobeLabels()

    this.refreshQuakes()
    this.world.pointOfView({ lat: 36.88429922, lng: 30.70221813, altitude: 1 }, 2000)
  }

  initializeWorld() {
    this.world
    .globeImageUrl('//unpkg.com/three-globe/example/img/earth-blue-marble.jpg')
    .bumpImageUrl('//unpkg.com/three-globe/example/img/earth-topology.png')
    .backgroundImageUrl('//unpkg.com/three-globe/example/img/night-sky.png')
    (document.getElementById('globeSphere')) // TODO: reference
  }

  // custom globe material
  setGlobeMaterial() {
    const globeMaterial = this.world.globeMaterial()
    globeMaterial.bumpScale = this.bumpScale
    new THREE.TextureLoader().load('//unpkg.com/three-globe/example/img/earth-water.png',
      texture => {
        globeMaterial.specularMap = texture
        globeMaterial.specular = new THREE.Color('Gray')
        globeMaterial.shininess = this.shininess
    })
  }

  setLightDirection() {
    // TODO : not working
    // change light position to see the specularMap's effect
    const directionalLight = this.world.scene().children.find(obj3d => obj3d.type === 'DirectionalLight');
    directionalLight && directionalLight.position.set(1, 1, 1);
  }

  handleMouseClick(label, event, options) {
    console.info("Mouse click handled.")
  }

  setGlobeRings() {
    this.world
      .ringColor(() => this.ringColor)
      .ringMaxRadius('maxR')
      .ringPropagationSpeed('propagationSpeed')
      .ringRepeatPeriod('repeatPeriod')
      .ringResolution(this.ringResolution)
      .ringAltitude(this.ringAltitude)
  }

  setGlobeLabels() {
    this.world
      .labelLat(d => d.lat)
      .labelLng(d => d.lng)
      .labelLabel(d => `<b>${d.lat}</b> earthquakes in the past month:<ul><li>Hello</li><li>HMeeeello</li></ul>
                        <br><a href="google.com" target="_blank">Google.com</a>`)
      .labelText(d => '')
      .labelSize(0.2)
      .labelDotRadius(d => d.maxR / 4)
      .labelColor(() => 'rgba(255, 50, 50, 0.75)')
      .labelResolution(64)
      .labelAltitude(this.ringAltitude) // prevent ring waves from cut. the label anim.
      .onLabelClick(this.handleMouseClick)
      .onLabelRightClick(this.handleMouseClick)
  }

  refreshQuakes() {
    this.world.ringsData(this.quakeData)
    this.world.labelsData(this.quakeData)
  }

  prepareQuakeData(data) {
    this.quakeData = data.map((dt) => {
      dt.maxR = this.maxR
      dt.propagationSpeed = this.propagationSpeed
      dt.repeatPeriod = this.repeatPeriod
      return dt
    })
  }

  addQuakeData(data) {
    // TODO: check quake ids and filter
    this.quakeData = this.addQuakeData.concat(data)
    this.refreshQuakes()
  }
}