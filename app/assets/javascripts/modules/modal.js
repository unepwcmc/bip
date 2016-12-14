export default {
  initialize: (el) => {
    let $el = $(el);
    let modalId  = $el.data("modal-trigger");

    let $targetEl = $(`[data-modal-target='${modalId}']`);
    let $closeEl = $targetEl.find("[data-modal-close]");

    $el.click((ev) => {
      ev.preventDefault();
      $targetEl.show();
      $("body").css("overflow", "hidden");
    });

    $closeEl.click((ev) => {
      ev.preventDefault();
      console.log("closing");
      $targetEl.hide();
      $("body").css("overflow", "auto");
    });

    $closeEl.click();
  }
};

