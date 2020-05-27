// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import "bootstrap";
import "../css/app.scss"
import socket from "./socket"
import Video from "./video"

Video.init(socket, document.getElementById("video"))

import $ from "jquery";
window.jQuery = $;
window.$ = $;

import toastr from "toastr";
toastr.options = {
  closeButton: true,
  newestOnTop: false,
  progressBar: false,
  positionClass: "toast-top-right",
  preventDuplicates: false,
  showDuration: "300",
  hideDuration: "1000",
  timeOut: "5000",
  showEasing: "swing",
  hideEasing: "linear",
  showMethod: "fadeIn",
  hideMethod: "fadeOut",
};
window.toastr = toastr;

import "phoenix_html"