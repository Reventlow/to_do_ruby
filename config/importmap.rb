# config/importmap.rb

pin "@rails/ujs", to: "https://cdn.skypack.dev/@rails/ujs", preload: true
# This assumes you're managing Rails UJS via Import Maps, and it's available from a CDN like skypack.dev

# Pin any local files you might have
pin "application", preload: true

# If you're not using these frameworks, you can remove or comment out these lines
# pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
# pin "@hotwired/stimulus", to: "stimulus.min.js", preload: true
# pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true

# Since you're loading Bootstrap from a CDN via a script tag in your HTML, you don't need to pin it here
# pin "bootstrap", to: "https://cdn.skypack.dev/bootstrap", preload: true