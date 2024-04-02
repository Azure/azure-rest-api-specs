import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";

import "../models/SimPolicyModels.tsp";
import "./MobileNetwork.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.MobileNetwork;

@doc("SIM policy resource.")
@resource("simPolicies")
@parentResource(MobileNetwork)
model SimPolicy is TrackedResource<SimPolicyPropertiesFormat> {
  @doc("The name of the SIM policy.")
  @maxLength(64)
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]*$")
  @path
  @key("simPolicyName")
  @segment("simPolicies")
  @visibility("read")
  name: string;
}

@armResourceOperations
interface SimPolicies {
  @doc("Gets information about the specified SIM policy.")
  get is ArmResourceRead<SimPolicy>;

  @doc("Creates or updates a SIM policy. Must be created in the same location as its parent mobile network.")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<SimPolicy>;

  @doc("Updates SIM policy tags.")
  @parameterVisibility("read")
  updateTags is ArmCustomPatchSync<SimPolicy, TagsObject>;

  @doc("Deletes the specified SIM policy.")
  delete is ArmResourceDeleteWithoutOkAsync<SimPolicy>;

  @doc("Gets all the SIM policies in a mobile network.")
  listByMobileNetwork is ArmResourceListByParent<SimPolicy>;
}

@@doc(SimPolicies.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update SIM policy operation."
);
@@doc(SimPolicies.updateTags::parameters.properties,
  "Parameters supplied to update SIM policy tags."
);
