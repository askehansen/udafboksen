import on from 'on'

const ErrorMessage = {

  show (message) {
    const errorMessage = document.createElement('div')
    errorMessage.className = 'error-message'
    errorMessage.setAttribute('role', 'error-message')

    const text = document.createElement('div')
    text.className = 'error-message-text'
    text.innerText = message

    const button = document.createElement('button')
    button.innerText = 'Prøv igen'
    button.className = 'error-message-button'
    button.setAttribute('role', 'error-message-button')
    button.type = 'button'

    errorMessage.appendChild(text)
    errorMessage.appendChild(button)
    document.body.appendChild(errorMessage)
  },

  hide () {
    document.querySelector('[role~=error-message]').remove()
  }

}

on('click', '[role~=error-message-button]', ErrorMessage.hide)

export default ErrorMessage
