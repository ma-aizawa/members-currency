class @Exchange
  constructor: ->
    @setAmountOptionEvent()
    @setCancelEvent()

  setAmountOptionEvent: ->
    $('#exchange_currency').on 'change', @switchOptions
    @switchOptions()

  switchOptions: ->
    $selection = $('#amount_selection select')
    $selection.hide()
    $selection.attr('disabled', 'disabled')
    selected_currency_id = $('#exchange_currency').val()
    $selected_currency_select = $("#amount_of_#{selected_currency_id}")
    $selected_currency_select.show()
    $selected_currency_select.attr('disabled', false)

  setCancelEvent: ->
    $cancel = $('#cancel')
    return false unless $cancel?

    $cancel.on 'click', ->
      cancel_input = document.createElement('input')
      cancel_input.name = "cancel"
      cancel_input.value = "true"
      cancel_input.style.display = "none"
      form = document.getElementsByTagName('form')[0]
      form.appendChild(cancel_input)
      form.submit()


