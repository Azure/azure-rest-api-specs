import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using Microsoft.HybridCompute;

@@clientName(Microsoft.HybridCompute,
  "HybridComputeManagementClient",
  "javascript"
);

@@alternateType(ServiceExtension.serviceExtensionType, string, "go");

/**
 * The network access policy to determine if Azure Arc agents can use public Azure Arc service endpoints. Defaults to disabled (access to Azure Arc services only via private link).
 */
union CustomPublicNetworkAccessType {
  string,

  /**
   * Allows Azure Arc agents to communicate with Azure Arc services over both public (internet) and private endpoints.
   */
  Enabled: "Enabled",

  /**
   * Does not allow Azure Arc agents to communicate with Azure Arc services over public (internet) endpoints. The agents must use the private link.
   */
  Disabled: "Disabled",

  /**
   * Azure Arc agent communication with Azure Arc services over public (internet) is enforced by Network Security Perimeter (NSP).
   */
  SecuredByPerimeter: "SecuredByPerimeter",
}
@@alternateType(PublicNetworkAccessType,
  CustomPublicNetworkAccessType,
  "javascript"
);
