import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-resource-manager";

import "./common.tsp";
import "./sovereignViewResourceProperties.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using Azure.Core;
using OpenAPI;

@service(#{ title: "Cloud for Sovereignty Resource Provider." })
@versioned(Versions)
@armProviderNamespace
@armCommonTypesVersion("v5")
namespace Microsoft.Sovereign;

interface Operations extends Azure.ResourceManager.Operations {
  @added(Versions.Preview20261031)
  checkNameAvailability is checkGlobalNameAvailability;

  @added(Versions.Preview20261031)
  checkNameAvailabilityLocal is checkLocalNameAvailability;
}

/** The Sovereign View resource type. */
@added(Versions.Preview20261031)
@resource("sovereignViews")
model SovereignViewResource
  is TrackedResource<SovereignViewResourceProperties> {
  /** The name of the Sovereign View resource. */
  @segment("sovereignViews")
  @key("sovereignViewName")
  @pattern("^[a-zA-Z0-9-]{3,64}$")
  @visibility(Lifecycle.Read)
  @path
  name: string;

  ...ManagedSystemAssignedIdentityProperty;
}

@added(Versions.Preview20261031)
@armResourceOperations(SovereignViewResource)
interface SovereignViewOperations {
  /** Gets the Sovereign View resource. */
  get is ArmResourceRead<SovereignViewResource>;
  /** Creates or updates the Sovereign View resource. */
  create is ArmResourceCreateOrReplaceAsync<SovereignViewResource>;
  /** Updates the Sovereign View resource. */
  update is ArmCustomPatchAsync<
    SovereignViewResource,
    SovereignViewResourcePatch
  >;
  /** Deletes the Sovereign View resource. */
  delete is ArmResourceDeleteWithoutOkAsync<SovereignViewResource>;
  /** Lists the Sovereign View resources within a resource group. */
  listByResourceGroup is ArmResourceListByParent<SovereignViewResource>;
  /** Lists the Sovereign View resources within a subscription. */
  listBySubscription is ArmListBySubscription<SovereignViewResource>;

  /** Gets the compliance summary for the Sovereign View resource. */
  @action("complianceSummary")
  @armResourceAction(SovereignViewResource)
  complianceSummary is ArmResourceActionSync<
    SovereignViewResource,
    void,
    SovereignViewComplianceSummaryResult
  >;

  /** Gets compliance details for the Sovereign View resource. */
  @action("complianceDetails")
  @armResourceAction(SovereignViewResource)
  complianceDetails is ArmResourceActionSync<
    SovereignViewResource,
    SovereignViewComplianceDetailsContent,
    SovereignViewComplianceDetailsResult
  >;

  /** Gets filter values for the Sovereign View resource. */
  @action("filterValues")
  @armResourceAction(SovereignViewResource)
  filterValues is ArmResourceActionSync<
    SovereignViewResource,
    SovereignViewFilterValuesContent,
    SovereignViewFilterValuesResult
  >;

  /** Gets the operational status for the Sovereign View resource. */
  @action("operationalStatus")
  @armResourceAction(SovereignViewResource)
  operationalStatus is ArmResourceActionSync<
    SovereignViewResource,
    SovereignViewOperationalStatusContent,
    SovereignViewOperationalStatusResult
  >;

  /** Gets the compliance reasoning for given resource and dimension, including the reasoning for its linked and replica resources. */
  @action("complianceResourceDetails")
  @armResourceAction(SovereignViewResource)
  complianceResourceDetails is ArmResourceActionSync<
    SovereignViewResource,
    SovereignViewComplianceResourceDetailsContent,
    SovereignViewComplianceResourceDetailsResult
  >;

  /** Remediates the Sovereign View resource for the given Azure Resource Manager resource IDs. */
  @action("Remediate")
  @armResourceAction(SovereignViewResource)
  remediate is ArmResourceActionAsync<
    SovereignViewResource,
    SovereignViewRemediateContent,
    SovereignViewRemediateResult
  >;

  /** Fetches the result of a previously triggered remediation. */
  @action("remediationResult")
  @armResourceAction(SovereignViewResource)
  remediationResult is ArmResourceActionSync<
    SovereignViewResource,
    SovereignViewRemediationResultContent,
    SovereignViewRemediationResult
  >;
}
