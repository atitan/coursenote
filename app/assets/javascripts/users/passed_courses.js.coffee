# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = ->
	$('#passed_courses_passed_course').selectize()
	# $('div.selectize-input').addClass 'form-control'

$(document).ready(ready)
$(document).ajaxComplete(ready)
$(document).on('page:load', ready)