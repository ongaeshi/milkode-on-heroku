# Milkode on Heroku

Deploy the [Milkode](https://github.com/ongaeshi/milkode) on Heroku.

Try: http://try-milkode.herokuapp.com/

## Setup

Clone.

```
$ git clone https://github.com/ongaeshi/milkode-on-heroku.git
$ cd milkode-on-heroku
$ heroku apps:create --buildpack https://codon-buildpacks.s3.amazonaws.com/buildpacks/groonga/rroonga.tgz
```

(optional) Rename.

```
$ heroku rename try-milkode
```

## Specifies the packages that you want to add

Edit the file `./PACKAGES`. Specify the GitHub repository name.

- `-n (--name)` .. Specify pacakge name
- `-b (--branch-name)` .. Specify branch

```
ongaeshi/milkode
ongaeshi/gomilk  -n gooooomilk
ongaeshi/milkode -n milkode-develop -b develop
.
.
```

## Customize title and icon

Edit the file `./milkweb.yaml`

```
---
:home_title  : "Milkode on Heroku"
:home_icon   : "http://...../icon.png"

:header_title: "Milkode"
:header_icon : "/images/MilkodeIcon135.png"

:display_about_milkode: true
```

## Deploy

Push to Heroku.

```
$ git commit -am "Add my settings"
$ git push heroku master
$ heroku open
```

## License

The MIT License.

Copyright (c) 2014 ongaeshi





