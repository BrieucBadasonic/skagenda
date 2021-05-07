const addBand = () => {
  const createButton = document.getElementById("addBand");
  createButton.addEventListener("click", () => {
    const lastId = document.querySelector("#fieldsetContainer").lastElementChild.id;
    const newId = parseInt(lastId, 10) + 1;
    const newFieldset = document.querySelector('[id="0"]').outerHTML.replace(/0/g,newId);
console.log(newFieldset)
    document.querySelector("#fieldsetContainer").insertAdjacentHTML("beforeend", newFieldset);
  });

}

export { addBand }
