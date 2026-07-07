import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.VirtualMachineImages;

@@clientName(ImageTemplateProperties.validate, "validation", "java");
@@clientName(AutoRunState.AutoRunEnabled, "Enabled", "java");
@@clientName(AutoRunState.AutoRunDisabled, "Disabled", "java");
@@clientName(
  Microsoft.VirtualMachineImages,
  "ImageBuilderClient",
  "javascript,python,java"
);

// C#: common-types Resource.id is a plain string; map to ResourceIdentifier so generated
// *Data ctors satisfy the ResourceData base (fixes CS1503).
@@alternateType(Azure.ResourceManager.CommonTypes.Resource.id,
  Azure.Core.armResourceIdentifier,
  "csharp"
);

// C#: model names must not end with 'Collection' (AZC0030).
@@clientName(RunOutputCollection, "RunOutputListResult", "csharp");
@@clientName(TriggerCollection, "TriggerListResult", "csharp");
