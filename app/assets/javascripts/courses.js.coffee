# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
ready = ->
  Messenger.options = {
    'extraClasses': 'messenger-fixed messenger-on-top messenger-on-right',
    'maxMessages': 5,
    'theme': 'air'
  }

  $('a.btn-vote-course').on("ajax:success", (e, data, status, xhr) ->
    vote_success_msg = Messenger().post
        message: '已成功送出投票！'
        actions:
            cancel:
                label: '關閉訊息'
                action: ->
                    vote_success_msg.hide()
  ).on "ajax:error", (e, xhr, status, error) ->
    if xhr.status == 401
      vote_errmsg = Messenger().post
          message: xhr.responseText
          type: 'error'
          actions:
              login:
                  label: '按此登入'
                  action: ->
                      window.location = '/users/sign_in'
              cancel:
                  label: '關閉訊息'
                  action: ->
                      vote_errmsg.hide()

$(document).ready(ready)
$(document).on('page:load', ready)
