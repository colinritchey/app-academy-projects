class Router{
  constructor(node){
    this.node = node;
    this.start();
  }

  start(){
    // this.render();
    window.addEventListener("hashchange", () => this.render() );
  }

  activeRecord(){
    return location.hash.replace(/#/, '');
  }

  render(){
    this.node.innerHTML = '';
    let name = this.activeRecord();
    let pElement = document.createElement('p');

    pElement.innerHTML = name;
    this.node.append(pElement);
  }
}

module.exports = Router;
