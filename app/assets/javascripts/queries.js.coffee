
$ ->
  $(".queryplan-js").treetable
    expandable: true
    initialState: "expanded"

  #hilight selected row
  $(".queryplan-js tbody tr").on "mousedown", ->
    $("tr.selected").removeClass("selected");
    $(@).addClass("selected");
