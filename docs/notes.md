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
    
