### Feedback #1 ###
Use ARM error model for next API version.

PR where feedback was given - https://github.com/Azure/azure-rest-api-specs/pull/5826

Link to ARM Error model - https://github.com/Azure/azure-resource-manager-rpc/blob/master/v1.0/common-api-details.md#error-response-content

### Error Response Content ###

If the resource provider needs to return an error to any operation, it should return the appropriate HTTP error code and a message body as can be seen below. The message should be localized per the Accept-Language header specified in the original request such that it could be directly be exposed to users.

The resource providers must return the \*code\* and \*message\* fields; however, the other fields are acceptable as additions. This format matches [the OData v4.0 schema](http://docs.oasis-open.org/odata/odata-json-format/v4.0/os/odata-json-format-v4.0-os.html#_Toc372793091) for error responses.

#### Response Body ####
```
{
"error": {
  "code": "BadArgument",
  "message": "The provided database &#39;foo&#39; has an invalid username.",
  "target": "query",
  "details": [
    {
      "code": "301",
      "target": "$search"
      "message": "$search query option not supported",
    },
    {
      "code": "ConflictingAppendPolicies",
      "target": "",
      "message": "",
      "additionalInfo": [
        {
          "type": "PolicyViolation",
          "info": {
            "policySetDefinitionDisplayName": "Secure the environment",
            "policySetDefinitionId":"/subscriptions/00000-00000-0000-000/providers/Microsoft.Authorization/policySetDefinitions/TestPolicySet",
            "policyDefinitionDisplayName": "Allowed locations",
            "policyDefinitionId":"/subscriptions/00000-00000-0000-000/providers/Microsoft.Authorization/policyDefinitions/TestPolicy1",
            "policyAssignmentDisplayName": "Allow Central US and WEU only",
            "policyAsssignmentId":"/subscriptions/00000-00000-0000-000/providers/Microsoft.Authorization/policyAssignments/TestAssignment1"
          }
        }
      ]
    }
  ]
}
```

| Element name | Type | Description |
| --- | --- | --- |
| message | string (required) | Describes the error in detail and provides debugging information. If Accept-Language is set in the request, it must be localized to that language. |
| code | string (required) | Unlocalized string which can be used to programmatically identify the error. The code should be Pascal-cased, and should serve to uniquely identify a particular class of error, for example &quot;BadArgument&quot;. |
| target | string (optional) | The target of the particular error (for example, the name of the property in error). |
| details | array (optional) | An array of additional nested error response info objects, as described by this contract. |
| additionalInfo | array (optional) | An array of objects with "type" (string), and "info" (object) properties. The schema of "info" is service-specific and dependent on the "type" string. |
