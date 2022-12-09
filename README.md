# Biodiversity Indicators Partnership (BIP)

This repository contains the source code of the BIP website.

## Installation

BIP is a Rails 4 app, using a Postgres database, mostly built using the Comfy CMS framework.
Needless to say, make sure to have Ruby and Node.js installed. From there, it's
all pretty standard:

```
git clone https://github.com/unepwcmc/bip
cd bip
rvm use 2.3.1 [or rbenv local 2.3.1]
```

You will need to use a specific version of bundler for the project to install properly:
```
gem install bundler -v 1.16.2
bundle _1.16.2_ install
```

Install the NPM packages:
```
npm install
```

Next, create a db and import the latest dump from staging/production on S3 (extract file until you get a .sql file):
```
bundle exec rake db:create
psql bip_development < PostgreSQL.sql
```

Finally, run the server:
```
bundle exec rails server
```

You will need a `.env` file which you can steal from another developer or copy from the provided `.env.example`

Visit `http://localhost:3000` and you should be good to go! 🎉

# License

This repository lives under the [MIT license.](LICENSE)

# Data updates

## Update CMS resource tags, tabs and download labels (23-11-22)
Run the following tasks to update the CMS resource tags, tab name and the labels for resource downloads/links. 

```
rake cms_resource_labels:update
rake resource_tabs_and_tags:update
```

Note, both namespaces have `revert` tasks that will largely revert the changes. In the case of deleted tags, this is not possible.
