function initMap() {
  const input = document.getElementById('address');
  const options = {
    fields: ['address_components', 'geometry'],
  };
  const autocomplete = new google.maps.places.Autocomplete(input, options);
  autocomplete.addListener('place_changed', function() {
    console.log('place selected');
    const place = autocomplete.getPlace();
    var postal_code = "";
    debugger;
    for (const component of place.address_components) {
      const type = component.types[0];
      if (type == 'postal_code') {
        postal_code = component.long_name;
        console.log(component.long_name);
      }
    }
    if (postal_code !== "") {
      input.form.action += "/" + postal_code
    }
    const lat = place.geometry.location.lat()
    const lng = place.geometry.location.lng()
    console.log(lat)
    console.log(lng)
    document.getElementById("lat").value = lat
    document.getElementById("lng").value = lng

    input.form.submit()

  });
}

window.initMap = initMap;
