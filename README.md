# Milkode on Heroku

Deploy the [Milkode](https://github.com/ongaeshi/milkode) on Heroku.

Try: http://try-milkode.herokuapp.com/

## Deploy

Clone.

```
$ git clone https://github.com/ongaeshi/milkode-on-heroku.git
$ cd milkode-on-heroku
$ heroku apps:create --buildpack https://codon-buildpacks.s3.amazonaws.com/buildpacks/groonga/rroonga.tgz
```

Edit the file `./PACKAGES`. (Specify GitHub repositories)

```
ongaeshi/milkode
ongaeshi/gomilk
.
.
```

(optional) Rename.

```
$ heroku rename try-milkode
```

Push to Heroku.

```
$ git push heroku master
$ heroku open
```

## License

The MIT License.

Copyright (c) 2014 ongaeshi





