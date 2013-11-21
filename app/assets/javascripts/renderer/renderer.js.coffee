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
    # options -
    #   excerpt: (number) number of SirTrevor blocks to render, -1 for all
    #             default: -1
    #
    # Returns - a jQuery element contains the rendered view
    @render = (dataStr, options = {}) =>

      data = JSON.parse(dataStr).data
      $el = $('<div></div>')

      excerpt = options.excerpt || -1

      count = if excerpt < 0 then data.length else excerpt
      for num in [0...count] by 1
        val = data[num]
        $el.append @[val.type.toLowerCase()].render(val)

      return $el

    @renderBlock = (element, options = {}) =>
      $el = $(element)
      $el.hide();
      data = $el.text()
      $el.html(@render(data, options))
      $el.show();

  ).call(App.Renderer)
