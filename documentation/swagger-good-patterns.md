# Swagger recommended patterns

 - Type property as an enum
    If a Model Property has the name "type" in it or the name or description indicates that it is "some kind/type of" an artifact, then make sure at least one of the following criterion is satisfied
     - Create an enum with set of allowed values if possible
     - If enum creating is not possible, document the values in description. If the number of allowed values is huge, add a link to MSDN documentation in the description.
 - Client flattening
    It is very easy to get confused about where the "x-ms-client-flatten" extension needs to be applied. Following tips can help 
    - Flattening can only happen on a Composite Model Type (in the SwaggerModeler language). It cannot be applied on any collection (Arrays, Dictionaries) as one does not know at compile time what needs to be flattened.
    - Flattening will bring the properties of the **referenced Composite Type** one level up, as a result the referenced property dies and gives way to the inner properties that it was composed of. The best example can be found [here](https://github.com/Azure/azure-rest-api-specs/blob/master/arm-storage/2016-01-01/swagger/storage.json#L763).
 - ClientName & DiscriminatorValue should not be same as the PropertyName
    The value of "x-ms-client-flatten" and "x-ms-discriminator-value" should not be the same as the name of the ModelProperty or the Model it is being applied on. Otherwise, the purpose is defeated.
 - Checks on the Resource Model
    - Every "Resource" Model should have "location" as a "required" property as per the mandate from ARM team; no exceptions are allowed over here.
    - Every "Resource" Model should be tagged with "x-ms-azure-resource". This will cause the Resource to inherit from the Resource definition in the client runtime.
    - GET/PUT/PATCH for a resource should return the same "Resource" Model, also PUT should accept the same body (there can be readonly, optional, required properties).
    - For PATCH model every property should be optional and they should not provide any default values.
 - Consistency in the naming of list methods
    - Operations that provide resources in a resource group should be named as "OperationGroup_ListByResourceGroup"
    - Operations that provide resources in a subscription should be named as "OperationGroup_List"
    - If the ListByResourceGroup is overloaded "i.e. if the resourcegroup is null then the operation lists all resources in the subscription" then, such operations should not be allowed.
 - Consistency of the Names of the APIs, parameters and models
    - Resource Model name should be same as singular form of the resource type. Like for virtualMachines resource type it should be VirtualMachine.
    - Parameter names in the apis should be name of the resource like virtualMachines\{virtualMachine} or virtualMachines\{virtualMachineName} both are good example but virtualMachines\{vm} is bad example. 
    - Any action name should be same as what is defined in the Rest APIs, like regenerateAdminKeys should be regenerateAdminKeys in the Swagger as well, where as regenerateKeys is bad example.
 - Check for Completeness
    - Get information about all the operations from a RP, which usually can be obtained by making a GET http request where the uri is of the following pattern: `https://management.azure.com/providers/{serviceName}/operations?api-version={apiVersion}`. There should be matching swagger management apis for all the operations returned from operations api for resource provider.
 - Global Parameters
    - SubscriptionId & ApiVersion should always be defined in the global parameters section, **for them to be properties on the client**.
    - ResourceGroupName can also be defined in the global parameters section with the extension ["x-ms-parameter-location": "method"](https://github.com/Azure/autorest/blob/master/Documentation/swagger-extensions.md#x-ms-parameter-location). This will not make it a client property and it reduces repetition.
 - Terminal SuccessStatusCodes in responses for a LongRunning Operation
    A longrunning operation should have a terminal success status code. At least 200 for PUT/POST/PATCH and "204 or 200 or both" for delete. This will tell us how should we deserialize the final success response after the polling is done.
 - Paging
    - Single page pageable operations: Operations that return a single page and have the response schema `{"value": [Array of items] }`, should apply the paging extension with it's nextLinkName property explicitly set to "null". This will ensure that value property get's unwrapped into an IEnumerable<underlyingItemType>.
    - If the nextLinkName property of the "x-ms-pageable" extension is defined with a value, then the Model definition should also have a property named with the same value for nextLink.
    - If a swagger spec has a fully pageable operation and a single page pageable operation then the generated code in C# will generate Page1.cs and Page.cs. They will differ on nextLink. To avoid this it is best advised that all the operations are defined as fully pageable in the spec.
 - Define Default
    -  Define "Default" if the error response has more properties than code and message
 - API Version match
   - Make sure version in Swagger Spec matches Api-version folder in path
 - Swagger folder
   - Make sure Swagger folder is present in path
 - Inherit from Resource
   - All resource like models should inherit from Resource
 - CreateUpdate/Create
   - It is a good practice to explain the behavior difference between CreateOrUpdate and Update in Description
 - Specify units in Description
   - It is a good practice to specify units in description for properties like size
 - Add a link to MSDN Rest Api Docs whenever possible.
