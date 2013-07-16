# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

# User sees the status of their recommendations updates dynamically
#
@UpdatePoller =
  poll: ->
    setTimeout @request, 1000

  request: ->
    $.post($('#update-status').data('url'))

# User can mark that they're not interested in a recommendation, and 
# it will never appear again.
#
$ ->
  $(".not-interested").on 'click', (event) =>
    $(event.currentTarget).closest(".recommendation").hide()
  if $('#update-status').length > 0
    UpdatePoller.poll()
