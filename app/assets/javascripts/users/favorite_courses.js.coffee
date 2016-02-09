# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
ready = ->
  Messenger.options = {
    'extraClasses': 'messenger-fixed messenger-on-top messenger-on-right',
    'maxMessages': 5,
    'theme': 'air'
  }

  $('.btn-follow-course').unbind()

  $('.btn-follow-course').on("ajax:success", (e, data, status, xhr) ->
    $(this).addClass 'follow-actived pure-disabled'
    follow_success_msg = Messenger().post
      message: '已成功追蹤課程！'
      hideAfter: 3
      actions:
        cancel:
          label: '關閉訊息'
          action: ->
            follow_success_msg.hide()
  ).on "ajax:error", (e, xhr, status, error) ->
    if xhr.status == 401
      follow_errmsg = Messenger().post
        message: xhr.responseText
        type: 'error'
        hideAfter: 3
        actions:
          login:
            label: '按此登入'
            action: ->
              window.location = '/users/sign_in'
          cancel:
            label: '關閉訊息'
            action: ->
              follow_errmsg.hide()

$(document).ready(ready)
$(document).ajaxComplete(ready)
$(document).on('page:load', ready)
