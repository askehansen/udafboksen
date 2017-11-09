function on (eventName, selector, callback) {
  document.addEventListener(eventName, function (event) {
    var elem = event.srcElement || event.target
    var matches = elem.matches || elem.matchesSelector
    window.elem = elem
    window.matches = matches
    if (matches.call(elem, selector)) {
      callback.call(elem, event)
    }
  })
}

export default on
