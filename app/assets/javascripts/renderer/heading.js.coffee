do (root = OctoBlog.Renderer, $ = jQuery) ->
  name = "heading"
  root[name] = {}

  (->
    # Public - render Markdown text
    #
    # Returns a jQuery object containing rendered text
    @render = (data) ->
      $el = $('<h2></h2>')
      $el.html(marked(data.data.text))

      return $el


  ).call(root[name])
