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
  $('a.btn-vote-comment').unbind()
  $('a.btn-vote-reply').unbind()

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
  ).on "ajax:error", (e, xhr, status, error) ->
    if xhr.status == 401
      vote_errmsg = Messenger().post
        message: xhr.responseText
        hideAfter: 3
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
  ).on "ajax:error", (e, xhr, status, error) ->
    if xhr.status == 401
      vote_errmsg = Messenger().post
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
              vote_errmsg.hide()
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
  ).on "ajax:error", (e, xhr, status, error) ->
    if xhr.status == 401
      vote_errmsg = Messenger().post
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
              vote_errmsg.hide()

  $('#by_title').selectize
    labelField: 'title'
    valueField: 'title'
    searchField: 'title'
    closeAfterSelect: true
    create: false
    render:
      option: (item, escape) ->
        '<div><span>' + escape(item.title) + '</span></div>'
    load: (query, callback) ->
      return callback if !query.length
      $.ajax
        url: '/courses/title'
        type: 'POST'
        dataType: 'json'
        data:
          name: query
        success: (res) ->
          callback(res)
        error: ->
          callback
  $('#by_instructor').selectize
    labelField: 'instructor'
    valueField: 'instructor'
    searchField: 'instructor'
    closeAfterSelect: true
    create: false
    render:
      option: (item, escape) ->
        '<div><span>' + escape(item.instructor) + '</span></div>'
    load: (query, callback) ->
      return callback if !query.length
      $.ajax
        url: '/courses/instructor'
        type: 'POST'
        dataType: 'json'
        data:
          name: query
        success: (res) ->
          callback(res)
        error: ->
          callback

$(document).ready(ready)
$(document).ajaxComplete(ready)
$(document).on('page:load', ready)
