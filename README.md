# Biodiversity Indicators Partnership (BIP)

This repository contains the source code of the BIP website.

## Installation

BIP is a Rails 4 app, using a Postgres database, mostly built using the Comfy CMS framework.
Needless to say, make sure to have Ruby and Node.js installed. From there, it's
all pretty standard:

```
git clone https://github.com/unepwcmc/bip
cd bip
rvm use 2.3.1 [or rvm install '2.3.1']
bundle install
npm install
bundle exec rake db:create db:migrate db:seed
bundle exec rails server
```

You will need a `.env` file which you can steal from another developer or copy from the provided `.env.example`

Visit `http://localhost:3000` and you should be good to go! 🎉

# License

This repository lives under the [MIT license.](LICENSE)
