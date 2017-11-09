import on from 'on'
import ErrorMessage from 'error_message'

const Users = {
  ajaxError (e) {
    ErrorMessage.show(e.detail[0].error)
  }
}

on('ajax:error', '[role~=users-signup-form]', Users.ajaxError)

export default Users
