``` yaml
# add any configuration here for all CLI languages
# refer to the faq.md for more details
cli:
    cli-directive:
      - where:
            group: .*
            parameter: privateLinkResourceId
        alias:
            - priv_link_resource_id
        ## hide an operation
      - where:
            group: .*
            op: Patch
        hidden: true            
      - where:
            group: .*
            op: PatchDetails            
        hidden: true   
      - where:
            group: .*
            op: GetDetails
        name: show
      - where:
            group: .*
            op: PutDetails
        name: create
      - where:
            group: .*
            op: ListByResourceGroup
        hidden: true
      - where:
            group: .*
            op: ListBySubscription
        hidden: true                                  
```