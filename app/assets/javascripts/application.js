// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require bootstrap-sprockets
//= require jquery_ujs
//= require turbolinks
//= require_tree .
//= require autosize
//= require moment
//= require moment/zh-tw
/*!
 * Bootstrap v3.3.1 (http://getbootstrap.com)
 * Copyright 2011-2014 Twitter, Inc.
 * Licensed under MIT (https://github.com/twbs/bootstrap/blob/master/LICENSE)
 */

$(function(){
	$('.date').each(function() {
		var date = $(this).data('date');
	  var date_formatted = moment(date).startOf('minute').fromNow();
	  $(this).text(date_formatted);
	});

	$('.nav-btn').on('click', function(){
		$(this).toggleClass('active');
		$('.nav-list').toggleClass('open');
	});


	/* totop button toggle */
	$(window).scroll(function(){
		if ($(this).scrollTop() > 100) {
			$('.totop').fadeIn("slow");
		} else {
			$('.totop').fadeOut("slow");
		}
	});

	/* click event to scroll to top */
	$('.totop').click(function(){
		$('html, body').animate({scrollTop : 0},800);
		return false;
	});

	/* Show Comments or Replies */
	$('.switch').on('click', function(){
		$(this).children().toggleClass('fa-minus fa-plus');
	});
});