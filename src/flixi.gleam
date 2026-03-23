import gleam/http
import lustre/attribute.{type Attribute, attribute}
import lustre/element.{type Element}
import lustre/element/html

/// The URL to which an HTTP request will be issued.
///
pub fn action(url: String) -> Attribute(a) {
  attribute("fx-action", url)
}

/// The HTTP Method that will be used for the request, defaults to GET.
///
pub fn method(method: http.Method) -> Attribute(a) {
  attribute("fx-method", http.method_to_string(method))
}

/// A CSS selector specifying where to place the response HTML in the DOM, e.g.
/// `#my-id`.
///
/// Defaults to the current element.
///
pub fn target(selector: String) -> Attribute(a) {
  attribute("fx-target", selector)
}

/// Create a script element the runs the fixi JavaScript.
///
pub fn script(attributes: List(Attribute(a))) -> Element(a) {
  html.script(attributes, javascript)
}

/// How the content should be swapped into the DOM, can be one of `innerHTML`,
/// `outerHTML`, `beforebegin`, `afterbegin`, `beforeend`, `afterend`, `none`, or
/// any valid property on the element (e.g. `className` or `value`).
///
/// Defaults to outerHTML.
///
pub fn swap(property: String) -> Attribute(a) {
  attribute("fx-swap", property)
}

/// Swap `innerHTML`.
///
pub fn swap_inner_html() -> Attribute(a) {
  swap("innerHTML")
}

/// Swap `outerHTML`.
///
pub fn swap_outer_html() -> Attribute(a) {
  swap("outerHTML")
}

/// Swap `beforebegin`.
///
pub fn swap_before_begin() -> Attribute(a) {
  swap("beforebegin")
}

/// Swap `afterbegin`.
///
pub fn swap_after_begin() -> Attribute(a) {
  swap("afterbegin")
}

/// Swap `beforeend`.
///
pub fn swap_before_end() -> Attribute(a) {
  swap("beforeend")
}

/// Swap `afterend`.
///
pub fn swap_after_end() -> Attribute(a) {
  swap("afterend")
}

/// Swap `none`.
///
pub fn swap_none() -> Attribute(a) {
  swap("none")
}

/// The event that will trigger a request, defaults to submit for form
/// elements, change for input-like elements & click for all other elements.
///
pub fn trigger(event: String) -> Attribute(a) {
  attribute("fx-trigger", event)
}

/// Any element with this attribute on it or on an ancestor will not be
/// processed for `fx-*` attributes.
///
pub fn ignore() -> Attribute(a) {
  attribute("fx-ignore", "")
}

/// The source code for fixi.js, minified.
///
/// You can render this in your application directly, or you can get the files
/// from this package's priv directory.
///
/// ```sh
/// $ l -1 priv/
/// fixi.js
/// fixi.min.js
/// fixi.min.js.br
/// fixi.min.js.gz
/// ```
///
pub const javascript = "(()=>{if(document.__fixi_mo)return;document.__fixi_mo=new MutationObserver(e=>e.forEach(e=>'childList'===e.type&&e.addedNodes.forEach(e=>r(e))));let e=(e,t,i,n)=>e.dispatchEvent(new CustomEvent('fx:'+t,{detail:i,cancelable:!0,bubbles:!1!==n,composed:!0})),t=(e,t,i)=>e.getAttribute(t)||i,i=e=>null!=e.closest('[fx-ignore]'),n=n=>{let r={};n.__fixi||i(n)||!e(n,'init',{options:r})||(n.__fixi=async i=>{let r=n.__fixi.requests||=new Set,o=n.form||n.closest('form'),a=new FormData(o??void 0,i.submitter);!n.name||i.submitter||o&&(n.form!==o||'submit'!==n.type)||a.append(n.name,n.value);let s=new AbortController,c={trigger:i,action:t(n,'fx-action'),method:t(n,'fx-method','GET').toUpperCase(),target:document.querySelector(t(n,'fx-target'))??n,swap:t(n,'fx-swap','outerHTML'),body:a,drop:r.size,headers:{'FX-Request':'true'},abort:s.abort.bind(s),signal:s.signal,preventTrigger:!0,transition:document.startViewTransition?.bind(document),fetch:fetch.bind(window)},f=e(n,'config',{cfg:c,requests:r});if(c.preventTrigger&&i.preventDefault(),!f||c.drop)return;if(/GET|DELETE/.test(c.method)){let e=new URLSearchParams(c.body);e.size&&(c.action+=(/\\?/.test(c.action)?'&':'?')+e),c.body=null}r.add(c);try{if(c.confirm){if(!await c.confirm())return}if(!e(n,'before',{cfg:c,requests:r}))return;if(c.response=await c.fetch(c.action,c),c.text=await c.response.text(),!e(n,'after',{cfg:c}))return}catch(t){return void e(n,'error',{cfg:c,error:t})}finally{r.delete(c),e(n,'finally',{cfg:c})}let d=()=>{if(c.swap instanceof Function)return c.swap(c);if(/(before|after)(begin|end)/.test(c.swap))c.target.insertAdjacentHTML(c.swap,c.text);else if(c.swap in c.target)c.target[c.swap]=c.text;else if('none'!==c.swap)throw c.swap};c.transition?await c.transition(d).finished:await d(),e(n,'swapped',{cfg:c}),document.contains(n)||e(document,'swapped',{cfg:c})},n.__fixi.evt=t(n,'fx-trigger',n.matches('form')?'submit':n.matches('input:not([type=button]),select,textarea')?'change':'click'),n.addEventListener(n.__fixi.evt,n.__fixi,r),e(n,'inited',{},!1))},r=e=>{if(e.matches){if(i(e))return;e.matches('[fx-action]')&&n(e)}e.querySelectorAll&&e.querySelectorAll('[fx-action]').forEach(n)};document.addEventListener('fx:process',e=>r(e.target)),document.addEventListener('DOMContentLoaded',()=>{document.__fixi_mo.observe(document.documentElement,{childList:!0,subtree:!0}),r(document.body)})})();"
