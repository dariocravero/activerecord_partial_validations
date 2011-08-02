# ActiveRecord partial validations

ActiveRecord support for partial validations which allows you to validate only the attributes that are present at the time you're validating a model.

Just add using_partial_validations to your model and you're good to go :)

E.g.:

    class Person < ActiveRecord::Base 
      using_partial_validations

      validates_inclussion_of :name, :in => ["Dario", "Javier", "Cravero"]
    end

will only validate the name if the model has it when it's been created, therefore:

    p=Person.create
    p.valid? # true
    p.name="John"
    p.valid? # false
    p.valid? "Dario" # true

At [@starlightlabs](http://twitter.com/#!/starlightlabs) we've found this to be the cleanest solution to submitting complex-multi-step-forms for one model. We've tried adding a steps variable to the models and stuff like that but it just feels dirty and it actually mixes up stuff which, in our consideration, shouldn't be mixed -i.e. views & models. [Let us know](mailto:dario@starlight.ie) if you've found this useful or have any other solution. :)
