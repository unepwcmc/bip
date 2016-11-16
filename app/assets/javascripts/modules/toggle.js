export default {
  initialize: (el) => {
    let $el = $(el);

    let toggleId  = $el.data("toggle-trigger");
    let $targetEl = $(`[data-toggle-target='${toggleId}']`);
    let $targetAltEl = $(`[data-toggle-target-alt='${toggleId}']`);
    let $switchEl = $(`[data-toggle-switch='${toggleId}']`);

    $targetEl.show();
    $targetAltEl.hide();

    $el.click((ev) => {
      ev.preventDefault();
      $targetEl.toggle();

      if($targetAltEl.length > 0) {
        $targetAltEl.toggle();
      }

      if($switchEl.length > 0) {
        $switchEl.toggleClass("fa-chevron-down fa-chevron-up");
        if($el.html().indexOf("Expand") > -1) {
          $el.html($el.html().replace("Expand", "Collapse"));
          $switchEl = $(`[data-toggle-switch='${toggleId}']`);
        } else {
          $el.html($el.html().replace("Collapse", "Expand"));
          $switchEl = $(`[data-toggle-switch='${toggleId}']`);
        }
      }
    });

    if($targetEl.is("[data-toggle-hide]")) {
      $el.click();
    }
  }
};
