## Install

### Clone the repository

```shell
git clone git@github.com:sarslanoglu/sarslan-bitmap.git
cd project
```

### Check your Ruby version

```shell
ruby -v
```

The ouput should start with something like `ruby 2.7.0`

If not, install the right ruby version using [rvm](https://github.com/rvm/rvm) (it could take a while):

```shell
rvm install 2.7.0
```

### Install dependencies

Using [Bundler](https://github.com/bundler/bundler):

```shell
bundle install
```

## To run script

```shell
ruby execute.rb
```

## Testing

For rubocop to run

```shell
rubocop
```

For rspec to run

```shell
Rake
```

After running rspec coverage file will be created locally. To open coverage file just type

```shell
open coverage/index.html
```

to the terminal and hit enter. New browser tab will be open.
