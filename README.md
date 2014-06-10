# Milkode on Heroku

Deploy the [Milkode](https://github.com/ongaeshi/milkode) on Heroku.

Try: http://try-milkode.herokuapp.com/

## Deploy

Clone.

```
$ git clone https://github.com/groonga/milkode-on-heroku.git
$ cd milkode-on-heroku
$ heroku apps:create --buildpack https://codon-buildpacks.s3.amazonaws.com/buildpacks/groonga/rroonga.tgz
```

Edit the file `./PACKAGES`.

```
https://github.com/ongaeshi/milkode.git
https://github.com/ongaeshi/gomilk.git
.
.
```

Push to Heroku.

```
$ git push heroku master
$ heroku apps:open
```

## Deploy to local

```
$ git clone https://github.com/groonga/milkode-on-heroku.git
$ cd milkode-on-heroku
$ bundle install
# Init database & Add packages
$ bundle exec rackup config.ru
```

## License

The MIT License.

Copyright (c) 2014 ongaeshi





