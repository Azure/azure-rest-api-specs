import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.ServiceNetworking;

@@clientName(Microsoft.ServiceNetworking, "ServiceNetworkingMgmt", "python");
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

// csharp
#suppress "deprecated" "property flatten for SDK backward compatibility"
@@flattenProperty(Frontend.properties, "csharp");
#suppress "deprecated" "property flatten for SDK backward compatibility"
@@flattenProperty(Association.properties, "csharp");
#suppress "deprecated" "property flatten for SDK backward compatibility"
@@flattenProperty(AssociationUpdate.properties, "csharp");
#suppress "deprecated" "property flatten for SDK backward compatibility"
@@flattenProperty(TrafficController.properties, "csharp");
#suppress "deprecated" "property flatten for SDK backward compatibility"
@@flattenProperty(SecurityPolicy.properties, "csharp");
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
