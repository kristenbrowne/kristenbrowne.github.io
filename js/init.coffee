---
---
###
	Arcana by HTML5 UP
	html5up.net | @n33co
	Free for personal and commercial use under the CCA 3.0 license (html5up.net/license)
###

(($) ->
  skel.init
    reset: 'full'
    breakpoints:
      global:
        range: '*'
        href: '{{site.url}}/css/style.css'
        containers: 1400
        grid: gutters: 50
      wide:
        range: '-1680'
        href: '{{site.url}}/css/style-wide.css'
        containers: 1200
        grid: gutters: 40
      normal:
        range: '-1280'
        href: '{{site.url}}/css/style-normal.css'
        containers: 960
        grid: gutters: 30
        viewport: scalable: false
      narrow:
        range: '-980'
        href: '{{site.url}}/css/style-narrow.css'
        containers: '95%'
      narrower:
        range: '-840'
        href: '{{site.url}}/css/style-narrower.css'
        containers: '95%!'
      mobile:
        range: '-736'
        href: '{{site.url}}/css/style-mobile.css'
        containers: '90%!'
        grid: gutters: 20
      mobilep:
        range: '-480'
        href: '{{site.url}}/css/style-mobilep.css'
        containers: '100%'
    plugins: layers:
      config: mode: 'transform'
      navPanel:
        animation: 'revealX'
        breakpoints: 'narrower'
        clickToHide: true
        height: '100%'
        hidden: true
        html: '<div data-action="navList" data-args="nav"></div>'
        orientation: 'vertical'
        position: 'top-left'
        side: 'left'
        width: 275
      titleBar:
        breakpoints: 'narrower'
        height: 44
        html: '<span class="toggle" data-action="toggleLayer" data-args="navPanel"></span><span class="title" data-action="copyHTML" data-args="logo"></span>'
        position: 'top-left'
        side: 'top'
        width: '100%'
  $ ->
    $window = $(window)
    $body = $('body')
    # Disable animations/transitions until the page has loaded.
    $body.addClass 'is-loading'
    $window.on 'load', ->
      $body.removeClass 'is-loading'
      return
    # Forms (IE<10).
    $form = $('form')
    if $form.length > 0
      $form.find('.form-button-submit').on 'click', ->
        $(this).parents('form').submit()
        false
      if skel.vars.IEVersion < 10

        $.fn.n33_formerize = ->
          _fakes = new Array
          _form = $(this)
          _form.find('input[type=text],textarea').each(->
            e = $(this)
            if e.val() == '' or e.val() == e.attr('placeholder')
              e.addClass 'formerize-placeholder'
              e.val e.attr('placeholder')
            return
          ).blur(->
            e = $(this)
            if e.attr('name').match(/_fakeformerizefield$/)
              return
            if e.val() == ''
              e.addClass 'formerize-placeholder'
              e.val e.attr('placeholder')
            return
          ).focus ->
            e = $(this)
            if e.attr('name').match(/_fakeformerizefield$/)
              return
            if e.val() == e.attr('placeholder')
              e.removeClass 'formerize-placeholder'
              e.val ''
            return
          _form.find('input[type=password]').each ->
            e = $(this)
            x = $($('<div>').append(e.clone()).remove().html().replace(/type="password"/i, 'type="text"').replace(/type=password/i, 'type=text'))
            if e.attr('id') != ''
              x.attr 'id', e.attr('id') + '_fakeformerizefield'
            if e.attr('name') != ''
              x.attr 'name', e.attr('name') + '_fakeformerizefield'
            x.addClass('formerize-placeholder').val(x.attr('placeholder')).insertAfter e
            if e.val() == ''
              e.hide()
            else
              x.hide()
            e.blur (event) ->
              `var x`
              `var e`
              event.preventDefault()
              e = $(this)
              x = e.parent().find('input[name=' + e.attr('name') + '_fakeformerizefield]')
              if e.val() == ''
                e.hide()
                x.show()
              return
            x.focus (event) ->
              `var e`
              `var x`
              event.preventDefault()
              x = $(this)
              e = x.parent().find('input[name=' + x.attr('name').replace('_fakeformerizefield', '') + ']')
              x.hide()
              e.show().focus()
              return
            x.keypress (event) ->
              event.preventDefault()
              x.val ''
              return
            return
          _form.submit(->
            $(this).find('input[type=text],input[type=password],textarea').each (event) ->
              e = $(this)
              if e.attr('name').match(/_fakeformerizefield$/)
                e.attr 'name', ''
              if e.val() == e.attr('placeholder')
                e.removeClass 'formerize-placeholder'
                e.val ''
              return
            return
          ).bind 'reset', (event) ->
            event.preventDefault()
            $(this).find('select').val $('option:first').val()
            $(this).find('input,textarea').each ->
              e = $(this)
              x = undefined
              e.removeClass 'formerize-placeholder'
              switch @type
                when 'submit', 'reset'
                  return
                when 'password'
                  e.val e.attr('defaultValue')
                  x = e.parent().find('input[name=' + e.attr('name') + '_fakeformerizefield]')
                  if e.val() == ''
                    e.hide()
                    x.show()
                  else
                    e.show()
                    x.hide()
                when 'checkbox', 'radio'
                  e.attr 'checked', e.attr('defaultValue')
                when 'text', 'textarea'
                  e.val e.attr('defaultValue')
                  if e.val() == ''
                    e.addClass 'formerize-placeholder'
                    e.val e.attr('placeholder')
                else
                  e.val e.attr('defaultValue')
                  break
              return
            window.setTimeout (->
              for x of _fakes
                _fakes[x].trigger 'formerize_sync'
              return
            ), 10
            return
          _form

        $form.n33_formerize()
    # Dropdowns.
    $('#nav > ul').dropotron
      offsetY: -15
      hoverDelay: 0
      alignment: 'center'
    return
  return
) jQuery

# ---
# generated by js2coffee 2.0.3
