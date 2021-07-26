# Zendesk Search Code Challenge

### Thanks! 🙏

I just wanted to say thanks to anyone reviewing the code. I enjoyed doing the challenge and
look forward to any feedback you have. It will be greatly appreciated and help me grow as a developer.

### Requirements
[ruby 3.0.0](https://www.ruby-lang.org/en/documentation/installation/)

`bundler`  `$ gem install bundler`

### Get started
To run this code, clone the repository to your local machine, cd into the created directory and
run `$ bundle install` to install all the required dependencies.

To start the program run `$ rake`

To run the tests run `$ rspec`

The command line interface was constructed to closely resemble that described in the specification.
I won't duplicate that here out of time considerations. 

It has been constructed with error handling in mind so that unusual data entry by users is (I think)
handled gracefully. If this were a *real* app it would also require some additional sanitization
to prevent malicious code injection (e.g. SQL injection) that I have not implemented at this stage.

This is the first time I had a go at developing a CLI and I think it took me a bit longer as a result.
I built it out using entirely manual testing at first which shows up in the git history as a huge,
icky 'search' method.  After some reflection (and rubocop yelling at me about lengthy, complicated
methods), I found a better way to break it up to make it more understandable, and importantly 
testable. I think the final product is pretty good, but I'm sure it could be improved. I haven't attempted
any performance testing at this stage as I'm out of time, but would be keen to hear from you if you
have ideas on how it could be optimized. Similarly, rubocop is *still* not happy with some of the code
but I just ran out of time. 

### SearchZendesk model (Command Line Interface)
The SearchZendesk model handles the CLI for the app. 

`start`

The `start` method is called by `rake` which prompts the
user to continue or enter `quit` to exit. It hands off to `select` if desired.  This method starts a continuous
loop that allows users to navigate back up to the start method to begin again. I haven't decided if that was a
good idea or not yet. 

`select`

prompts the user to continue to `Search Zendesk` or output a list of searchable fields for both `Tickets`
and `Users`.  It hands off to `search_zendesk` or returns to `start`.  

It only accepts input of (1) or (2) or it will output an error message and return the user to the `start` method.

`search_zendesk` 

prompts the user to choose whether they want to search for `Users` or `Tickets`.  It hands off to
the `search` method.

It only accepts input of (1) or (2) or it will output an error message and return the user to the `start` method.

`list_fields`

Dumps the searchable attributes of User and Ticket models to `STDOUT`. Returns user to `start`

`search(model)`

The `search` method obtains the `search_term` and `search_value` the user wishes to retrieve.  It does so by calling
getter methods (`get_search_term`, `get_search_value`) that utilize `STDIN` to get user entry, test whether the data 
entered is usable and formats it as necessary. It calls the `model.search` methods with the data and outputs any 
retrieved model data to STDOUT or lets the user know that no models were found. It then returns the user
to `start`.

`get_search_term`

This method obtains the `search_term` from `STDIN` and validates whether it exists as an attribute 
of the model being searched. If not, it will output an error to the console and return the user to `start`.  If the 
user enters a valid search term the method will reformat the data as necessary and return to `search_zendesk`

`get_search_value`

This method obtains the `search_value` from `STDIN`, reformats it if necessary, and returns to `search_zendesk` 

`output`

Used by `search_zendesk` to dump model data to `STDOUT`

`attributes`

Used by `list_fields` to dump searchable model attributes to `STDOUT`

`valid_search_term?(model, search_term)`

validates whether the `search_term` entered by the user matches one of the model's attributes.

### DataLibrary
The Data Library was designed to operate like an ORM in the style of Active Record. When the app is run,
the data can either be provided as arguments or, if none are provided, the DataLibrary will load from
the data directory. To do so, it uses the DataLoader class which uses a single argument to
determine which file to load the data from (users or tickets).

The Data Library was created with the Singleton pattern in mind. As such it contains only class methods and
class instance variables which prevent its being instantiated as an object. It calls the DataLoader to create 
a library containing collections of objects: users, and tickets. Each individual collection of objects can be 
accessed by calling its specific getter method:

e.g. `$ DataLibrary.users`

### DataLoader
This class is designed to read from the data files provided with the repo. It takes a single argument which names
the type of objects to be loaded, opens the file, reads the data and passes it back to the object calling it
(DataLibrary)

### User model
The User model has four attributes: `id` `name` `created_at` `verified` and is associated with the `Ticket` model
in a `has_many` relationship.  The attributes are limited to read only, and are accessed in the usual ruby manner 
e.g. `user.id`

It will also output a hash of these instance variables with `user.describe` and return its
tickets if the `include_associations` argument is set to `true`.

The two class methods provide a means to retrieve either all the User records from the DataLibrary or 
search through those records to find relevant records. Search is full text only, partial matches are
not returned.

**Potential for refinement:**  The two class methods are almost identical in User & Ticket models and could be
DRYed up by inheritance from an abstract class. 

### Ticket model
The Ticket model has six attributes `id` `created_at` `type` `subject` `assignee_id` `tags` and is associated with
the User model in a belongs_to manner (`assignee_id` is the user key). Attributes are read only.

Like the User model it can also output a hash of its instance variables and related records with 
`ticket.describe(include_associations)`

As mentioneed above it also includes the two class methods (all, search) implemented in the User model.

### Limitations:
I cheated a bit in the testing by using the data files as test fixtures. Because of this, many of the tests
are not strictly *unit* tests being tested in isolation, but rather *integration* tests as they rely on DataLibrary.
I actively chose this mainly out of efficiency under time constraints.

I thought about parsing the `created_at` dates into actual date objects but decided it wasn't worth it yet as the users 
are limited to only string data entry. Should comparisons be required later this may become necessary (e.g. get 
Tickets since X date)

Similarly, I thought about creating a `Tag` model with a single attribute of name to potentially increase search efficiency
later and allow searching for an individual tag instead of the entire collection. This was not in the spec, so I decided
to apply YAGNI here. 
