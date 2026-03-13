import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Azure.Core;
using Azure.ResourceManager;
using Microsoft.Resources.DeploymentStacks;
using TypeSpec.Versioning;

@@alternateType(DeploymentStackProperties.template, unknown, "go");
@@alternateType(DeploymentStackProperties.outputs, unknown, "go");
@@alternateType(DeploymentStackTemplateDefinition.template, unknown, "go");
@@alternateType(ResourceReference.identifiers, unknown, "go");

// Java SDK: Mitigate breaks from TypeSpec migration
@@alternateType(DeploymentStackProperties.template, unknown, "java");
@@alternateType(DeploymentStackProperties.outputs, unknown, "java");
@@alternateType(DeploymentStackTemplateDefinition.template, unknown, "java");

// CSharp SDK: Generate scoped resources, and make it backwards compatible with existing patterns
#suppress "@azure-tools/typespec-azure-resource-manager/missing-operations-endpoint" "Operations API defined separately - namespace is shared between multiple services."
namespace Microsoft.Resources.DeploymentStacks {
  // DeploymentStacks
  @@scope(DeploymentStacksAtResourceGroup.get, "!csharp");
  @@scope(DeploymentStacksAtResourceGroup.list, "!csharp");
  @@scope(DeploymentStacksAtResourceGroup.validateStack, "!csharp");
  @@scope(DeploymentStacksAtResourceGroup.createOrUpdate, "!csharp");
  @@scope(DeploymentStacksAtResourceGroup.exportTemplate, "!csharp");
  @@scope(DeploymentStacksAtResourceGroup.delete, "!csharp");
  @@scope(DeploymentStacksAtSubscription.get, "!csharp");
  @@scope(DeploymentStacksAtSubscription.list, "!csharp");
  @@scope(DeploymentStacksAtSubscription.validateStack, "!csharp");
  @@scope(DeploymentStacksAtSubscription.createOrUpdate, "!csharp");
  @@scope(DeploymentStacksAtSubscription.exportTemplate, "!csharp");
  @@scope(DeploymentStacksAtSubscription.delete, "!csharp");
  @@scope(DeploymentStacksAtManagementGroup.get, "!csharp");
  @@scope(DeploymentStacksAtManagementGroup.list, "!csharp");
  @@scope(DeploymentStacksAtManagementGroup.validateStack, "!csharp");
  @@scope(DeploymentStacksAtManagementGroup.createOrUpdate, "!csharp");
  @@scope(DeploymentStacksAtManagementGroup.exportTemplate, "!csharp");
  @@scope(DeploymentStacksAtManagementGroup.delete, "!csharp");

  @@armResourceOperations(DeploymentStacksAtScope);
  interface DeploymentStacksAtScope
    extends DeploymentStackCommonOps<
        Extension.ScopeParameter,
        "DeploymentStack"
      > {}

  @@scope(DeploymentStacksAtScope.get, "csharp");
  @@scope(DeploymentStacksAtScope.list, "csharp");
  @@scope(DeploymentStacksAtScope.validateStack, "csharp");
  @@scope(DeploymentStacksAtScope.createOrUpdate, "csharp");
  @@scope(DeploymentStacksAtScope.exportTemplate, "csharp");
  @@scope(DeploymentStacksAtScope.delete, "csharp");

  // DeploymentStacksWhatIfResults
  @@scope(DeploymentStacksWhatIfResultsAtResourceGroup.get, "!csharp");
  @@scope(DeploymentStacksWhatIfResultsAtResourceGroup.list, "!csharp");
  @@scope(DeploymentStacksWhatIfResultsAtResourceGroup.createOrUpdate,
    "!csharp"
  );
  @@scope(DeploymentStacksWhatIfResultsAtResourceGroup.delete, "!csharp");
  @@scope(DeploymentStacksWhatIfResultsAtResourceGroup.whatIf, "!csharp");
  @@scope(DeploymentStacksWhatIfResultsAtSubscription.get, "!csharp");
  @@scope(DeploymentStacksWhatIfResultsAtSubscription.list, "!csharp");
  @@scope(DeploymentStacksWhatIfResultsAtSubscription.createOrUpdate,
    "!csharp"
  );
  @@scope(DeploymentStacksWhatIfResultsAtSubscription.delete, "!csharp");
  @@scope(DeploymentStacksWhatIfResultsAtSubscription.whatIf, "!csharp");
  @@scope(DeploymentStacksWhatIfResultsAtManagementGroup.get, "!csharp");
  @@scope(DeploymentStacksWhatIfResultsAtManagementGroup.list, "!csharp");
  @@scope(DeploymentStacksWhatIfResultsAtManagementGroup.createOrUpdate,
    "!csharp"
  );
  @@scope(DeploymentStacksWhatIfResultsAtManagementGroup.delete, "!csharp");
  @@scope(DeploymentStacksWhatIfResultsAtManagementGroup.whatIf, "!csharp");

  @@armResourceOperations(DeploymentStacksWhatIfAtScope);
  @@added(DeploymentStacksWhatIfAtScope, Versions.v2025_07_01);
  interface DeploymentStacksWhatIfAtScope
    extends DeploymentStackWhatIfCommon<
        Extension.ScopeParameter,
        "deploymentStackWhatIfResult"
      > {}

  @@scope(DeploymentStacksWhatIfAtScope.get, "csharp");
  @@scope(DeploymentStacksWhatIfAtScope.list, "csharp");
  @@scope(DeploymentStacksWhatIfAtScope.createOrUpdate, "csharp");
  @@scope(DeploymentStacksWhatIfAtScope.delete, "csharp");
  @@scope(DeploymentStacksWhatIfAtScope.whatIf, "csharp");
}
@@clientName(DeploymentParameter, "DeploymentParameterItem", "csharp"); // .NET SDK validation: cannot end in "Parameter"
@@clientName(DeploymentStackTemplateDefinition,
  "DeploymentStackTemplateExportResult",
  "csharp"
); // .NET SDK validation: cannot end in "Definition"
@@clientName(DeploymentStacksWhatIfResult,
  "DeploymentStackWhatIfResult",
  "csharp"
);
@@clientName(DeploymentStacksWhatIfResultProperties,
  "DeploymentStackWhatIfResultProperties",
  "csharp"
);
@@alternateType(DeploymentStackProperties.duration, duration, "csharp");
@@alternateType(DeploymentStackProperties.outputs, unknown, "csharp");
@@alternateType(DeploymentStack.location, azureLocation, "csharp");
@@alternateType(DeploymentStacksWhatIfResult.location, azureLocation, "csharp");
@@alternateType(DeploymentStackSharedProperties.template, unknown, "csharp");
@@alternateType(DeploymentStacksParametersLink.uri, url, "csharp");
@@alternateType(DeploymentStacksTemplateLink.uri, url, "csharp");
@@alternateType(ResourceReference.id, armResourceIdentifier, "csharp");
@@alternateType(ResourceReference.type, armResourceType, "csharp");
@@alternateType(ResourceReference.identifiers, unknown, "csharp");
@@clientName(DeploymentStacksWhatIfResultProperties.deploymentStackLastModified,
  "DeploymentStackLastModifiedOn",
  "csharp"
);
@@alternateType(DeploymentStacksWhatIfResultProperties.deploymentStackResourceId,
  armResourceIdentifier,
  "csharp"
);
@@alternateType(KeyVaultReference.id, armResourceIdentifier, "csharp");
@@alternateType(DeploymentStacksWhatIfResourceChange.resourceConfigurationChanges,
  DeploymentStacksChangeDelta<unknown>,
  "csharp"
);
@@alternateType(DeploymentStackTemplateDefinition.template, unknown, "csharp");
@@usage(DeploymentStackValidateProperties,
  Usage.input | Usage.output,
  "csharp"
);
@@usage(ManagedResourceReference, Usage.input | Usage.output, "csharp");
@@usage(ResourceReferenceExtended, Usage.input | Usage.output, "csharp");
@@clientName(ResourceReference, "DeploymentStackResourceReference", "csharp");
@@clientName(ManagedResourceReference,
  "DeploymentStackManagedResourceReference",
  "csharp"
);
@@clientName(ResourceReferenceExtended,
  "DeploymentStackResourceReferenceExtended",
  "csharp"
);
@@clientName(ValidationLevel, "DeploymentStackValidationLevel", "csharp");
@@clientName(DenySettings, "DeploymentStackDenySettings", "csharp");
@@clientName(DenySettingsMode, "DeploymentStackDenySettingsMode", "csharp");
@@clientName(DenyStatusMode, "DeploymentStackDenyStatusMode", "csharp");
@@clientName(Azure.ResourceManager.Foundations.ErrorAdditionalInfo,
  "DeploymentStackAdditionalErrorInfo",
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "update base model for SDK backward compatibility"
@@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(DeploymentStackValidateResult,
  Azure.ResourceManager.Foundations.ProxyResource,
  "csharp"
);
