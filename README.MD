# URL Counter Gem
By Niall Duncan

### Usage
- If you don't have an existing `urls` table with the fields `url`, `count`, and `date` run `rake counter:init` to create one

### Installation
- `gem build url_counter_gem.gemspec`
- `gem install url_counter_gem-0.0.0.gem`
- `require('url_counter_gem')`

### Methods

#### `initialize(url, password)`
- `url`: The url to be matched against
- `password`: the password provided which will protect your HTML page list.

#### `exact(url)`
- `url`: The URL to be matched _exactly_ against the initialized URL
- Will increment `count` value for the initialized URL if provided `url` is an _exact_ match

#### `regex(expression)`
- `expression`: The regular expression to be compared against the initialized URL
- Will increment `count` value for URL provided if there is an expression match

#### `export(location)`
- `location`: A file location (.csv) in which the CSV will be written. Defaults to `data.csv` on project root.

#### `publish(location)`
- `location`: A file location (.html) in which the data will be published, using the provided `password` for protection.

### Thought and assumptions
- It was assumed that the URL would be passed in via "config" in the initialize method, I had it set up to take a regex and exact URL matcher, but upon re-reading that didn't seem right.
- I made a comment about this in the code, but obviously it's not ideal to be passing around a password in plain text. In a real life scenario the password would likely be some form of authentication.
- It would be nice to have the `initialize` method take a hash of config values so we don't really need to pass anything into the `export` and `publish` functions.
- Maybe absract any database related stuff into a `Repo` class or something, not sure if that would be _too_ granular.
- Some validation around file extensions for the `export` and `publish` methods.
- TESTS!
