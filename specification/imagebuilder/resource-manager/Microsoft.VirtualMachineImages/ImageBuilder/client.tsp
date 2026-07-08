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
@@alternateType(
  Azure.ResourceManager.CommonTypes.Resource.id,
  Azure.Core.armResourceIdentifier,
  "csharp"
);

// C#: model names must not end with 'Collection' (AZC0030).
@@clientName(RunOutputCollection, "RunOutputListResult", "csharp");
@@clientName(TriggerCollection, "ImageTemplateTriggerListResult", "csharp");

// C#: give the generic 'Trigger' resource trio RP/domain context (RESNAME001).
@@clientName(Trigger, "ImageTemplateTrigger", "csharp");

// C#: give the generic 'RunOutput' resource trio RP/domain context (RESNAME001).
@@clientName(RunOutput, "ImageTemplateRunOutput", "csharp");

// C#: boolean properties must start with a verb prefix (AZC0030 BOOL naming).
@@clientName(
  ImageTemplatePowerShellCustomizer.runElevated,
  "IsRunElevated",
  "csharp"
);
@@clientName(
  ImageTemplatePowerShellCustomizer.runAsSystem,
  "IsRunAsSystem",
  "csharp"
);
@@clientName(
  ImageTemplatePowerShellValidator.runElevated,
  "IsRunElevated",
  "csharp"
);
@@clientName(
  ImageTemplatePowerShellValidator.runAsSystem,
  "IsRunAsSystem",
  "csharp"
);
@@clientName(
  ImageTemplatePropertiesValidate.continueDistributeOnFailure,
  "ShouldContinueDistributeOnFailure",
  "csharp"
);
@@clientName(
  ImageTemplatePropertiesValidate.sourceValidationOnly,
  "IsSourceValidationOnly",
  "csharp"
);
@@clientName(
  ImageTemplateSharedImageDistributor.excludeFromLatest,
  "IsExcludedFromLatest",
  "csharp"
);

// C#: DateTimeOffset properties should end with 'On'.
@@clientName(TriggerStatus.time, "RecordedOn", "csharp");

// C#: string location should surface as AzureLocation.
@@alternateType(
  ImageTemplateManagedImageDistributor.location,
  Azure.Core.azureLocation,
  "csharp"
);

// C#: ARM resource-id string properties should surface as ResourceIdentifier.
@@alternateType(
  ImageTemplateManagedImageDistributor.imageId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  ImageTemplateManagedImageSource.imageId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  ImageTemplateSharedImageDistributor.galleryImageId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  ImageTemplateSharedImageVersionSource.imageVersionId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  VirtualNetworkConfig.subnetId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(
  VirtualNetworkConfig.containerInstanceSubnetId,
  Azure.Core.armResourceIdentifier,
  "csharp"
);

// C#: drop the leaked 'Properties' envelope naming from public model names.
@@clientName(
  ImageTemplatePropertiesErrorHandling,
  "ImageTemplateErrorHandling",
  "csharp"
);
@@clientName(
  ImageTemplatePropertiesOptimize,
  "ImageTemplateOptimizeConfig",
  "csharp"
);
@@clientName(
  ImageTemplatePropertiesOptimizeWorkload,
  "ImageTemplateWorkloadOptimization",
  "csharp"
);
@@clientName(
  ImageTemplatePropertiesValidate,
  "ImageTemplateValidationConfig",
  "csharp"
);
@@clientName(
  ImageTemplateUpdateParametersProperties,
  "ImageTemplatePatchProperties",
  "csharp"
);

@@alternateType(
  ImageTemplateIdentity.userAssignedIdentities,
  Record<Azure.ResourceManager.CommonTypes.UserAssignedIdentity>,
  "csharp"
);

// C#: give generic enums/types RP/domain context so they are understandable in
// IntelliSense without a fully qualified name (RESNAME001 / contextual naming).
@@clientName(ProvisioningState, "ImageBuilderProvisioningState", "csharp");
@@clientName(ResourceIdentityType, "ImageBuilderIdentityType", "csharp");
@@clientName(DataDisk, "ImageBuilderDataDisk", "csharp");
@@clientName(RunState, "ImageTemplateRunState", "csharp");
@@clientName(RunSubState, "ImageTemplateRunSubState", "csharp");
@@clientName(TargetRegion, "ImageTemplateTargetRegion", "csharp");
@@clientName(TriggerStatus, "ImageTemplateTriggerStatus", "csharp");
@@clientName(VirtualNetworkConfig, "ImageBuilderVirtualNetworkConfig", "csharp");
@@clientName(AutoRunState, "ImageTemplateAutoRunState", "csharp");
@@clientName(OnBuildError, "ImageBuilderOnBuildError", "csharp");
@@clientName(ProvisioningError, "ImageBuilderProvisioningError", "csharp");
@@clientName(ProvisioningErrorCode, "ImageBuilderProvisioningErrorCode", "csharp");
@@clientName(ReplicationMode, "ImageTemplateReplicationMode", "csharp");
@@clientName(VMBootOptimizationState, "ImageTemplateVMBootOptimizationState", "csharp");
@@clientName(
  WorkloadOptimizationState,
  "ImageTemplateWorkloadOptimizationState",
  "csharp"
);

// C#: flatten the PATCH body 'properties' envelope so callers set Distribute/Source/etc.
// directly on ImageTemplatePatch, consistent with the flattened ImageTemplateData (API design).
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Flattening the PATCH properties bag for C# API consistency with the resource data model."
@@Legacy.flattenProperty(ImageTemplateUpdateParameters.properties, "csharp");
