# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = ->
  $('#passed_courses_passed_course').autocomplete
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

$(document).ready(ready)
$(document).ajaxComplete(ready)
$(document).on('page:load', ready)