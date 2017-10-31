var users = new function () {

  this.ajaxError = function (e) {

    var errorMessage = document.createElement('div')
    errorMessage.className = 'error-message'
    errorMessage.setAttribute('role', 'error-message')

    var text = document.createElement('div')
    text.className = 'error-message-text'
    text.innerText = e.detail[0].error

    var button = document.createElement('button')
    button.innerText = 'Prøv igen'
    button.className = 'error-message-button'
    button.setAttribute('role', 'error-message-button')
    button.type = 'button'

    errorMessage.appendChild(text)
    errorMessage.appendChild(button)
    document.body.appendChild(errorMessage)

  }

}

on('ajax:error', '[role~=users-form]', users.ajaxError)
