$(document).ready( ->
  if ($addResourcesEl = $(".js-add-resources")).length > 0
    $addResourcesEl.find(".js-trigger").click( (ev) ->
      ev.preventDefault()

      $addResourcesEl.find(".js-target").append("""
        <input type="text" name="resources[][label]" placeholder="Label" class="form-control">
        <input type="file" name="resources[][file]" placeholder="File" class="form-control">
      """)
    )

  if ($addDisaggregationsEl = $(".js-add-disaggregation")).length > 0
    $addDisaggregationsEl.find(".js-trigger").click( (ev) ->
      ev.preventDefault()

      $addDisaggregationsEl.find(".js-target").append("""
        <div style="margin-bottom: 1rem;">
          <input type="text" name="disaggregations[][label]" placeholder="Label" class="form-control">
          <input type="url" name="disaggregations[][url]" placeholder="URL" class="form-control">
        </div>
      """)
    )
)
