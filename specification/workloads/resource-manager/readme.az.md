[90m unassignable[39m: Type 'string' is not assignable to type 'Model | void'
> 154 |     string,
      |     ^^^^^^


[39m: Duplicate operation "listSkusForNew" routed at "get /subscriptions/{subscriptionId}/providers/Microsoft.AnalysisServices/servers".
> 84 |   listSkusForNew is ArmListBySubscription<AnalysisServicesServer>;
     |   ^^^^^^^^^^^^^^
[39m: Duplicate operation "listDefault" routed at "get /subscriptions/{subscriptionId}/providers/Microsoft.Attestation/attestationProviders".
> 68 |   listDefault is ArmListBySubscription<AttestationProvider>;
     |   ^^^^^^^^^^^



[39m: Invalid tag name. Use backticks around code if this was not meant to be a tag.
> 4594 | '_', '@', '#', '.', ':', '-'. 
       |        ^
[39m: Invalid tag name. Use backticks around code if this was not meant to be a tag.
> 2085 |    * Specifies the password of the administrator account. <br><br> **Minimum-length (Windows):** 8 characters <br><br> **Minimum-length (Linux):** 6 characters <br><br> **Max-length (Windows):** 123 characters <br><br> **Max-length (Linux):** 72 characters <br><br> **Complexity requirements:** 3 out of 4 conditions below need to be fulfilled <br> Has lower characters <br>Has upper characters <br> Has a digit <br> Has a special character (Regex match [\W_]) <br><br> **Disallowed values:** "abc@123", "P@$$w0rd", "P@ssw0rd", "P@ssword123", "Pa$$word", "pass@word1", "Password!", "Password1", "Password22", "iloveyou!" <br><br> For resetting the password, see [How to reset the Remote Desktop service or its login password in a Windows VM](https://docs.microsoft.com/troubleshoot/azure/virtual-machines/reset-rdp) <br><br> For resetting root password, see [Manage users, SSH, and check or repair disks on Azure Linux VMs using the VMAccess Extension](https://docs.microsoft.com/troubleshoot/azure/virtual-machines/troubleshoot-ssh-connection)
       |                            



[90m interface-duplicate[39m: Interface already has a member named listByApiManagementServiceResource
> 165 |   listByService is Azure.Core.Foundations.Operation<
      |   ^^^^^^^^^^^^^
[90m interface-duplicate[39m: Interface already has a member named get
> 220 |   get is Azure.Core.Foundations.Operation<
      |   ^^^




[90m duplicate-property[39m: Model already has a property named subscriptionId
> 135 |   ...KeysOf<TResource>;
      |   ^^^^^^^^^^^^^^^^^^^^
[90m duplicate-property[39m: Model already has a property named vmScaleSetName
> 135 |   ...KeysOf<TResource>;
      |   ^^^^^^^^^^^^^^^^^^^^


[90m invalid-template-args[39m: Too few template arguments provided.
> 2624 | model ContainerAppAuthToken extends TrackedResource {
       |                                     ^^^^^^^^^^^^^^^
[90m invalid-template-args[39m: Too few template arguments provided.
> 3677 | model EnvironmentAuthToken extends TrackedResource {
       |                                    ^^^^^^^^^^^^^^^




[90m doc-invalid-identifier[39m: Invalid tag name. Use backticks around code if this was not meant to be a tag.
> 4594 | '_', '@', '#', '.', ':', '-'. 
       |        ^
[90m doc-invalid-identifier[39m: Invalid tag name. Use backticks around code if this was not meant to be a tag.
> 2085 |    * Specifies the password of the administrator account. <br><br> **Minimum-length (Windows):** 8 characters <br><br> **Minimum-length (Linux):** 6 characters <br><br> **Max-length (Windows):** 123 characters <br><br> **Max-length (Linux):** 72 characters <br><br> **Complexity requirements:** 3 out of 4 conditions below need to be fulfilled <br> Has lower characters <br>Has upper characters <br> Has a digit <br> Has a special character (Regex match [\W_]) <br><br> **Disallowed values:** "abc@123", "P@$$w0rd", "P@ssw0rd", "P@ssword123", "Pa$$word", "pass@word1", "Password!", "Password1", "Password22", "iloveyou!" <br><br> For resetting the password, see [How to reset the Remote Desktop service or its login password in a Windows VM](https://docs.microsoft.com/troubleshoot/azure/virtual-machines/reset-rdp) <br><br> For resetting root password, see [Manage users, SSH, and check or repair disks on Azure Linux VMs using the VMAccess Extension](https://docs.microsoft.com/troubleshoot/azure/virtual-machines/troubleshoot-ssh-connection)




[90m token-expected[39m: ';' expected.
> 107 | "name": string
      |               ^
> 108 | /**
      | ^
[90m token-expected[39m: Statement expected.
> 387 | * List of management operations that are excluded from blueprint locks. Up to 200 actions are permitted. If the lock mode is set to 'AllResourcesReadOnly', then the following actions are automatically appended to 'excludedActions': '*/read', 'Microsoft.Network/virtualNetworks/subnets/join/action' and 'Microsoft.Authorization/locks/delete'. If the lock mode is set to 'AllResourcesDoNotDelete', then the following actions are automatically appended to 'excludedActions': 'Microsoft.Authorization/locks/delete'. Duplicate actions will get removed.



[90m unassignable[39m: Type 'string' is not assignable to type 'Model | void'
> 154 |     string,
      |     ^^^^^^
[90m unassignable[39m: Type 'string' is not assignable to type 'Record<unknown>'
> 1846 |   identityCertThumbprint?: string;
       |                            ^^^^^^


[90m @azure-tools/typespec-azure-core/invalid-resource-type[39m: Model type 'Model' is not a valid resource type.  It must contain a property decorated with '@key'.
> 63 |   listWebAppsByHybridConnection is Azure.Core.ResourceList<string>;
     |   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[90m @azure-tools/typespec-azure-core/invalid-resource-type[39m: Model type 'Model' is not a valid resource type.  It must contain a property decorated with '@key'.
> 68 |   listAssociatedResources is Azure.Core.ResourceList<string>;
     |   ^^^^^^^^^^^^^^^^^^^^^^^



[90m unknown-identifier[39m: Unknown identifier FileZilla3
> 1413 |   FileZilla3,
       |   ^^^^^^^^^^
[90m unknown-identifier[39m: Unknown identifier CreatedByType
> 30 |   createdByType?: CreatedByType;
     |                   ^^^^^^^^^^^^^



[39m[90m invalid-argument[39m: Argument 'ErrorType' is not assignable to parameter of type '{}'
> 1411 |   format,
       |   ^^^^^^

[39m[90m invalid-argument-count[39m: Expected 1-2 arguments, but got 5.
> 1409 | @@doc(Sites.listPublishingProfileXmlWithSecrets::parameters.body,
       | ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 1410 |   "Specifies publishingProfileOptions for publishing profile. For example, use {",
       | ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 1411 |   format,
       | ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 1412 |   ": ",
       | ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 1413 |   FileZilla3,
       | ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 1414 |   "} to get a FileZilla publishing profile."
       | ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 1415 | );
       | ^^^


[39m[90m unassignable[39m: Type 'string' is not assignable to type 'Model | void'
> 317 |     string,
      |     ^^^^^^



[39m[90m invalid-ref[39m: Type doesn't have meta property parameters
> 71 | @@extension(ScriptExecutions.getExecutionLogs::parameters.body, "x-ms-client-name", "scriptOutputStreamType");
     |                                                ^^^^^^^^^^


[90m invalid-ref[39m: Model doesn't have member body
> 106 | @@projectedName(Galleries.update::parameters.body, "json", "sharingUpdate");
      |                                              ^^^^





[39m[90m unsupported-default[39m: Default must be have a value type but has type 'Intrinsic'.
> 2150 |   resizeTimeout?: duration = duration.PT15M;
       |                              ^^^^^^^^^^^^^^

[90m unsupported-default[39m: Default must be have a value type but has type 'Intrinsic'.
> 509 |   keySource?: KeySource = KeySource.Microsoft.KeyVault;
      |                           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^


[90m invalid-character[39m: Invalid character.
> 387 | * List of management operations that are excluded from blueprint locks. Up to 200 actions are permitted. If the lock mode is set to 'AllResourcesReadOnly', then the following actions are automatically appended to 'excludedActions': '*/read', 'Microsoft.Network/virtualNetworks/subnets/join/action' and 'Microsoft.Authorization/locks/delete'. If the lock mode is set to 'AllResourcesDoNotDelete', then the following actions are automatically appended to 'excludedActions': 'Microsoft.Authorization/locks/delete'. Duplicate actions will get removed.

[90m invalid-character[39m: Invalid character.
> 19 | or if one or more such resources exist, each of these must be GC'd and their time of deletion be more than 24 Hours Ago")
     |                                              






[90m duplicate-symbol[39m: Duplicate name: "RoleInstances"
> 11500 | model RoleInstances {
        |       ^^^^^^^^^^^^^
[90m duplicate-symbol[39m: Duplicate name: "PrivateEndpointConnectionProxyProperties"
> 434 | model PrivateEndpointConnectionProxyProperties {
      |       ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^



[90m missing-index[39m: Index signature for type 'string' is missing in type 'Microsoft.DataFactory.RerunTumblingWindowTriggerTypeProperties'.
> 22881 |   typeProperties: RerunTumblingWindowTriggerTypeProperties;
        |                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


[90m @typespec/rest/duplicate-parent-key[39m: Resource type 'ServiceRunner' has a key property named 'name' which conflicts with the key name of a parent or child resource.
> 27 |   name: string;
     |   ^^^^




[90m @typespec/http/missing-path-param[39m: Path contains parameter policyTrackedResourcesResource but wasn't found in given parameters
> 18 |   listQueryResultsForManagementGroup is Azure.Core.Foundations.Operation<
     |   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[90m @typespec/http/missing-path-param[39m: Path contains parameter policyStatesSummaryResource but wasn't found in given parameters
> 1842 |   summarizeForResourceGroupLevelPolicyAssignment is Azure.Core.Foundations.Operation<
       |   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^



[90m unterminated[39m: Unterminated string literal.
> 17 | @summary("API to check for resource name availability.
     |          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


[90m import-first[39m: Imports must come prior to namespaces or other declarations.
> 106 | @@projectedName(Databases.import::parameters.body, "json", "parameters");
      |                           ^^^^^^


[90m import-not-found[39m: Couldn't resolve import "::"
> 107 | @@extension(Databases.import::parameters.body, "x-ms-client-name", "parameters");
      |                       ^^^^^^














