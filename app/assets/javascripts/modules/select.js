export default class Select {
  constructor (group, selectName) {
    this.group = group;
    this.name  = selectName;
    this.$trigger = $(`[data-select-trigger='${selectName}']`);
    this.$target = $(`[data-select-target='${selectName}']`);

    this.$trigger.click(_ev => {
      this.open();
    });
  }

  open () {
    this.opened = true;
    console.log(`opening ${this.name}`);
    this.group.closeAll(this.name);
    this.$trigger.addClass("is-selected");
    this.$target.show();
  }

  close () {
    console.log(`closing ${this.name}`);
    this.$trigger.removeClass("is-selected");
    this.$target.hide();
    this.opened = false;
  }
}
