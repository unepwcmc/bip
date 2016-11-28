$(document).ready( ->
  if ($addResourcesEl = $(".js-add-resources")).length > 0
    $addResourcesEl.find(".js-trigger").click( (ev) ->
      ev.preventDefault()

      $addResourcesEl.find(".js-target").append("""
        <label for="resources[][label]">Label</label>
        <input type="text" name="resources[][label]" placeholder="Label" class="form-control">

        <label style="margin-top: 1rem;" for="resources[][kind]">Type of resource</label>
        <select name="resources[][kind]" class="form-control">
          <option value="file">File</option>
          <option value="link">Link</option>
        </select>

        <label style="margin-top: 1rem;" for="resources[][file]">File</label>
        <input type="file" name="resources[][file]" placeholder="File" class="form-control">

        <label style="margin-top: 1rem;" for="resources[][url]">Link</label>
        <input style="margin-bottom: 1rem;" type="url" name="resources[][url]" placeholder="Leave blank if resource is a file" class="form-control">
      """)
    )

  if ($resourceEl = $("[data-resource-trigger]")).length > 0
    $resourceEl.each( (_i, el) ->
      $el = $(el)
      resourceId = $el.data("resource-trigger")

      $showEl = $("[data-resource-show='#{resourceId}']")
      $editEl = $("[data-resource-edit='#{resourceId}']")

      $el.click( (ev) ->
        ev.preventDefault()
        $showEl.toggle()
        $editEl.toggle()
      )
    )

  $(".js-select2").select2()
  $(".js-select2-tags").select2({tags: true})

  if ($extraFieldsEl = $("[data-extra-fields]")).length > 0
    $pageLayoutSelectEl = $("#page_layout_id")

    $pageLayoutSelectEl.change( (ev) ->
      selected = $pageLayoutSelectEl.find("option:selected").text()

      $extraFieldsEl.each( (i, el) ->
        $el = $(el)

        if selected == $el.data("extra-fields")
          $el.show()
        else
          $el.hide()
      )
    )

    $pageLayoutSelectEl.change()

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


  csrf_token = $('meta[name=csrf-token]').attr('content')
  csrf_param = $('meta[name=csrf-param]').attr('content')

  if (csrf_param != undefined && csrf_token != undefined)
    params = csrf_param + "=" + encodeURIComponent(csrf_token)

  $('textarea[data-custom-rich-text]').redactor(
    minHeight:        160
    autoresize:       true
    imageUpload:      "#{CMS.file_upload_path}?source=redactor&type=image&#{params}"
    imageManagerJson: "#{CMS.file_upload_path}?source=redactor&type=image"
    fileUpload:       "#{CMS.file_upload_path}?source=redactor&type=file&#{params}"
    fileManagerJson:  "#{CMS.file_upload_path}?source=redactor&type=file"
    definedLinks:     "#{CMS.pages_path}?source=redactor"
    buttonSource:     true
    formatting:       ['p', 'h1', 'h2', 'h3', 'h4', 'h5', 'h6']
    plugins:          ['imagemanager', 'filemanager', 'table', 'video', 'definedlinks']
    lang:             CMS.locale
    convertDivs:      false
  )
)
