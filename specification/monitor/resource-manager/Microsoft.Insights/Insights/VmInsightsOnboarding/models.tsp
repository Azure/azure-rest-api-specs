import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.Insights;

/**
 * The onboarding status for the resource. Note that, a higher level scope, e.g., resource group or subscription, is considered onboarded if at least one resource under it is onboarded.
 */
union OnboardingStatus {
  string,

  /**
   * onboarded
   */
  onboarded: "onboarded",

  /**
   * notOnboarded
   */
  notOnboarded: "notOnboarded",

  /**
   * unknown
   */
  `unknown`: "unknown",
}

/**
 * The status of VM Insights data from the resource. When reported as `present` the data array will contain information about the data containers to which data for the specified resource is being routed.
 */
union DataStatus {
  string,

  /**
   * present
   */
  present: "present",

  /**
   * notPresent
   */
  notPresent: "notPresent",
}

/**
 * Resource properties.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model VMInsightsOnboardingStatusProperties {
  /**
   * Azure Resource Manager identifier of the resource whose onboarding status is being represented.
   */
  resourceId: string;

  /**
   * The onboarding status for the resource. Note that, a higher level scope, e.g., resource group or subscription, is considered onboarded if at least one resource under it is onboarded.
   */
  onboardingStatus: OnboardingStatus;

  /**
   * The status of VM Insights data from the resource. When reported as `present` the data array will contain information about the data containers to which data for the specified resource is being routed.
   */
  dataStatus: DataStatus;

  /**
   * Containers that currently store VM Insights data for the specified resource.
   */
  @identifiers(#["/workspace/id"])
  data?: DataContainer[];
}

/**
 * Information about a container with data for a given resource.
 */
model DataContainer {
  /**
   * Log Analytics workspace information.
   */
  workspace: WorkspaceInfo;
}

/**
 * Information about a Log Analytics Workspace.
 */
model WorkspaceInfo {
  /**
   * Azure Resource Manager identifier of the Log Analytics Workspace.
   */
  id: string;

  /**
   * Location of the Log Analytics workspace.
   */
  location: string;

  /**
   * Resource properties.
   */
  properties: WorkspaceInfoProperties;
}

/**
 * Resource properties.
 */
model WorkspaceInfoProperties {
  /**
   * Log Analytics workspace identifier.
   */
  customerId: string;
}

/**
 * An azure resource object
 */
model ProxyResource {
  /**
   * Azure resource Id
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Azure resource name
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Azure resource type
   */
  @visibility(Lifecycle.Read)
  type?: string;
}

/**
 * An error response from the API.
 */
@error
model ResponseWithError {
  /**
   * Error information.
   */
  error: Error;
}

/**
 * Error details.
 */
model Error {
  /**
   * Error code identifying the specific error.
   */
  code: string;

  /**
   * Error message in the caller's locale.
   */
  message?: string;
}
