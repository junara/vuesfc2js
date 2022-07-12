[![codecov](https://codecov.io/gh/junara/vuesfc2js/branch/main/graph/badge.svg?token=z7VVljt2RR)](https://codecov.io/gh/junara/vuesfc2js)

# Vuesfc2js

Gem for converting `.vue` file into `.js` file for analyze dependency analysis.

I tried following dependency analysis tools thant is converted by `vuesfc2js`:

* [pahen/madge: Create graphs from your CommonJS, AMD or ES6 module dependencies](https://github.com/pahen/madge)
* [Himenon/code-dependency: A work efficiency tool for visualizing code dependencies on a browser.](https://github.com/Himenon/code-dependency)



## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add vuesfc2js

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install vuesfc2js

## Usage

Many dependency analysis application assume import and export statement in JavaScript file.

In `.vue` file JavaScript is included by `<script>` tag and these applications are not aware of this.

Idea is very simple. Just extract script container and replace `.vue` file into `.js` file.

See following example:

Before conversion.

`TestComponent.vue`

```vue
<template>
  
</template>
<script>
import Vue from 'vue';
import HogeComponent from './HogeComponent.vue';
</script>
<style>
</style>
```

After conversion.

`TestComponent.js`

```javascript
import Vue from 'vue';
import HogeComponent from './HogeComponent.js';
```

And using alias case

Before conversion

```javascript
{
    @: "/path/to/vue/project/packs"
}
```

```vue
<template>
  
</template>
<script>
import FugaComponent from '@/../component/FugaComponent.vue';
</script>
<style>
</style>
```


After conversion

```javascript
import FugaComponent from '/path/to/vue/project/packs/../component/FugaComponent.js';
```

And `.vue` and alias (like '@') in .js is also converted.

### Convert Vue project directory

Your project directory is absolute path `'/path/to/vue/project'`,  

Prepare the destination directory absolute path `'/path/to'` to save converted files.

Optionally, you can specify alias absolute path by like `{ "@" => '/path/to/vue/project/packs' }`.

First: install this gem.

```shell
gem install vuesfc2js
```

Second: start irb to execute ruby script interactively.

```shell
irb
```

Finally: just type two line of ruby script.

```ruby
require 'vuesfc2js'
Vuesfc2js.convert_vue_project('/path/to/vue/project', '/path/to/dst', src_path_alias: { "@" => '/path/to/vue/project/packs' })
```

You got `.js` files in '/path/to/dst/project'.

## Usage example

Assuming your project is converted into `/path/to/dst/project`, like following:

* [pahen/madge: Create graphs from your CommonJS, AMD or ES6 module dependencies](https://github.com/pahen/madge)

```shell
madge /path/to/dst/project
```

* [Himenon/code-dependency: A work efficiency tool for visualizing code dependencies on a browser.](https://github.com/Himenon/code-dependency)

```shell
code-dependency --source /path/to/dst/project
```



## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/junara/vuesfc2js. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/vuesfc2js/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Vuesfc2js project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/vuesfc2js/blob/main/CODE_OF_CONDUCT.md).
