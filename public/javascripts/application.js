// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

// jQuery plugins code
	$(function() {
		$(".datepicker").datepicker();
		$( "#accordion" ).accordion({ autoHeight: false });
		$('#item_slides').cycle();
		
	});
	
	
// Flash fade
	$(function() {
	   $("#flash_notice").fadeIn('normal', function() {
	      $(this).delay(3700).fadeOut();
	   });
		 $('#flash_error').fadeIn('normal', function() {
	      $(this).delay(3700).fadeOut();
	   });
	});
	
	// $(function() {
	//    $('#flash_error').fadeIn('normal', function() {
	//       $(this).delay(3700).fadeOut();
	//    });
	// });
	

// TokenInput code
$(function() {
  $("#item_category_tokens").tokenInput("/categories.json", {
    crossDomain: false,
    prePopulate: $("#item_category_tokens").data("pre"),
		theme: 'facebook'
  });

	$("#item_color_tokens").tokenInput("/colors.json", {
    crossDomain: false,
    prePopulate: $("#item_color_tokens").data("pre"),
		theme: 'facebook'
  });
});
