import flixi
import gleam/http
import gleeunit
import lustre/attribute
import lustre/element.{type Element}
import lustre/element/html
import simplifile

pub fn main() -> Nil {
  gleeunit.main()
}

pub fn readme_test() -> List(Element(a)) {
  let attributes = [
    // The URL to issue request to
    flixi.action("/content"),
    // The HTTP Method to use
    flixi.method(http.Get),
    // The event that triggers the request
    flixi.trigger("click"),
    // The element to swap
    flixi.target("#output"),
    // How to swap the element
    flixi.swap("innerHTML"),
  ]
  [
    html.button(attributes, [html.text("Get Content")]),
    html.output([attribute.id("output")], []),
  ]
}

pub fn fixi_constant_test() {
  let assert Ok(content) = simplifile.read("priv/fixi.min.js")
  assert content == flixi.javascript
}
