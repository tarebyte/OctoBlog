//= require_tree .

# Editor Module
#
# To be used on pages that require a Sir Trevor editor.

do (OctoBlog, $ = jQuery) ->
  OctoBlog.Editor ?= {}

  (->

    # Private Sir Trevor instance
    stInstance = null

    # Set default options
    SirTrevor.setDefaults(
      required: ["Text"]
      blockTypes: [ "Text","Heading","List","Code"]
    )

    # Public - Start up the Editor module
    #
    # element - a textarea area element
    @start = (element, data) ->
      stInstance = new SirTrevor.Editor el: $(element)
      stInstance.blocks[0]?.focus()



  ).call(OctoBlog.Editor)
