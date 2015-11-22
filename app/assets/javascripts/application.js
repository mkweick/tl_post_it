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
//= require jquery_ujs
//= require turbolinks
//= require_tree .
//= require bootstrap
//= require jquery.turbolinks

$(document).ready(function() {
  if ($('.pagination')) {
    $(window).scroll(function() {
      var url = $('.pagination .next-page').attr('href');
      if (url && $(window).scrollTop() > $(document).height() - $(window).height() - 1000) {
        $('.pagination').html('<img src="/assets/ajax-loader.gif" alt="Loading more posts..." />');
        return $.getScript(url);
      }
      else if (!url && $(window).scrollTop() > $(document).height() - $(window).height() - 1000) {
        $('.pagination').html('<div class="span8 posts-end">No more posts to load. <a href="#top">Jump to Top of Page</a></div>');
      }
    });
    return $(window).scroll();
  }
});

$(document).ready(function() {
  if ($('.two-factor').is(':checked')) {
    $('#creator-phone').prop('disabled', false);
  }
  else {
    $('#creator-phone').prop('disabled', true);
  }

  $('.two-factor').click(function() {
    if($('.two-factor').is(':checked')) {
      $('#creator-phone').prop('disabled', false);
    }
    else {
      $('#creator-phone').prop('disabled', true);
    }
  });
});