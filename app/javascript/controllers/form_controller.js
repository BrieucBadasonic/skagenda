import { Controller } from "stimulus"
import Rails from '@rails/ujs';

export default class extends Controller {
  static targets = [ "date", "price", "eventurl",
                     "venueName", "venueAddress", "bandName"]

  concert(event) {
    event.preventDefault();
    // update event variable
    const editDate = this.dateTarget.value;
    const editPrice = this.priceTarget.value;
    // get the url for the API call
    const url = this.eventurlTarget.action;
    const method = this.eventurlTarget.dataset.method
    // extract the domain name
    const regex = /.+?(?=event)/
    const domain = url.match(regex)[0]

    // update venue variable
    const venueName = this.venueNameTarget.value;
    const venueAddress = this.venueAddressTarget;
    const venueId = this.venueAddressTarget.parentNode.nextElementSibling.value

    // update band name
    const bandNames = [];
    this.bandNameTargets.forEach((band) => {
      bandNames.push(band.value)
    })
    // build data string for band API call
    let bandData = ""
    bandNames.forEach((band, index) => {
      bandData += `bandNames[]=${band}&`
    })
    bandData = bandData.slice(0, -1)

    //  update venue API call
    const updateVenue = (domain, eventId, venueName, venueAddress) => {
      Rails.ajax({
        url: `${domain}events/${eventId}/venues`,
        headers : { accepts: "application/json" },
        type: "POST",
        data: `venue[name]=${venueName}&venue[address]=${venueAddress.value}`,
        success: (data) => {
          if (data.html) {
            venueAddress.value = data.venue.address
          }
        },
        error: function(data) {}
      })
    }

    // // update band API call
    const updateBand = (domain, eventId, bandData) => {
      Rails.ajax({
        url: `${domain}events/${eventId}/bands`,
        headers : { accepts: "application/json" },
        type: "POST",
        data: `${bandData}`,
        succes: (data) => {},
        error: function(data) {}
      })
    }

    // update event API call
    Rails.ajax({
      url: url,
      headers : { accepts: "application/json" },
      type: `${method}`,
      data: `event[date]=${editDate}&event[price]=${editPrice}`,
      success: (data) => {
        const eventId = data.event
        updateVenue(domain, eventId, venueName, venueAddress);
        updateBand(domain, eventId, bandData);

      },
      error: function(data) {}
    })
  }
}

