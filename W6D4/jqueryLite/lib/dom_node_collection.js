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
