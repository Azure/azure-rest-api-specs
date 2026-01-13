import "@azure-tools/typespec-client-generator-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./main.tsp";

using Http;
using Azure.ClientGenerator.Core;
using TypeSpec.Rest;
using Microsoft.ResourceConnector;

@@clientName(Microsoft.ResourceConnector,
  "ResourceConnectorManagementClient",
  "javascript"
);
@@clientName(Microsoft.ResourceConnector,
  "ResourceConnectorMgmtClient",
  "python"
);

@@clientName(Microsoft.ResourceConnector.SSHKey, "SshKey", "java");

// Fix property name case changes to maintain backward compatibility
@@clientName(Microsoft.ResourceConnector.SSHKey.expirationTimeStamp,
  "expirationTimestamp",
  "java"
);
@@clientName(Microsoft.ResourceConnector.SSHKey.creationTimeStamp,
  "creationTimestamp",
  "java"
);

@@clientName(Microsoft.ResourceConnector.Appliance, "Appliance", "csharp");
@@clientName(Microsoft.ResourceConnector.SupportedVersionCatalogVersionData,
  "SupportedVersionCatalogVersionDataField",
  "csharp"
);
@@clientName(Microsoft.ResourceConnector.ApplianceOperation,
  "OperationEntity",
  "csharp"
);
@@clientName(Microsoft.ResourceConnector.ApplianceOperationValueDisplay,
  "OperationDisplay",
  "csharp"
);
@@alternateType(Azure.ResourceManager.CommonTypes.Resource.id,
  Azure.Core.armResourceIdentifier,
  "csharp"
);

#suppress "@azure-tools/typespec-azure-core/casing-style" "customization"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op AppliancesUpdateCustomized(
  ...Azure.ResourceManager.CommonTypes.ApiVersionParameter,
  ...Azure.ResourceManager.CommonTypes.SubscriptionIdParameter,
  ...Azure.ResourceManager.CommonTypes.ResourceGroupNameParameter,
  ...Azure.ResourceManager.Legacy.Provider,

  @path
  @maxLength(63)
  @minLength(1)
  @doc("Appliances name.")
  @segment("appliances")
  @pattern("^[a-zA-Z0-9]$|^[a-zA-Z0-9][-_a-zA-Z0-9]{0,61}[a-zA-Z0-9]$")
  resourceName: string,

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "override"
  @doc("Resource tags")
  @body
  tags?: Record<string>,
): Appliance;
@@override(Appliances.update, AppliancesUpdateCustomized, "javascript,python");
