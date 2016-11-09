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

  $(".js-select2").select2()

  if ($extraFieldsEl = $("[data-extra-fields]")).length > 0
    $pageLayoutSelectEl = $("#page_layout_id")

    $pageLayoutSelectEl.change( (ev) ->
      selected = $pageLayoutSelectEl.find("option:selected").text()

      if selected == $extraFieldsEl.data("extra-fields")
        $extraFieldsEl.show()
      else
        $extraFieldsEl.hide()
    )

  if ($addTargetEl = $(".js-add-target")).length > 0
    $addTargetEl.find(".js-trigger").click( (ev) ->
      ev.preventDefault()

      timestamp = Date.now()
      $addTargetEl.find(".js-target").append("""
        <div style="margin-bottom: 1rem;">
          <div class="form-group">
            <label class="control-label col-sm-2" for="">Target title</label>
            <div class="col-sm-10">
              <input type="text" name="mea[mea_targets_attributes][#{timestamp}][target_title]" placeholder="Target Title" class="form-control">
            </div>
          </div>
          <div class="form-group">
            <label class="control-label col-sm-2" for="">Name</label>
            <div class="col-sm-10">
              <input type="text" name="mea[mea_targets_attributes][#{timestamp}][name]" placeholder="Name" class="form-control">
            </div>
          </div>
          <div class="form-group">
            <label class="control-label col-sm-2" for="">Description</label>
            <div class="col-sm-10">
              <textarea name="mea[mea_targets_attributes][#{timestamp}][description]" placeholder="Description" class="form-control"></textarea>
            </div>
          </div>
          <div class="form-group">
            <label class="control-label col-sm-2" for="">Logo</label>
            <div class="col-sm-10">
              <input type="file" name="mea[mea_targets_attributes][#{timestamp}][logo]" class="form-control">
            </div>
          </div>
        </div>
        <hr>
      """)
    )

  if ($checkShowTrigger = $("[data-check-show-trigger]")).length > 0
    id = $checkShowTrigger.data("check-show-trigger")
    $checkShowTarget = $("[data-check-show-target='#{id}']")
    $checkShowTrigger.change( (ev) ->
      if $checkShowTrigger.is(":checked")
        $checkShowTarget.show()
      else
        $checkShowTarget.hide()
    )

    $checkShowTrigger.change()
)
