import select from "modules/select";
import _ from "underscore";

export default class SelectGroup {
  constructor (group) {
    this.name = group;
    this.selects = _.chain($(`[data-select-group='${group}'][data-select-trigger]`))
      .map(el => $(el).data("select-trigger"))
      .uniq()
      .each(group => console.log(group))
      .map(group => new select(this, group))
      .value();
  }

  closeAll(except) {
    _.chain(this.selects)
      .reject((select) => select.name == except)
      .each((select) => select.close() )
      .value();
  }

  openFirst() {
    this.selects[0].open();
  }
}

