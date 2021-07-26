# Notes

1. Data
    - Ticket 
        - belongs_to: user
           - can be unassigned
        - has_many: tags
        - seems to be a *level* indicated in ticket subject
            - drama, catastrophe, problem
        - location also indicated in subject
   
   - User
      - has_many: tickets
    
### Random thoughts
Do I need to create a tag model?
Should I parse the date strings into dates for comparison?


### ToDos
3. readme
    a. deficiencies
    b. cli could be better
    c. if this were a real app, protect from sql injection
    d. talk about models
    3. how to run
5. performance testing
