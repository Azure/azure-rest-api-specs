import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AVS;
@doc("A private cloud resource")
model PrivateCloud is TrackedResource<PrivateCloudProperties> {
  @doc("Name of the private cloud")
  @path
  @key("privateCloudName")
  @segment("privateClouds")
  name: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
  ...Azure.ResourceManager.ResourceSku;
}

@armResourceOperations
interface PrivateClouds {
  @doc("Get a private cloud")
  get is ArmResourceRead<PrivateCloud>;

  @doc("Create or update a private cloud")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<PrivateCloud>;

  @doc("Update a private cloud")
  update is ArmCustomPatchAsync<PrivateCloud, PrivateCloudUpdate>;

  @doc("Delete a private cloud")
  delete is ArmResourceDeleteAsync<PrivateCloud>;

  @doc("List private clouds in a resource group")
  list is ArmResourceListByParent<PrivateCloud>;

  @doc("List private clouds in a subscription")
  listInSubscription is ArmListBySubscription<PrivateCloud>;

  @doc("Rotate the vCenter password")
  rotateVcenterPassword is ArmResourceActionNoResponseContentAsync<
    PrivateCloud,
    void
  >;

  @doc("Rotate the NSX-T Manager password")
  rotateNsxtPassword is ArmResourceActionNoResponseContentAsync<
    PrivateCloud,
    void
  >;

  @doc("List the admin credentials for the private cloud")
  listAdminCredentials is ArmResourceActionSync<
    PrivateCloud,
    void,
    AdminCredentials
  >;
}

@@projectedName(PrivateClouds.createOrUpdate::parameters.resource,
  "json",
  "privateCloud"
);
@@extension(PrivateClouds.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "privateCloud"
);
@@doc(PrivateClouds.createOrUpdate::parameters.resource, "The private cloud");
@@projectedName(PrivateClouds.update::parameters.properties,
  "json",
  "privateCloudUpdate"
);
@@extension(PrivateClouds.update::parameters.properties,
  "x-ms-client-name",
  "privateCloudUpdate"
);
@@doc(PrivateClouds.update::parameters.properties,
  "The private cloud properties to be updated"
);
