# Moncash_ruby

![alt text](./logo.png "Logo")

This is a simple Ruby wrapper for MonCash API. This Gem Allow you to implement the MonCash payment processing on your Ruby or Ruby on rails project. This gem is the simplest way you can use the MonCash API for now. 

``Be careful, this Gem is not Developed by the Official developer of MonCash``. Certil Remy Build this gem for his own project and decided to share it with the Ruby developers. If you want to report Issues about this gem you should do it here by opening a new issue,  not on MonCash website. We will be glad to assist you if you're not a developer but not free :slightly_smiling_face: .


## Feature Available
- Create token
- Create payment
- Get single transaction by id (Bug reported about it , working to fix it)


## Install the gem on your project
Add this to your GemFile

```
gem 'moncash_ruby' 
```

then run 

```
bundle install
```

## Making your first payment
What you really need to make your first payment?

[Click here to go to the moncash website](https://sandbox.moncashbutton.digicelgroup.com/Moncash-business/Login)   
Create your free business account. If you stuck please take a look at this doc https://sandbox.moncashbutton.digicelgroup.com/Moncash-business/resources/doc/MC-Business.pdf 

Now you get your ``'client_id'``  and your ``'secret_id'``. Please the document below should help you on how to generate them do not ignore it, They are very important for our next step. You don't need to care about token expiration, Generate token, API endpoint, and token serialization. We handle them for you. Just complete the form and grab your ``'client_id'`` and ``'secret_id'``.

Enough make your first payment with 3 lines of code.

```
require 'moncash_ruby'
moncash = Moncash::Hit.new(your_client_id, your_secret_id)
moncah.create_payment(amount, oder_id)

```
Yep that's it
Let me explain. In the first line we require ``moncash_ruby``(the gem). In the second line I initialize moncash Module which require your ``client_id ``and your ``secret_id``. you must pass these argument as a string like

```
moncash = Moncash::Hit.new('12gs45', 'dggywywgdg')
```

And finally, in the third line you just create a new payment, you hit the MonCash API to create the payment.
The ``create_payment`` method requires two arguments, they are all ``integer`` the amount of money and the order Id.

## More about Create payment method

Earlier I told you this method requires two arguments, yes but there's another one his value is 'sandbox' by default. In this demo, you just hit the MonCash ``sandbox``. When your project is live you must pass the ``'live'`` argument in the create method.

```
require 'moncash_ruby'
moncash = Moncash::Hit.new(your_client_id, your_secret_id)
moncah.create_payment(amount, oder_id, 'live')
```
The ``sandbox`` is for testing Moncash in your project for development purpose only, remember when your project is live use the live argument.

## Contrubution
If you want to contribute to this project your welcome fork this project and clone it.
Then run 

```
 bundle 
```
To start working you need to create a new branch from the dev branch. when your feature is available open your pull request compared to the dev branch again. 

We have GitHub action already install, If your test pass we will merge your pull request. If it isn't please fix them and submit it again.

## Authors

Certil Remy Twitter @certilremy, Email: help@certilremy.com
