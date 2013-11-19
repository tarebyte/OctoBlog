//= require_self
//= require_tree .

do (App = OctoBlog, $ = jQuery) ->
  App.Renderer = {}
  (->

    marked.setOptions(
      gfm: true
      tables: true
      breaks: true
      smartypants: true
    )

    # Public - render SirTrevor data
    #
    # dataStr - a JSON string representing SirTrevor data
    #
    # Returns - a jQuery element contains the rendered view
    @render = (dataStr) =>
      data = JSON.parse(dataStr).data
      $el = $('<div></div>')
      data.forEach( (val, index, array) =>
        $el.append @[val.type.toLowerCase()].render(val)
      )

      return $el

    @renderBlock = (element) =>
      $el = $(element)
      $el.hide();
      data = $el.text()
      $el.html(@render(data))
      $el.show();

  ).call(App.Renderer)
