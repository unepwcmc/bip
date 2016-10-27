export default module.exports = {
  initialize: (el) => {
    let $el = $(el);

    let toggleId  = $el.data("toggle-trigger");
    let $targetEl = $(`[data-toggle-target='${toggleId}']`);
    let $switchEl = $(`[data-toggle-switch='${toggleId}']`);

    if($targetEl.is("[data-toggle-hide]")) {
      $targetEl.hide();
    }

    $el.click((ev) => {
      ev.preventDefault();
      $targetEl.toggle();

      if($switchEl.length > 0) {
        $switchEl.toggleClass("fa-chevron-down fa-chevron-up");
      }
    });
  }
};
