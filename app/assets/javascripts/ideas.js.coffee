# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/


jQuery ->
  $(document).ready ->
    $('.add_comment').on 'ajax:success', 'form', (event, data) ->
      $('.comments_list').append(data.comment)
      $text_field = $('.comment_body_input')
      $text_field.val("")
      $text_field.focus()

    $('.idea_title_input').focus()

    $('.nav_li').hover (event) ->
      $(this).toggleClass("active")

    $('.vote_up').on 'ajax:success', (event) ->
      $('.vote_buttons').hide()
      count = $('.up_vote_count').html()
      count = parseInt(count) + 1
      $('.up_vote_count').html(count)

    $('.vote_down').on 'ajax:success', (event) ->
      $('.vote_buttons').hide()
      count = $('.down_vote_count').html()
      count = parseInt(count) + 1
      $('.down_vote_count').html(count)

    $('form').on 'click', '.remove_fields', (event) ->
      $(this).prev('input[type=hidden]').val('1')
      $(this).closest('fieldset').hide()
      event.preventDefault()

    $('form').on 'click', '.add_fields', (event) ->
      time = new Date().getTime()
      regexp = new RegExp($(this).data('id'), 'g')
      $(this).before($(this).data('fields').replace(regexp, time))
      event.preventDefault()

    $('.edit_comment').on 'ajax:success', (event) ->
      $(this).closest('.comment').children().hide()
      $(this).closest('.comment').html("edit comment form")

    $('td a.archive').on 'ajax:success', (event) ->
      $(this).closest('tr').hide()

    $('.page#search').hide()

    $('#add_tab').addClass('active')    

    $('ul.nav.nav-tabs li').click ->
      $('ul.nav.nav-tabs li').removeClass('active')
      $('.page').hide()

    $('#add_tab').click ->
      $('#add_tab').addClass('active')    
      $('.page#add').show()

    $('#search_tab').click ->
      $('#search_tab').addClass('active')
      $('.page#search').show()

