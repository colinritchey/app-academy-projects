/******/ (function(modules) { // webpackBootstrap
/******/ 	// The module cache
/******/ 	var installedModules = {};

/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {

/******/ 		// Check if module is in cache
/******/ 		if(installedModules[moduleId])
/******/ 			return installedModules[moduleId].exports;

/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = installedModules[moduleId] = {
/******/ 			i: moduleId,
/******/ 			l: false,
/******/ 			exports: {}
/******/ 		};

/******/ 		// Execute the module function
/******/ 		modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);

/******/ 		// Flag the module as loaded
/******/ 		module.l = true;

/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}


/******/ 	// expose the modules object (__webpack_modules__)
/******/ 	__webpack_require__.m = modules;

/******/ 	// expose the module cache
/******/ 	__webpack_require__.c = installedModules;

/******/ 	// identity function for calling harmony imports with the correct context
/******/ 	__webpack_require__.i = function(value) { return value; };

/******/ 	// define getter function for harmony exports
/******/ 	__webpack_require__.d = function(exports, name, getter) {
/******/ 		if(!__webpack_require__.o(exports, name)) {
/******/ 			Object.defineProperty(exports, name, {
/******/ 				configurable: false,
/******/ 				enumerable: true,
/******/ 				get: getter
/******/ 			});
/******/ 		}
/******/ 	};

/******/ 	// getDefaultExport function for compatibility with non-harmony modules
/******/ 	__webpack_require__.n = function(module) {
/******/ 		var getter = module && module.__esModule ?
/******/ 			function getDefault() { return module['default']; } :
/******/ 			function getModuleExports() { return module; };
/******/ 		__webpack_require__.d(getter, 'a', getter);
/******/ 		return getter;
/******/ 	};

/******/ 	// Object.prototype.hasOwnProperty.call
/******/ 	__webpack_require__.o = function(object, property) { return Object.prototype.hasOwnProperty.call(object, property); };

/******/ 	// __webpack_public_path__
/******/ 	__webpack_require__.p = "";

/******/ 	// Load entry module and return exports
/******/ 	return __webpack_require__(__webpack_require__.s = 0);
/******/ })
/************************************************************************/
/******/ ([
/* 0 */
/***/ (function(module, exports, __webpack_require__) {

let DOMNodeCollection = __webpack_require__(1);

window.$l = function(args){

  if (args instanceof HTMLElement){
    return new DOMNodeCollection(args);
  }

  let arrayOfNodes = [];
  let elementList = document.querySelectorAll(args);

  elementList.forEach((el) => arrayOfNodes.push(el));
  return new DOMNodeCollection(arrayOfNodes);
};


/***/ }),
/* 1 */
/***/ (function(module, exports) {

class DOMNodeCollection{
  constructor(htmlEls){
    this.htmlEls = htmlEls;
  }

  html(string){
    if(string instanceof String){
      this.htmlEls.forEach(function(el){
        el.innerHTML = string;
      });
    } else {
      return this.htmlEls[0].innerHTML;
    }
  }

  empty(){
    this.html('');
  }

  append(arg){
    if(arg instanceof Object){
      console.log("hi");

      this.htmlEls.forEach(function(el){
        el.innerHTML += arg.outerHTML;
      });
    }else{
      this.htmlEls.forEach(function(el){
        el.innerHTML += arg;
      });
    }
  }

  children(){
    let childrenList = [];

    this.htmlEls.forEach(function(el){
      childrenList.push(el.children);
    });

    return new DOMNodeCollection(childrenList);
  }

  parent(){
    let parentList = [];

    this.htmlEls.forEach(function(el){
      let parent = el[0].parentElement;
      if(!parentList.includes(parent)){
        parentList.push(parent);
      }
    });

    return new DOMNodeCollection(parentList);
  }

  find(arg){
    let foundElements = this.htmlEls[0].querySelectorAll(arg);
    return new DOMNodeCollection(foundElements);
  }

  //Not Working
  remove(){
    console.log(this.parent().htmlEls[0], "within remove function");
    this.htmlEls.forEach(el => el.parent().htmlEls[0].removeChild(el));
  }
}

module.exports = DOMNodeCollection;


/***/ })
/******/ ]);