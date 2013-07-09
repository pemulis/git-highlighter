# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

# User can mark that they're not interested in a recommendation, and 
# it will never appear again.
#
$ ->
  $(".not-interested").on 'click', (event) =>
    $(event.currentTarget).closest(".recommendation").hide()
