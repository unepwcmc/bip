// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require_self

window.$ = window.jQuery = global.$ = require("jquery");
import "babel-polyfill";
import _ from "underscore";
import toggle from "modules/toggle";
import pagination from "modules/pagination";
import selectGroup from "modules/select_group";

$(document).ready(() => {
  $("[data-toggle-trigger]").each((_i, el) => toggle.initialize(el));
  _.chain($("[data-select-group]"))
    .map(el => $(el).data("select-group"))
    .uniq()
    .map(group => new selectGroup(group))
    .each(group => group.openFirst());

  pagination.perPageSelector($("[data-per-page-selector]"));
});
