const editBand = () => {
//   const createButton = document.getElementById("addBand");

//   createButton.addEventListener("click", () => {
//     // get the id of the last band input field
//     const lastId = document.querySelector("#fieldsetEditContainer").lastElementChild.lastElementChild.id;

//     // convert last ID to int and add + 1
//     const newId = (parseInt(lastId, 10) + 1).toString();

//     // clone band form input div
//     const newInputField = document.getElementById(lastId).cloneNode(true)
//     // replace the id with the new id
//     newInputField.setAttribute("id", newId);

//     // reset the value attribut to an empty string
//     newInputField.setAttribute('value', "")

//     // query all the element with the class string
//     const nodeLabel = document.querySelectorAll('.string');

//     // get the last label element (it will always be the -2 of the nodelist)
//     const lastLabel = nodeLabel[nodeLabel.length - 2].cloneNode(true);
//     // changge the FOR attribut value with the new id
//     lastLabel.setAttribute('for', `${newId}`);

//     // creating a new div form container
//     const formContainer = document.createElement('div')
//     formContainer.classList.add("form-group", "string", "optional", "event_band_name", "form-group-valid")

//     // injecting new label and new input field inside the empty form container
//     formContainer.appendChild( lastLabel )
//     formContainer.appendChild(newInputField);

//     // catch the fielsetEditContainer
//     const bandContainer = document.querySelector("#fieldsetEditContainer");

//     // inject the new form container inside the bandcontainer
//     bandContainer.appendChild(formContainer)
//   });

}

export { editBand }

// var nodes = div.querySelectorAll('[move_id]');
// var first = nodes[0];
// var last = nodes[nodes.length- 1];
