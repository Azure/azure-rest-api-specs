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

namespace Microsoft.Orbital;
@doc("Customer creates a Contact Profile Resource, which will contain all of the configurations required for scheduling a contact.")
model ContactProfile is TrackedResource<ContactProfileProperties> {
  @doc("Contact Profile name.")
  @path
  @key("contactProfileName")
  @segment("contactProfiles")
  name: string;

  @doc("A unique read-only string that changes whenever the resource is updated.")
  @visibility("read")
  etag?: string;
}

@armResourceOperations
interface ContactProfiles {
  @doc("Gets the specified contact Profile in a specified resource group.")
  get is ArmResourceRead<ContactProfile>;

  @doc("Creates or updates a contact profile.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    ContactProfile,
    BaseParameters<ContactProfile>,
    ArmAsyncOperationHeader
  >;

  @doc("Updates the specified contact profile tags.")
  updateTags is ArmCustomPatchAsync<
    ContactProfile,
    TagsObject,
    BaseParameters<ContactProfile>,
    ArmLroLocationHeader
  >;

  @doc("Deletes a specified contact profile resource.")
  delete is ArmResourceDeleteAsync<
    ContactProfile,
    BaseParameters<ContactProfile>,
    ArmLroLocationHeader
  >;

  @doc("Returns list of contact profiles by Resource Group.")
  list is ArmResourceListByParent<
    ContactProfile,
    {
      ...BaseParameters<ContactProfile>;

      @doc("An opaque string that the resource provider uses to skip over previously-returned results. This is used when a previous list operation call returned a partial result. If a previous response contains a nextLink element, the value of the nextLink element will include a skiptoken parameter that specifies a starting point to use for subsequent calls.")
      @query("$skiptoken")
      $skiptoken?: string;
    }
  >;

  @doc("Returns list of contact profiles by Subscription.")
  listBySubscription is ArmListBySubscription<ContactProfile>;
}

@@projectedName(ContactProfiles.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(ContactProfiles.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(ContactProfiles.createOrUpdate::parameters.resource,
  "The parameters to provide for the created Contact Profile."
);
@@projectedName(ContactProfiles.updateTags::parameters.properties,
  "json",
  "parameters"
);
@@extension(ContactProfiles.updateTags::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(ContactProfiles.updateTags::parameters.properties,
  "Parameters supplied to update contact profile tags."
);
