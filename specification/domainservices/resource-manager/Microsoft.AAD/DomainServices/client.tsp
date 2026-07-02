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
