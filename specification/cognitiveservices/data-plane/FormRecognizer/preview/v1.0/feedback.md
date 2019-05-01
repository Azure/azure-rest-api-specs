Form Recognizer: API Review Feedback

PR Link: https://github.com/Azure/azure-rest-api-specs/pull/5684

Feedback:
---------
1. [shahabhijeet] Don't specify x-nullable: false.
2. [shahabhijeet] Use x-ms-enum for Status field (or other enums)
3. [shahabhijeet] Consider modeling error responses to something like: 
{
    "error": {
        "code": "",
        "message": "",
        "target": "",
        "additionalInfo": [],
        "details": [
            {
                "code": "",
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
                            "policyAsssignmentId":"/subscriptions/00000-00000-0000-000/providers/Microsoft.Authorization/policyAssignments/TestAssignment1",
                            ...
                            ...
                            ...
                        }
                    }
                ]
            }
        ]
    }
}
Also: https://github.com/Azure/azure-resource-manager-rpc/blob/master/v1.0/common-api-details.md#error-response-content 
(this is not the updated link, as I am trying to find the updated model, will post as soon as I find it, hence provided an actual example.
The format I am recommending allows you to have multiple error information objects as an array and "info" object is nothing but a generic JObject for dumping information like innerException.

4. [johanste] /TrainCustomModel operation creates an addressable resource (keyed by the modelId in the response)
This should probably return a 201 with a Location header pointing to the result.

