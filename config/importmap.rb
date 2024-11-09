# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"

pin "bootstrap", to: "https://cdn.skypack.dev/bootstrap@5.3.0-alpha1"
pin "@popperjs/core", to: "https://cdn.skypack.dev/@popperjs/core@2.11.6"
pin_all_from "app/javascript/controllers", under: "controllers"
