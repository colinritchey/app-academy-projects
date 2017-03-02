let DOMNodeCollection = require('./dom_node_collection.js');

window.$l = (args) => {
  console.log(args instanceof Object, "is an object?");
  console.log(args instanceof HTMLElement, "html el?");

  if (args instanceof HTMLElement){
    return new DOMNodeCollection(args);
  }


  console.log(args);
  let elementList = document.querySelectorAll(args);

  let arrayOfNodes = [];
  elementList.forEach((el) => arrayOfNodes.push(el));

  return arrayOfNodes;
};
