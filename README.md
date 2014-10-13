# CalMail

## Your day's meetings summarized nightly

This is a product being built by the Assembly community. You can help push this idea forward by visiting [https://assemblymade.com/calmail](https://assemblymade.com/calmail).


###App setup
- Install the required gems
<br>`bundle install`
- Set up the database
<br>`rake db:setup`
- Run the app
<br>`bundle exec rails s`

For Oauth to work, you need to obtain an [API key from Google](https://developers.google.com/api-client-library/python/guide/aaa_apikeys)

The Oauth keys are set in the following environment variables:
- ENV['GOOGLE_CLIENT_ID']
- ENV['GOOGLE_CLIENT_SECRET']


### How Assembly Works

Assembly products are like open-source and made with contributions from the community. Assembly handles the boring stuff like hosting, support, financing, legal, etc. Once the product launches we collect the revenue and split the profits amongst the contributors.

Visit [https://assemblymade.com](https://assemblymade.com) to learn more.
