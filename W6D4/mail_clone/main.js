let Router = require('./router.js');
let Inbox = require('./Inbox.js');

document.addEventListener("DOMContentLoaded", () => {
  const domNode = document.querySelector(".content");
  let router = new Router(domNode);

  const listSubmitButton = document.querySelector(".sidebar-nav li");

  listSubmitButton.addEventListener("click", (e) => {
    let text = e.currentTarget.innerText.toLowerCase();
    location.hash = text;
  });

});
