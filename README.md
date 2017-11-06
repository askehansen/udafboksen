# README

ud-af-boksen works by syncing e-Boks messages and delivers them as attachment to the user by email.

## Deploying to Heroku

[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy?template=https://github.com/askehansen/udafboksen)

1. Deploy the app using the Heroku button.

2. Once the app is running you will need to set up two scheduled task:
   * `rake messages:sync` will sync new messages.
   * `rake messages:deliver` will deliver new messages by email and mark the message as delivered.

3. Open Heroku Scheduler add add these tasks to run every hour: `bundle exec rake messages:sync ; bundle exec rake messages:deliver`
