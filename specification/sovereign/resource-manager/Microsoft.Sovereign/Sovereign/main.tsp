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

@added(Versions.Preview20261031)
@resource("sovereignViews")
@doc("The Sovereign View resource type.")
model SovereignViewResource
  is TrackedResource<SovereignViewResourceProperties> {
  @doc("The name of the Sovereign View resource.")
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
  @doc("Gets the Sovereign View resource.")
  get is ArmResourceRead<SovereignViewResource>;
  @doc("Creates the Sovereign View resource.")
  create is ArmResourceCreateOrReplaceAsync<SovereignViewResource>;
  @doc("Updates the Sovereign View resource.")
  update is ArmCustomPatchAsync<
    SovereignViewResource,
    SovereignViewResourcePatch
  >;
  @doc("Deletes the Sovereign View resource.")
  delete is ArmResourceDeleteWithoutOkAsync<SovereignViewResource>;
  @doc("Lists the Sovereign View resources within a resource group.")
  listByResourceGroup is ArmResourceListByParent<SovereignViewResource>;
  @doc("Lists the Sovereign View resources within a subscription.")
  listBySubscription is ArmListBySubscription<SovereignViewResource>;

  @action("complianceSummary")
  @doc("Gets the compliance summary for the Sovereign View resource.")
  @armResourceAction(SovereignViewResource)
  complianceSummary is ArmResourceActionSync<
    SovereignViewResource,
    void,
    SovereignViewComplianceSummaryResult
  >;

  @action("complianceDetails")
  @doc("Gets compliance details for the Sovereign View resource.")
  @armResourceAction(SovereignViewResource)
  complianceDetails is ArmResourceActionSync<
    SovereignViewResource,
    SovereignViewComplianceDetailsContent,
    SovereignViewComplianceDetailsResult
  >;

  @action("filterValues")
  @doc("Gets filter values for the Sovereign View resource.")
  @armResourceAction(SovereignViewResource)
  filterValues is ArmResourceActionSync<
    SovereignViewResource,
    SovereignViewFilterValuesContent,
    SovereignViewFilterValuesResult
  >;

  @action("operationalStatus")
  @doc("Gets the operational status for the Sovereign View resource.")
  @armResourceAction(SovereignViewResource)
  operationalStatus is ArmResourceActionSync<
    SovereignViewResource,
    SovereignViewOperationalStatusContent,
    SovereignViewOperationalStatusResult
  >;

  @action("complianceResourceDetails")
  @doc("Gets the compliance reasoning for given resource and dimension, including the reasoning for its linked and replica resources.")
  @armResourceAction(SovereignViewResource)
  complianceResourceDetails is ArmResourceActionSync<
    SovereignViewResource,
    SovereignViewComplianceResourceDetailsContent,
    SovereignViewComplianceResourceDetailsResult
  >;

  @action("Remediate")
  @doc("Remediates the Sovereign View resource for the given ARM resource IDs.")
  @armResourceAction(SovereignViewResource)
  remediate is ArmResourceActionAsync<
    SovereignViewResource,
    SovereignViewRemediateContent,
    SovereignViewRemediateResult
  >;

  @action("remediationResult")
  @doc("Fetches the result of a previously triggered remediation.")
  @armResourceAction(SovereignViewResource)
  remediationResult is ArmResourceActionSync<
    SovereignViewResource,
    SovereignViewRemediationResultContent,
    SovereignViewRemediationResult
  >;
}
