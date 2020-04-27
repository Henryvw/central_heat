# Central Heat Rails API
The application to fetch statistical reports on heating data, (and also accept new heating data) for thermostats across multiple households.

![ReadMe Screenshot](https://github.com/Henryvw/central_heat/blob/master/app/assets/images/thermo_stats_screenshot.png)

### Introduction
This application has 3 endpoints:
* GET an individual reading on a particular given thermostat: temperature, humidity and battery charge
* GET statistics across all readings for the above attributes for a given timeframe, including min, max and averages
* POST a new reading for a given thermostat

### Setup
1. Download the app from this repo
2. Seed the database with my custom rake task: `rails db:seed:therms_and_readings`
3. Start Redis: `redis-server`
4. Start Sidekiq: `sidekiq -c 1`
5. Start Rails server: `rails s`

### Playing with the Application
* Use CURL or a GUI service like Postman to communicate with the endpoints
* Find the auto-generated authentication token using `rails console` for the thermostat that you're interested in. Pass it in as a Bearer token in your Header: `--header 'Authorization: Bearer $my_thermostats_auth_token'`
* Call the endpoint you're interested in exploring:
* GET a reading: `http://localhost:3000/api/v1/readings/16`
![ReadMe Screenshot](https://github.com/Henryvw/central_heat/blob/master/app/assets/images/reading_screenshot.png)
* GET statistics for a given thermostat over time: `http://localhost:3000/api/v1/thermostats/1?start=26-04-2020&end=29-04-2020` 
![ReadMe Screenshot](https://github.com/Henryvw/central_heat/blob/master/app/assets/images/thermo_stats_screenshot.png)
* POST a new reading: `http://localhost:3000/api/v1/readings/?thermostat_id=1&humidity=100&battery_charge=100&temperature=100
![ReadMe Screenshot](https://github.com/Henryvw/central_heat/blob/master/app/assets/images/post_reading_screenshot.png)
