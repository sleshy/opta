# opta
A simple ruby script for CAPSL OPTA exports.

Getting this setup is pretty straightforward, just requires using terminal to make it happen. This going to assume you are using a Mac. If you are using Windows, too bad. If you are on Linux, you probably don't need me explaining this.

CONFIGURE GITHUB AND CLONE
--
First you need to sign up for github. https://github.com. Follow the directions to set up git as seen herehttps://help.github.com/articles/set-up-git/.  Now you need to clone the repo. You may be looking at this on the GitHub site. If so, open up Terminal. Type (or copy paste):

git clone https://github.com/dsaint-pierre-sonian/opta

There is now a folder named opta. Type:

cd opta

You're now in the opta folder.

INSTALL HOMEBREW
--

Homebrew is awesome and easy to setup. In terminal run the following:

ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

Let the script run. Once it is finished type:

brew update

The repository will update.

INSTALL PHANTOMJS
--
Still in Terminal (getting used to it?) type:

brew install phantomjs

Let it do its thing. If there is an error message try:

sudo brew install phantomjs

INSTALL BUNDLER AND BUNDLE INSTALL
--
Alright, we're nearly there. Type:

sudo gem install bundler

Things will fly across the screen. Perfect. Once its done, type:

bundle install

GET YOUR OPTA
--
Run:

ruby opta_export.rb

It will export to a csv file.

For help, run `./opta_export.rb -h`.

