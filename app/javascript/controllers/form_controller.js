import { Controller } from "stimulus"
import Rails from '@rails/ujs';

export default class extends Controller {
  static targets = [ "date", "price", "eventurl", "eventFlash",
                     "venueName", "venueAddress", "bandName"]

  concert(event) {
    event.preventDefault();
    // update event variable
    const editDate = this.dateTarget.value;
    const editPrice = this.priceTarget.value;

    // get the url for the API call
    const url = this.eventurlTarget.action;
    // extract the domain name
    const regex = /.+?(?=event)/
    const domain = url.match(regex)[0]

    // get the div do inject the return from event update event API call
    const eventFlash = this.eventFlashTarget;

    // update venue variable
    const venueName = this.venueNameTarget.value;
    const venueAddress = this.venueAddressTarget;
    const venueId = this.venueAddressTarget.parentNode.nextElementSibling.value

    // update band name
    const bandNames = [];
    this.bandNameTargets.forEach((band) => {
      bandNames.push(band.attributes.value.value)
    })

    eventFlash.innerHTML = ""

    // update event API call
    Rails.ajax({
      url: url,
      headers : { accepts: "application/json" },
      type: "PATCH",
      data: `event[date]=${editDate}&event[price]=${editPrice}`,
      success: (data) => {
        if (data.html) {
          console.log(data.html)
          eventFlash.insertAdjacentHTML("beforeend", data.html)
        }
      },
      error: function(data) {}
    })

    //  update venue API call
    Rails.ajax({
      url: `${url}/venues`,
      headers : { accepts: "application/json" },
      type: "POST",
      data: `venue[name]=${venueName}&venue[address]=${venueAddress.value}`,
      success: (data) => {
        if (data.html) {
          venueAddress.value = data.venue.address
          eventFlash.insertAdjacentHTML("beforeend", data.html);
        }
      },
      error: function(data) {}
    })
  }
}

