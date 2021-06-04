``` yaml
# add any configuration here for all CLI languages
# refer to the faq.md for more details
cli:
    cli-directive:
      - where:
            group: .*
            parameter: privateLinkResourceId
        alias:
            - privLinkResourceId
        ## hide an operation
      - where:
            group: .*
            op: Patch
        hidden: true
      - where:
            group: .*
            op: GetDetails
        name: show
      - where:
            group: .*
            op: PutDetails
        name: create                          
```