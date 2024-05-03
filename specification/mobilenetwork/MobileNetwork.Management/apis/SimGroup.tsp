import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";

import "../models/SimGroupModels.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.MobileNetwork;

@doc("SIM group resource.")
@resource("simGroups")
model SimGroup is TrackedResource<SimGroupPropertiesFormat> {
  @doc("The name of the SIM Group.")
  @maxLength(64)
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]*$")
  @path
  @key("simGroupName")
  @segment("simGroups")
  @visibility("read")
  name: string;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  @doc("The identity used to retrieve the encryption key from Azure key vault.")
  identity?: ManagedServiceIdentity;
}

@armResourceOperations
interface SimGroups {
  @doc("Gets information about the specified SIM group.")
  get is ArmResourceRead<SimGroup>;

  @doc("Creates or updates a SIM group.")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<SimGroup>;

  @doc("Patch SIM group resource.")
  @parameterVisibility("read")
  updateTags is ArmCustomPatchSync<SimGroup, IdentityAndTagsObject>;

  @doc("Deletes the specified SIM group.")
  delete is ArmResourceDeleteWithoutOkAsync<SimGroup>;

  @doc("Gets all the SIM groups in a resource group.")
  listByResourceGroup is ArmResourceListByParent<SimGroup>;

  @doc("Gets all the SIM groups in a subscription.")
  listBySubscription is ArmListBySubscription<SimGroup>;
}

@@doc(SimGroups.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update SIM group operation."
);
@@doc(SimGroups.updateTags::parameters.properties,
  "Parameters supplied to patch SIM group resource."
);
