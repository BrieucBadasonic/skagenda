import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "date", "price", "eventurl"]

  concert(event) {
    const editDate = this.dateTarget.value;
    const editPrice = this.priceTarget.value;
    const url = this.eventurlTarget.action
    const token = document.querySelector(".edit_event").firstChild.nextSibling.value
    console.log(token)
    event.preventDefault();

    fetch(url, { headers: { accepts: "application/json",
                            "X-CSRF-Token": token },
                 method: 'PATCH',
                 body: JSON.stringify({ date: editDate,
                                        price: editPrice
                                     })
               })
      .then(response => response)
      .then((data) => {
        console.log(data)
      })


  }
}

// edit_event_path(@event)
