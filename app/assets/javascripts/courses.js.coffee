# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
ready = ->
  Messenger.options = {
    'extraClasses': 'messenger-fixed messenger-on-top messenger-on-right',
    'maxMessages': 5,
    'theme': 'air'
  }

  $('.btn-vote-course').unbind()
  $('.btn-follow-course').unbind()
  $('a.btn-vote-comment').unbind()
  $('a.btn-vote-reply').unbind()

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
  )

  $('.btn-vote-course').on("ajax:success", (e, data, status, xhr) ->
    $(this)
      .addClass 'vote-actived pure-disabled'
      .siblings '.btn-vote-course'
      .removeClass 'vote-actived pure-disabled'
    target_credit = $('#rank_on_course_' + data.votable_id)
    target_credit.html data.votable.score + '|' + data.votable.votes_count
    vote_success_msg = Messenger().post
      message: '已成功送出課程投票！'
      hideAfter: 3
      actions:
        cancel:
          label: '關閉訊息'
          action: ->
            vote_success_msg.hide()
  )

  $('a.btn-vote-comment').on("ajax:success", (e, data, status, xhr) ->
    $(this).addClass 'vote-actived pure-disabled'
    $('p a.btn-vote-comment')
      .not this
      .removeClass 'vote-actived pure-disabled'
    target_credit = $('#rank_on_comment_' + data.votable_id)
    target_credit.html data.votable.score + '|' + data.votable.votes_count
    vote_success_msg = Messenger().post
      message: '已成功送出留言投票！'
      hideAfter: 3
      actions:
        cancel:
          label: '關閉訊息'
          action: ->
            vote_success_msg.hide()
  )

  $('a.btn-vote-reply').on("ajax:success", (e, data, status, xhr) ->
    $(this)
      .addClass 'vote-actived pure-disabled'
      .siblings '.btn-vote-reply'
      .removeClass 'vote-actived pure-disabled'
    target_credit = $('#rank_on_reply_' + data.votable_id)
    target_credit.html data.votable.score + '|' + data.votable.votes_count
    vote_success_msg = Messenger().post
      message: '已成功送出評論投票！'
      hideAfter: 3
      actions:
        cancel:
          label: '關閉訊息'
          action: ->
            vote_success_msg.hide()
  )

  $('.btn-vote-course, a.btn-vote-comment, a.btn-vote-reply, .btn-follow-course')
  .on "ajax:error", (e, xhr, status, error) ->
    if xhr.status == 401
      errmsg = Messenger().post
        message: xhr.responseJSON.error
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
              errmsg.hide()

  $('#by_title').autocomplete
    source: (request, response) ->
      $.ajax
        url: '/courses/title'
        type: 'POST'
        dataType: 'json'
        data:
          query: request.term
        success: (res) ->
          response(res)
        error: ->
          response

  $('#by_instructor').autocomplete
    source: (request, response) ->
      $.ajax
        url: '/courses/instructor'
        type: 'POST'
        dataType: 'json'
        data:
          query: request.term
        success: (res) ->
          response(res)
        error: ->
          response

$(document).ready(ready)
$(document).ajaxComplete(ready)
$(document).on('page:load', ready)
