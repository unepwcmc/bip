export default class Select {
  constructor (group, selectName) {
    this.group = group;
    this.name  = selectName;
    this.$trigger = $(`[data-select-group='${group.name}'][data-select-trigger='${selectName}']`);
    this.$target = $(`[data-select-group='${group.name}'][data-select-target='${selectName}']`);

    let parentName = this.$trigger.data("select-parent");

    if(parentName) {
      this.$parent = $(`[data-select-group='${group.name}'][data-select-trigger='${parentName}']`);
    }

    this.$trigger.click(_ev => {
      this.open();
    });
  }

  open () {
    this.opened = true;
    this.group.closeAll(this.name);
    this.$trigger.addClass("is-selected");
    if(this.$parent) {
      this.$parent.addClass("is-selected");
    }
    this.$target.show();
  }

  close () {
    console.log(`closing ${this.name}`);
    this.$trigger.removeClass("is-selected");
    this.$target.hide();
    this.opened = false;
  }
}
