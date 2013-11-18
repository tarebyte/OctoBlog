do (root = OctoBlog.Renderer, Highlighter = OctoBlog.Highlighter, $ = jQuery) ->
  name = "code"
  root[name] = {}

  (->
    # Public - render Markdown text
    #
    # Returns a jQuery object containing rendered text
    @render = (data) ->
      $el = $('<div><pre><code></code</pre></div>')
      content = $('<div />').html(data.data.text).text();
      console.log content
      $el.find('code').html(Highlighter.highlight(content))

      return $el


  ).call(root[name])
