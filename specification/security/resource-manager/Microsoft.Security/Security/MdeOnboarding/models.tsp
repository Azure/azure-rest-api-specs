import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "../Common/main.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.Security;

/**
 * List of all MDE onboarding data resources
 */
model MdeOnboardingDataList {
  /**
   * List of the resources of the configuration or data needed to onboard the machine to MDE
   */
  @pageItems
  value?: MdeOnboardingData[];
}

/**
 * Properties of the MDE configuration or data parameter needed to onboard the machine to MDE
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model MdeOnboardingDataProperties {
  /**
   * The onboarding package used to onboard Windows machines to MDE, coded in base64. This can also be used for onboarding using the dedicated VM Extension
   */
  onboardingPackageWindows?: bytes;

  /**
   * The onboarding package used to onboard Linux machines to MDE, coded in base64. This can also be used for onboarding using the dedicated VM Extension
   */
  onboardingPackageLinux?: bytes;
}

/**
 * Describes an Azure resource.
 */
