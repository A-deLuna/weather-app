function initMap() {
  const input = document.getElementById('address');
  const options = {
    fields: ['address_components', 'geometry'],
  };
  const autocomplete = new google.maps.places.Autocomplete(input, options);
  autocomplete.addListener('place_changed', function() {
    console.log('place selected');
    const place = autocomplete.getPlace();
    debugger;
    for (const component of place.address_components) {
      const type = component.types[0];
      if (type == 'postal_code') {
        console.log(component.long_name);
      }
    }
    console.log(place.geometry.location.lat())
    console.log(place.geometry.location.lng())
  });
}

window.initMap = initMap;
