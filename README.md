# Sekret


### Getting Setup

There are a few config options.

```ruby
Sekret.configure do |config|
  config.mac_secret = 'Super Sekret'
  config.public_key = File.read('path to public pem')
  config.private_key = File.read('path to private pem')
end
```

### Encrypt Data

```ruby
Sekret.encrypt('This is my secret message')

# => 'abc.123'
```

### Decrypt Data

```ruby
Sekret.decrypt('abc.123')

# => 'This is my secret message'
```
