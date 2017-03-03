let DOMNodeCollection = require('./dom_node_collection.js');

window.$l = function(args){

  if (args instanceof HTMLElement){
    return new DOMNodeCollection(args);
  }

  let arrayOfNodes = [];
  let elementList = document.querySelectorAll(args);

  elementList.forEach((el) => arrayOfNodes.push(el));
  return new DOMNodeCollection(arrayOfNodes);
};
