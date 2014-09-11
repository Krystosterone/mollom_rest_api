[![Build Status](https://travis-ci.org/Krystosterone/mollom_rest_api.svg?branch=master)](https://travis-ci.org/Krystosterone/mollom_rest_api)
[![Coverage Status](https://coveralls.io/repos/Krystosterone/mollom_rest_api/badge.png?branch=master)](https://coveralls.io/r/Krystosterone/mollom_rest_api?branch=master)

# Mollom Rest API

mollom_rest_api is a ruby wrapper, using oauth authentication, for the [Mollom](https://mollom.com) Rest API.

## Installation

Add to your Gemfile:

    gem 'mollom_rest_api'

or install from Rubygems:

    gem install mollom_rest_api

## Usage

Before using the gem, you must first configure it as such:

```ruby
MollomRestApi.url = 'http://rest.mollom.com' # Do not include the API version number
MollomRestApi.public_key = 'my_public_key'
MollomRestApi.private_key = 'my_private_key'
MollomRestApi.oauth_options = {proxy: 'http://proxy.com:8888'} # some additional oauth options
```

You can get your public key and private key using Mollom's [site manager](https://mollom.com/user/130051/site-manager), after signing in.

### Calling endpoints
The gem implementation replicates the [Mollom's API Documentation](https://mollom.com/api) as much as possible.

#### Example of API call

Here is an example of how to verify a captcha using the gem.

As per Mollom's Documentation on [verifying a captcha](https://mollom.com/api#captcha):

```
Syntax: POST http://rest.mollom.com/v1/captcha
```

- Path parameters
  - **captchaId: The ID of the CAPTCHA resource.**
- Request parameters
  - **solution:**
    - **The answer provided by the author.**
  - authorName: (optional)
    - The name of the content author.
  - authorUrl: (optional)
    - The homepage/website URL of the content author.
  - authorMail: (optional)
    - The e-mail address of the content author.
  - authorIp: (optional)
    - The IP address of the content author.
  - authorId: (optional)
    - The local user ID of the content author on the client site.
  - authorOpenid: (multiple, optional)
    - One or more Open IDs of the content author.
  - rateLimit: (optional, default = 15)
     - Seconds that must have passed by for the same author to post again.
  - honeypot: (optional)
     - Client-side honeypot value, if non-empty.

As such, `captchaId` and `solution` must both be specified for the endpoint call to succeed. All other parameters are optional, and can be passed to the call using a hash.

Using the gem, we call this endpoint using:

```ruby
MollomRestApi::V1::Captcha.verify("captchaId", "solution", {authorName: "Bob", ...})
```

or using the alternative syntax:

```ruby
MollomRestApi::V1::verify_captcha("captchaId", "solution", {authorName: "Bob", ...})
```

### Running Tests

`bundle exec rspec spec` - Running specs (all web interactions are mocked with VCR cassettes)

### Contributors
+ [royjs](https://github.com/royjs)
+ [krystosterone](https://github.com/krystosterone)