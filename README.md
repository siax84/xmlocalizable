# Synchronize strings.xml with Localizable.strings documents

This rails app can help you if you have an existing mobile app project where the localization files
for Android (strings.xml) and iOS (Localizable.strings) have been created with different structure and
different key names. 

This app allows you to 

* Add an existing strings.xml document
* Add an existing Localizable.strings document
* Map the keys (strings) of both documents
* Modify translation if needed

## Getting Started

    bundle install
    
    rake db:setup
    
    rails s    

Open localhost:3000/synchronizations
Click on "New Synchronizations"
Add both Source and Target document
Save
You will be taken to the list page
Choose "Map"
Map the detected keys of the source document with the detected keys of the target document
Values are automatically pre-filled from the source document. Edit the value if needed
Save the mapping 

* Ruby version

Have ruby 2.7 installed

* System dependencies

* Configuration

* Database creation

rake db:setup

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
