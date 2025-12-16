import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.ServiceNetworking;

@@clientName(Microsoft.ServiceNetworking,
  "ServiceNetworkingMgmtClient",
  "python"
);
@@clientName(Microsoft.ServiceNetworking,
  "ServiceNetworkingManagementClient",
  "javascript"
);
@@clientName(Microsoft.ServiceNetworking,
  "TrafficControllerManagementClient",
  "java"
);
@@clientNamespace(Microsoft.ServiceNetworking,
  "com.azure.resourcemanager.servicenetworking",
  "java"
);
@@clientName(Microsoft.ServiceNetworking,
  "ServiceNetworkingMgmtClient",
  "python"
);

// csharp
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "property flatten for SDK backward compatibility"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Frontend.properties,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "property flatten for SDK backward compatibility"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(Association.properties,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "property flatten for SDK backward compatibility"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(AssociationUpdate.properties,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "property flatten for SDK backward compatibility"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(TrafficController.properties,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "property flatten for SDK backward compatibility"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Back compatibility"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(SecurityPolicy.properties,
  "csharp"
);
@@clientName(SecurityPolicy,
  "ApplicationGatewayForContainersSecurityPolicy",
  "csharp"
);
@@clientName(Association, "TrafficControllerAssociation", "csharp");
@@clientName(AssociationUpdate, "TrafficControllerAssociationUpdate", "csharp");
@@clientName(AssociationType, "TrafficControllerAssociationType", "csharp");
@@clientName(Frontend, "TrafficControllerFrontend", "csharp");
@@clientName(PolicyType,
  "ApplicationGatewayForContainersSecurityPolicyType",
  "csharp"
);
@@clientName(ProvisioningState, "ServiceNetworkingProvisioningState", "csharp");
@@clientName(TrafficControllerProperties.provisioningState,
  "TrafficControllerProvisioningState",
  "csharp"
);
@@clientName(IpAccessRule, "ServiceNetworkingIPAccessRule", "csharp");
@@clientName(IpAccessRuleAction,
  "ServiceNetworkingIPAccessRuleAction",
  "csharp"
);
@@clientName(Versions.v2023_11_01,
  "$DO_NOT_NORMALIZE$V2023_11_01",
  "javascript"
);
@@clientName(Versions.v2025_05_01,
  "$DO_NOT_NORMALIZE$V2025_05_01",
  "javascript"
);
