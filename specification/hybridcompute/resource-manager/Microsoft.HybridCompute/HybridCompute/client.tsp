import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using Microsoft.HybridCompute;

@@clientName(Microsoft.HybridCompute,
  "HybridComputeManagementClient",
  "javascript,python"
);

@@alternateType(ServiceExtension.serviceExtensionType, string, "go");

@@alternateType(Azure.ResourceManager.CommonTypes.Identity.type, string, "go");

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
  "javascript,python,go"
);
@@clientName(CustomPublicNetworkAccessType,
  "PublicNetworkAccessType",
  "javascript,python,go"
);

@@clientName(VMGuestPatchClassification_Windows,
  "VMGuestPatchClassificationWindows",
  "python"
);
@@clientName(VMGuestPatchClassification_Linux,
  "VMGuestPatchClassificationLinux",
  "python"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "To mitigate breaking change for legacy Python SDK"
@@Legacy.clientDefaultValue(LicenseProfileNameAlias.licenseProfileName,
  "default",
  "python"
);
@@Azure.ClientGenerator.Core.alternateType(LicenseProfileNameAlias.licenseProfileName,
  "default"
);
@@clientLocation(Machines.setupExtensions, Microsoft.HybridCompute, "!go");
@@clientLocation(Machines.upgradeExtensions, Microsoft.HybridCompute, "!go");

@@clientLocation(Machines.setupExtensions, "ManagementClient", "go");
@@clientLocation(Machines.upgradeExtensions, "ManagementClient", "go");
