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
1. Add cli
2. Add error handling
3. performance testing
4. handle search for missing values
    - make attributes optional