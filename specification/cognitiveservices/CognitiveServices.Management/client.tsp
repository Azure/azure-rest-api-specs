import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";
import "@typespec/rest";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ClientGenerator.Core;
using Microsoft.CognitiveServices;
using Azure.ResourceManager;

@@clientName(Microsoft.CognitiveServices,
  "CognitiveServicesManagementClient",
  "javascript,python"
);

@@clientName(AgentProtocol.A2A, "A2_A", "python");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy decorator required for Python SDK compatibility"
@@Azure.ClientGenerator.Core.Legacy.clientDefaultValue(ConnectionsListParameters.includeAll,
  false,
  "python"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy decorator required for Python SDK compatibility"
@@Azure.ClientGenerator.Core.Legacy.clientDefaultValue(AgentDeploymentsListParameters.count,
  30,
  "python"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy decorator required for Python SDK compatibility"
@@Azure.ClientGenerator.Core.Legacy.clientDefaultValue(AgentDeploymentsListParameters.orderByAsc,
  false,
  "python"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy decorator required for Python SDK compatibility"
@@Azure.ClientGenerator.Core.Legacy.clientDefaultValue(AgentApplicationsListParameters.count,
  30,
  "python"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy decorator required for Python SDK compatibility"
@@Azure.ClientGenerator.Core.Legacy.clientDefaultValue(AgentApplicationsListParameters.orderByAsc,
  false,
  "python"
);

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op checkDomainAvailabilityCustom(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...SubscriptionActionScope,
  ...Azure.ResourceManager.Legacy.Provider,
  subdomainName: string,
  type: string,
  kind?: string,
): DomainAvailability;
@@override(checkDomainAvailability,
  checkDomainAvailabilityCustom,
  "javascript"
);
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op checkSkuAvailabilityCustom(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...SubscriptionActionScope,
  ...Azure.ResourceManager.Legacy.Provider,
  location: string,
  skus: string[],
  type: string,
  kind: string,
): SkuAvailabilityListResult;
@@override(checkSkuAvailability, checkSkuAvailabilityCustom, "javascript");
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op calculateModelCapacityCustom(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...Azure.ResourceManager.Legacy.Provider,
  `model`?: DeploymentModel,
  skuName?: string,

  @identifiers(#[])
  workloads?: ModelCapacityCalculatorWorkload[],
): CalculateModelCapacityResult;

@@override(calculateModelCapacity, calculateModelCapacityCustom, "javascript");

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op regenerateKeyCustom(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...ResourceGroupParameter,
  ...Azure.ResourceManager.Legacy.Provider,

  @path
  @segment("accounts")
  @key
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9_.-]*$")
  @minLength(2)
  @maxLength(64)
  accountName: string,

  keyName: KeyName,
): ApiKeys;
@@override(Accounts.regenerateKey, regenerateKeyCustom, "javascript");

@@clientName(Microsoft.CognitiveServices.PATAuthTypeConnectionProperties,
  "PatAuthTypeConnectionProperties",
  "java"
);
@@clientName(Microsoft.CognitiveServices.SASAuthTypeConnectionProperties,
  "SasAuthTypeConnectionProperties",
  "java"
);
@@clientName(Microsoft.CognitiveServices.AADAuthTypeConnectionProperties,
  "AadAuthTypeConnectionProperties",
  "java"
);

@@clientLocation(checkDomainAvailability, "ManagementClient", "go");
@@clientLocation(checkSkuAvailability, "ManagementClient", "go");
@@clientLocation(calculateModelCapacity, "ManagementClient", "go");
