import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./MobileNetwork.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.MobileNetwork;
@doc("SIM policy resource.")
@parentResource(MobileNetwork)
model SimPolicy is TrackedResource<SimPolicyPropertiesFormat> {
  @doc("The name of the SIM policy.")
  @maxLength(64)
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]*$")
  @path
  @key("simPolicyName")
  @segment("simPolicies")
  name: string;
}

@armResourceOperations
interface SimPolicies {
  @doc("Gets information about the specified SIM policy.")
  get is ArmResourceRead<SimPolicy>;

  @doc("Creates or updates a SIM policy. Must be created in the same location as its parent mobile network.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    SimPolicy,
    BaseParameters<SimPolicy>,
    ArmAsyncOperationHeader
  >;

  @doc("Updates SIM policy tags.")
  updateTags is ArmCustomPatchSync<SimPolicy, TagsObject>;

  @doc("Deletes the specified SIM policy.")
  delete is ArmResourceDeleteAsync<
    SimPolicy,
    BaseParameters<SimPolicy>,
    ArmLroLocationHeader
  >;

  @doc("Gets all the SIM policies in a mobile network.")
  listByMobileNetwork is ArmResourceListByParent<SimPolicy>;
}

@@projectedName(SimPolicies.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(SimPolicies.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(SimPolicies.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update SIM policy operation."
);
@@projectedName(SimPolicies.updateTags::parameters.properties,
  "json",
  "parameters"
);
@@extension(SimPolicies.updateTags::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(SimPolicies.updateTags::parameters.properties,
  "Parameters supplied to update SIM policy tags."
);
