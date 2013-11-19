# SirTrevor Code block type
SirTrevor.Blocks.Code = SirTrevor.Block.extend(

  title: "Code"
  type: "code"
  icon_name: 'code'
  editorHTML: ->
    "<div class='st-code-block'><pre><code contenteditable='true'></code></pre></div>"

  initialize: ->
    @$el.data("block", {data: {text: ""}})

  loadData: (data) ->
    @$el.find('code').html(data.text)

  toData: ->
    data = getCodeData(@.$('code'))
    @setData(
      "text": data
    )

  onBlockRender: ->
    $el = this.$el.find('code')

    @text_block = $el

    # listen to the keydown event
    $el.bind('keydown', keyDownListener)

)


# Private - Listen to keydown event on the text editor to capture the TAB key
# and insert 2 spaces
#
# evt - event object
keyDownListener = (evt) ->
  TABKEY = 9
  if evt.keyCode == TABKEY
    evt.preventDefault()
    document.execCommand('insertText', null, '  ')

# Private - get content of code block
# Convert <div> and <br> to newlines
#
# Current works in Chrome and Firefox, maybe different in other browsers
#
# $el - the `code` element
#
# Returns the content of the code element, properly formatted
getCodeData = ($el) ->
  block = $("<div>#{$el.html()}</div>")
  block.html().replace(/<div>/g,"\n").replace(/<\/div>/g, "").replace(/<br.?>/g, "\n")

