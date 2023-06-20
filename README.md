# PetMate

PetMate is a web application that allows users to reserve a pet from private owners. Users can browse through different types of pets, such as dogs, cats, birds, etc., and see their details, such as name, age, breed, and location. Users can also contact the owners and request to reserve a pet for a specific date and time. Owners can accept or decline the requests and manage their reservations.

## How to use it

To use PetMate, you need to have Ruby on Rails installed on your machine. You can follow the instructions here: https://guides.rubyonrails.org/getting_started.html

You also need to have a Heroku account and the Heroku CLI installed. You can follow the instructions here: https://devcenter.heroku.com/articles/heroku-cli

To run PetMate locally, follow these steps:

- Clone this repository to your local machine: `git clone git@github.com:AlirezaHabibi2010/rails-petmate.git`
- Change to the project directory: `cd rails-petmate`
- Install the dependencies:
```sh
bundle install
rails active_storage:install

```  
- Create the database: `rails db:create`
- Run the migrations: `rails db:migrate`
- Seed the database with some sample data: `rails db:seed`
- Start the server: `rails server`
- Open your browser and go to http://localhost:3000

To deploy PetMate to Heroku, follow these steps:

- Log in to your Heroku account: `heroku login`
- Create a new app on Heroku: `heroku create`
- Push your code to Heroku: `git push heroku master`
- Install dependencies:
  ```sh
    heroku run rails active_storage:install
    heroku addons:create rediscloud:30
  ```
- Run the migrations on Heroku: `heroku run rails db:migrate`
- Open your app on Heroku: `heroku open`

## Usage

Once the Pet Reservation Marketplace is deployed, users can perform the following actions:

- **Sign Up**: Create a new account to access the marketplace.
- **Browse Pets**: Explore the available pets for reservation.
- **Reserve Pets**: Reserve a pet by selecting the desired dates and completing the reservation process.
- **Manage Reservations**: As a pet owner, manage and confirm incoming reservation requests.
- **Leave Reviews**: Share your experiences by leaving reviews for reserved pets.

## Benefits

The Pet Reservation Marketplace offers several benefits to users:

- **Convenience**: Users can easily find and reserve pets, streamlining the process of pet adoption.
- **Variety of Pets**: The marketplace provides a wide range of pet options from different private owners.
- **Trust and Transparency**: The platform promotes trust and transparency through user reviews and verified pet listings.
- **Personalized Experience**: Users can connect directly with pet owners and discuss specific requirements or preferences.
- **Pet Care Information**: The marketplace can also provide information on pet care and related services.

By utilizing the Pet Reservation Marketplace, users can enjoy a seamless pet adoption experience, find their perfect companion, and contribute to providing loving homes for pets in need.

## Contributing

If you would like to contribute to the Pet Reservation Marketplace, feel free to submit pull requests or raise issues in the repository. Your contributions are welcome and will help improve the platform for everyone.


## How can anyone benefit from this code

Anyone who wants to learn how to build a web application using Ruby on Rails can benefit from this code. This code demonstrates how to use various features and concepts of Rails, such as:

- Models, views, controllers, and routes
- Active Record associations and validations
- Forms and form helpers
- Partials and layouts
- Authentication and authorization
- Flash messages and redirects
- Image uploading and processing
- Pagination and search
- User registration and profile editing
- User ratings and reviews
- Pet categories and filters

Anyone who wants to improve or extend this code can also benefit from it. Some possible features that can be added are:

- Google Maps integration for pet locations
- Payment integration for pet reservations
- Notifications and reminders for owners and users
- Action Mailer and email templates
- Testing with RSpec and Capybara
  
