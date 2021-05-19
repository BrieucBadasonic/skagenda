import { Controller } from "stimulus"
import Rails from '@rails/ujs';

export default class extends Controller {
  static targets = [ "date", "price", "eventurl"]

  concert(event) {
    const editDate = this.dateTarget.value;
    const editPrice = this.priceTarget.value;
    const url = this.eventurlTarget.action
    const token = this.element.firstChild.nextSibling.value

    event.preventDefault();

    Rails.ajax({
      url: url,
      headers : { accepts: "application/json" },
      type: "PATCH",
      data: `event[date]=${editDate}&event[price]=${editPrice}`,
      success: (data) => {
        console.log(data)
      },
      error: function(data) {}
    })

  }
}

