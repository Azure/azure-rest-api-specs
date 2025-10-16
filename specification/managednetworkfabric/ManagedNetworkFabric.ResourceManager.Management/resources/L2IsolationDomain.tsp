import "../models/common.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;

using TypeSpec.Http;

namespace Microsoft.ManagedNetworkFabric;
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" ""
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "Unsupported common type"
@doc("The L2 Isolation Domain resource definition.")
@Azure.ResourceManager.Private.armResourceInternal(L2IsolationDomainProperties)
@Http.Private.includeInapplicableMetadataInPayload(false)
model L2IsolationDomain
  extends Azure.ResourceManager.Foundations.TrackedResource {
  @doc("Name of the L2 Isolation Domain.")
  @pattern("^[a-zA-Z]{1}[a-zA-Z0-9-_]{2,127}$")
  @path
  @key("l2IsolationDomainName")
  @segment("l2IsolationDomains")
  @visibility(Lifecycle.Read)
  name: string;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Need custom inheritance"
  @doc("The L2IsolationDomain properties")
  properties: L2IsolationDomainProperties;
}

@armResourceOperations
interface L2IsolationDomains {
  @doc("Implements L2 Isolation Domain GET method.")
  get is ArmResourceRead<L2IsolationDomain>;

  @doc("Creates layer 2 network connectivity between compute nodes within a rack and across racks.The configuration is applied on the devices only after the isolation domain is enabled.")
  create is ArmResourceCreateOrReplaceAsync<L2IsolationDomain>;

  @doc("API to update certain properties of the L2 Isolation Domain resource.")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<L2IsolationDomain, L2IsolationDomainPatch>;

  @doc("Deletes layer 2 connectivity between compute nodes by managed by named L2 Isolation name.")
  delete is ArmResourceDeleteWithoutOkAsync<L2IsolationDomain>;

  @doc("Displays L2IsolationDomains list by resource group GET method.")
  listByResourceGroup is ArmResourceListByParent<L2IsolationDomain>;

  @doc("Displays L2IsolationDomains list by subscription GET method.")
  listBySubscription is ArmListBySubscription<L2IsolationDomain>;

  @doc("Enables isolation domain across the fabric or on specified racks.")
  updateAdministrativeState is ArmResourceActionAsync<
    L2IsolationDomain,
    UpdateAdministrativeState,
    CommonPostActionResponseForDeviceUpdate
  >;

  @doc("Validates the configuration of the resources.")
  validateConfiguration is ArmResourceActionAsync<
    L2IsolationDomain,
    void,
    ValidateConfigurationResponse
  >;

  @doc("Commits the configuration of the given resources.")
  commitConfiguration is ArmResourceActionAsync<
    L2IsolationDomain,
    void,
    CommonPostActionResponseForStateUpdate
  >;
}

@@doc(L2IsolationDomains.create::parameters.resource, "Request payload.");
@@doc(L2IsolationDomains.update::parameters.properties,
  "API to update certain properties of the L2 Isolation Domain resource.."
);
@@doc(L2IsolationDomains.updateAdministrativeState::parameters.body,
  "Request payload."
);
