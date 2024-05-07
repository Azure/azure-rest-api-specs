import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";

import "../models/SiteModels.tsp";
import "./MobileNetwork.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.MobileNetwork;

@doc("Site resource. Must be created in the same location as its parent mobile network.")
@resource("sites")
@parentResource(MobileNetwork)
model Site is TrackedResource<SitePropertiesFormat> {
  @doc("The name of the mobile network site.")
  @maxLength(64)
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9_-]*$")
  @path
  @key("siteName")
  @segment("sites")
  @visibility("read")
  name: string;
}

@armResourceOperations
interface Sites {
  @doc("Gets information about the specified mobile network site.")
  get is ArmResourceRead<Site>;

  @doc("Creates or updates a mobile network site. Must be created in the same location as its parent mobile network.")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Site>;

  @doc("Updates site tags.")
  @parameterVisibility("read")
  updateTags is ArmCustomPatchSync<Site, TagsObject>;

  @doc("Deletes the specified mobile network site. This will also delete any network functions that are a part of this site.")
  delete is ArmResourceDeleteWithoutOkAsync<Site>;

  @doc("Lists all sites in the mobile network.")
  listByMobileNetwork is ArmResourceListByParent<Site>;

  @doc("Deletes a packet core under the specified mobile network site.")
  deletePacketCore is ArmResourceActionAsync<
    Site,
    SiteDeletePacketCore,
    AsyncOperationStatus
  >;
}

@@doc(Sites.createOrUpdate::parameters.resource,
  "Parameters supplied to the create or update mobile network site operation."
);
@@doc(Sites.updateTags::parameters.properties,
  "Parameters supplied to update network site tags."
);
@@doc(Sites.deletePacketCore::parameters.body,
  "Parameters supplied to delete a packet core under a site."
);
