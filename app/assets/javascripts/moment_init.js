var moment = function() {
	$('.date').each(function() {
		console.log('test');
		var date = $(this).data('date');
		var date_formatted = moment(date).startOf('minute').fromNow();
		$(this).text(date_formatted);
	});
};

$(document).ready(moment);
$(document).ajaxComplete(moment);
$(document).on('page:load', moment);