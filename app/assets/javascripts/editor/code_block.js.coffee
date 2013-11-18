# SirTrevor Code block type
SirTrevor.Blocks.Code = SirTrevor.Block.extend(

  title: "Code"
  type: "code"
  icon_name: 'code'
  editorHTML: ->
    "<div class='st-code-block'><pre><code contenteditable='true'></pre></code></div>"

  initialize: ->
    @$el.data("block", {data: {text: ""}})

  loadData: (data) ->
    @$el.find('code').html(data.text)


  toData: ->
    @setData(
      "text": @$('code').text()
    )

  onBlockRender: ->
    $el = this.$el.find('code')

    @text_block = $el

    # listen to the keydown event
    $el.bind('keydown', keyDownListener)

)


# Private - Listen to keydown event on the text editor to capture the TAB key
# and insert 4 spaces
#
# evt - event object
keyDownListener = (evt) ->
  TABKEY = 9
  if evt.keyCode == TABKEY
    evt.preventDefault()
    document.execCommand('insertText', null, '    ')
