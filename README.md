# Boat Monitor API

A webservice that allows for an HMAC-secured API used to report different system statuses and measurements from a sailboat electrical system. The API is meant to be accessed by Arduinos or similar IoT devices that can report measurements such as bilge pump status, high water alerts, battery charge status, etc.

* Ruby version 2.5.1
* Rails version 5.2.2

## Setup

**User Authentication** The application uses devise for user authentication. You should create a `/db/seeds.db` file and add a devise user to test locally on.

```
user = User.new
user.email = 'test_user@email.com'
user.password = 'my_password'
user.password_confirmation = 'my_password'
user.save!
```

Then you can `rake db:create` and `rake db:migrate` and finally `rake db:seed` to setup your test devise user. Sign_up has been disabled in devise.

**API Authentication** IoT devices can access the API using HMAC signatures. Each device that requires access to the API should be registered under `/probes/new` in order to generate a secret key that should be used (along with the probe ID) to authenticate the request being made to the API. See references below for more information.


## References
 - https://www.yelloworb.com/orbblog/how-to-create-a-reasonably-secure-arduino-client-that-post-data-into-a-rails-application-part-i/
