# Highlighter module
#
# Facade to a highlighting library (highlightjs at the moment).
do (App = OctoBlog) ->
  App.Highlighter ?= {}

  (->
    # Public - Highlighting with automatic language detection
    #
    # value - (String) the code to be highlighted
    #
    # Returns a string of HTML represents the highlighted code
    @highlight = (value) ->

  ).call(App.Highlighter)
