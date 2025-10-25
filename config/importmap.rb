# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "stimulus.min.js", preload: true
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true
pin_all_from "app/javascript/controllers", under: "controllers"
pin "@rails/actioncable", to: "actioncable.esm.js"
pin_all_from "app/javascript/channels", under: "channels"
pin "quake_sphere"
pin "three", to: "https://cdnjs.cloudflare.com/ajax/libs/three.js/0.180.0/three.webgpu.min.js"
pin "globe", to: "https://unpkg.com/globe.gl@2.44.1/dist/globe.gl.min.js"
