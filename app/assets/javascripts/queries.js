$(function() {
  $(".queryplan-js").treetable({
    expandable: true,
    initialState: "expanded"
  });
  $(".queryplan-js tbody tr").on("mousedown", function() {
    $("tr.selected").removeClass("selected");
    $(this).addClass("selected");
  });
});
