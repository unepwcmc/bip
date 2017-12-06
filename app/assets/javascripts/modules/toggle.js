export default {

  initialize: (el) => {
    let $el = $(el);
    let elClosedText = $el.data("toggle-text-closed");

    let toggleId      = $el.data("toggle-trigger");
    let $altTrigger   = $(`[data-toggle-alternate-trigger='${toggleId}']`)
    let $targetEl     = $(`[data-toggle-target='${toggleId}']`);
    let $targetAltEl  = $(`[data-toggle-target-alt='${toggleId}']`);
    let $switchEl     = $(`[data-toggle-switch='${toggleId}']`);

    $targetEl.removeClass("u-hide");
    $targetAltEl.addClass("u-hide");

    function toggleTarget() {
      $targetEl.toggleClass("u-hide");
      $targetAltEl.toggleClass("u-hide");

      if($switchEl.length > 0) {
        $switchEl.toggleClass("fa-chevron-down fa-chevron-up");
      }

      if(elClosedText) {
        if($switchEl.hasClass("fa-chevron-down")) {
          $el.find("span").html(elClosedText);
        } else {
          $el.find("span").html("");
        }
      }
    }

    $el.click((ev) => {
      ev.preventDefault();
      toggleTarget();
    });

    if($targetEl.is("[data-toggle-hide]")) {
      $el.click();
    }

    $altTrigger.click((ev) => {
      toggleTarget();
    });
  }
};
