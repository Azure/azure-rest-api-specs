import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using Microsoft.AAD;

// common-types v3 models `Resource.id` as a plain string, so the generated
// ResourceData constructors take `string id` and fail to call the
// `base(ResourceIdentifier id)` constructor. Map it to ResourceIdentifier for C#.
@@alternateType(
  Azure.ResourceManager.CommonTypes.Resource.id,
  Azure.Core.armResourceIdentifier,
  "csharp"
);

// AZC0030: model names must not end in 'Response' for the .NET SDK.
@@clientName(
  UnsuspendDomainServiceResponse,
  "DomainServiceUnsuspendResult",
  "csharp"
);

// The `DomainServices` operations interface generates an internal REST-operations
// class named `DomainServices`, which collides with the last segment of the
// `Azure.ResourceManager.DomainServices` namespace and forces the emitter to escape
// the whole namespace to `_DomainServices`. Rename the operation group for C# to
// avoid the collision (the class is internal, so this has no public API impact).
@@clientName(DomainServices, "DomainServiceOperationGroup", "csharp");

// Use the ARM ETag type instead of a plain string for resource etags.
@@alternateType(DomainService.etag, Azure.Core.eTag, "csharp");
@@alternateType(OuContainer.etag, Azure.Core.eTag, "csharp");

// These `location` properties are Azure regions; use AzureLocation instead of string.
@@alternateType(DomainService.location, Azure.Core.azureLocation, "csharp");
@@alternateType(OuContainer.location, Azure.Core.azureLocation, "csharp");
@@alternateType(ReplicaSet.location, Azure.Core.azureLocation, "csharp");

// .NET guideline: DateTimeOffset properties should end with `On`/`At`.
@@clientName(ConfigDiagnostics.lastExecuted, "lastExecutedOn", "csharp");
@@clientName(HealthAlert.lastDetected, "lastDetectedOn", "csharp");
@@clientName(HealthAlert.raised, "raisedOn", "csharp");
@@clientName(
  LdapsSettings.certificateNotAfter,
  "certificateNotAfterOn",
  "csharp"
);
@@clientName(ReplicaSet.healthLastEvaluated, "healthLastEvaluatedOn", "csharp");

// `Status` is a generic name in IntelliSense; it is the diagnostics validator status.
@@clientName(Status, "DomainServiceValidatorStatus", "csharp");
