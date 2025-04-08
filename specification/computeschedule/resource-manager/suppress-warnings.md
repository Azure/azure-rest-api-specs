---

## Suppression

``` yaml
suppressions:  
  - code: AvoidAdditionalProperties
    from: computeschedule.json
    where:$.definitions.VirtualMachineExtensionData.properties.properties  
    reason: using Record<unknown>,because we don't want copy VMextensionProperties type here and update this everytime there a new property added in underlying type in compute
        
```

---