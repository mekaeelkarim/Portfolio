window.addEventListener('load', () => {
    let long;
    let lat;
    let city;
    let temperatureDescription = document.querySelector('.temperature-description');
    let temperatureDegree = document.querySelector(".temperature-degree");
    let locationTimezone = document.querySelector('.location-timezone');
    let iconLocation = document.querySelector('.icon');
    let temperatureSection = document.querySelector('.temperature');
    let temperatureSpan = document.querySelector('.temperature span');
    let cityId;
    let siteOneName = document.querySelector('.site1-name');
    let siteTwoName = document.querySelector('.site2-name');
    let siteThreeName = document.querySelector('.site3-name');
    let siteOneDes = document.querySelector('.site1-description');
    let siteTwoDes = document.querySelector('.site2-description');
    let siteThreeDes = document.querySelector('.site3-description');
    const encodedParams = new URLSearchParams();
    const encodedParams1 = new URLSearchParams();

    


    if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(position => {
            long = position.coords.longitude;
            lat = position.coords.latitude;
            
            //This first API call will use the geo-location to extract the nearest large city from your location.
            const options1 = {
                method: 'GET',
                headers: {
                    'X-RapidAPI-Key': 'aa4724f33fmsh5287f4f5d0f92dfp172d0fjsn23aa29abf58e',
                    'X-RapidAPI-Host': 'geocodeapi.p.rapidapi.com'
                }
            };

            //Second API will allow us to extract a city ID from the largest city to be used in another API call.
            const options2 = {
                method: 'POST',
                headers: {
                    'content-type': 'application/x-www-form-urlencoded',
                    'X-RapidAPI-Key': 'aa4724f33fmsh5287f4f5d0f92dfp172d0fjsn23aa29abf58e',
                    'X-RapidAPI-Host': 'worldwide-restaurants.p.rapidapi.com'
                },
                body: encodedParams
            };

            //Third API call will allow us to access nearby restaurant information from the large city near our location.
            const options3 = {
                method: 'POST',
                headers: {
                    'content-type': 'application/x-www-form-urlencoded',
                    'X-RapidAPI-Key': 'aa4724f33fmsh5287f4f5d0f92dfp172d0fjsn23aa29abf58e',
                    'X-RapidAPI-Host': 'worldwide-restaurants.p.rapidapi.com'
                },
                body: encodedParams1
            };

            //Fourth API call will allow us to access all the necessary weather information for our current location.
            const options4 = {
                method: 'GET',
                headers: {
                    'X-RapidAPI-Key': 'aa4724f33fmsh5287f4f5d0f92dfp172d0fjsn23aa29abf58e',
                    'X-RapidAPI-Host': 'weatherbit-v1-mashape.p.rapidapi.com'
                }
            };
            
            
            fetch('https://geocodeapi.p.rapidapi.com/GetLargestCities?latitude=47.7738218&longitude=-122.0463525&range=50000', options1)
                .then(response => response.json())
                .then(response => {
                    console.log(response);
                    city = response[0].City;
                    console.log(city);
                }).then(() => {
                    encodedParams.append("q", city);
                    encodedParams.append("language", "en_US");

                    fetch('https://worldwide-restaurants.p.rapidapi.com/typeahead', options2)
                    .then(response => response.json())
                    .then(response => {
                        cityId = response.results.data[0].result_object.location_id;
                    }).then(() => {
                        console.log(cityId);
                        encodedParams1.append("language", "en_US");
                        encodedParams1.append("limit", "30");
                        encodedParams1.append("location_id", cityId);
                        encodedParams1.append("currency", "USD");
    
                        fetch('https://worldwide-restaurants.p.rapidapi.com/search', options3)
                            .then(response => response.json())
                            .then(response => {
                                console.log(response)
                                const places = response.results.data.filter(element => {
                                    return element.description;
                                });
                                siteOneName.textContent = '1: ' +places[0].name;
                                siteTwoName.textContent = '2: ' + places[1].name;
                                siteThreeName.textContent = '3: ' + places[2].name;
                                siteOneDes.textContent = places[0].description;
                                siteTwoDes.textContent = places[1].description;
                                siteThreeDes.textContent = places[2].description;
                            })
                    })
                })
                .catch(err => console.error(err));
            
            
            fetch(`https://weatherbit-v1-mashape.p.rapidapi.com/current?lon=${long}&lat=${lat}`, options4)
                .then(response => response.json())
                .then(response => {
                    const {temp, city_name} = response.data[0];
                    const weather = response.data[0].weather.description;
                    const weatherIcon = response.data[0].weather.icon;
                    //Setting DOM Elements from the API
                    temperatureDescription.textContent = weather;
                    temperatureDegree.textContent = temp;
                    locationTimezone.textContent = city_name;
                    iconLocation.src = setIcons(weatherIcon);

                    //Changing the temp for F to C
                    temperatureSection.addEventListener('click', () => {
                        if (temperatureSpan.textContent === 'F') {
                            temperatureSpan.textContent = 'C';
                            temperatureDegree.textContent = calcCel(temperatureDegree.textContent);
                        } else {
                            temperatureSpan.textContent = 'F';
                            temperatureDegree.textContent = calcFar(temperatureDegree.textContent);
                        }
                    })
                })
                .catch(err => console.error(err));
        })
    } else {
        h1.textcontent = 'Error, unable to find location';
    }

    const calcFar = CTemp => {
        return Math.round((((CTemp * 1.8) + (32)) * 10)/10);
    }
    const calcCel = FTemp => {
        return Math.round((((FTemp - 32) * (5/9)) * 10)/10);
    }
    function setIcons(icon) {
        return `./assets/icons/${icon}.png`;
    }
});