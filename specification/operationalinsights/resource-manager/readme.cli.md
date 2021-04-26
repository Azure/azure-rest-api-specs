``` yaml
# add any configuration here for all CLI languages
# refer to the faq.md for more details
```
cli:
  cli-directive:
    ## rename a parameter 
    - where:
        group: SavedSearches
        op: CreateOrUpdate
        param: query
      name: input_query