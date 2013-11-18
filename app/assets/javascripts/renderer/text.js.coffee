do (root = OctoBlog.Renderer, $ = jQuery) ->
  name = "text"
  root[name] = {}

  (->
    # Public - render Markdown text
    #
    # Returns a jQuery object containing rendered text
    @render = (data) ->
      $el = $('<div></div>')
      $el.html(marked(data.data.text))

      return $el


  ).call(root[name])
