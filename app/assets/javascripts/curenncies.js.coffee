class @Currency
  constructor: ->
    @setDisplayEvent()
    @addDistributeMember()
    @validateEqualAddAndDistribute()

  setDisplayEvent: ->
    $('#distribution_button').on 'click', ->
      $(@).hide()
      $('#distribution_member').show()

  addDistributeMember: ->
    $(document).on 'click', '.add_member', ->
      $control_group = $('#distribution_member .control-group')
      $button_control = $control_group.find('.button_control')
      $controls_of_member = $control_group.find('.controls:first').clone()

      $controls_of_member.find('input').val('')
      $controls_of_member.find('select').val('')

      $button_control.before($controls_of_member)
      $button_control.before($(document.createElement('br')))

      $remove_buttons = $('.remove_member')
      if $remove_buttons.length > 1
        $('.remove_member').show()

    $(document).on 'click', '.remove_member', ->
      $controls = $(@).parent('div.controls')
      $controls.next('br').remove()
      $controls.remove()

      $remove_buttons = $('.remove_member')
      if $remove_buttons.length is 1
        $('.remove_member').hide()

  validateEqualAddAndDistribute: ->
    $('#submit_button').on 'click', ->
      add_amount_string = $('#add_amount').val()
      if add_amount_string is '' or add_amount_string is '0'
        alert('通貨を追加する量を入力してください。')

        event.preventDefault()
        return false

      add_amount = parseInt(add_amount_string)


      sum_of_distribution = 0
      for member_amount in $('.member_amount')
        sum_of_distribution += parseInt(member_amount.value, 10)

      if sum_of_distribution isnt add_amount
        alert('通貨を追加する量とメンバーに発行する合計量を同じにしてください。')

        event.preventDefault()
        return false

      true

