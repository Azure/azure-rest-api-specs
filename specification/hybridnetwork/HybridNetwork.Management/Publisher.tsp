import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.HybridNetwork;
/**
 * publisher resource.
 */
model Publisher
  is Azure.ResourceManager.TrackedResource<PublisherPropertiesFormat> {
  ...ResourceNameParameter<
    Resource = Publisher,
    KeyName = "publisherName",
    SegmentName = "publishers",
    NamePattern = "^[a-zA-Z0-9][a-zA-Z0-9_-]*$"
  >;
  ...Azure.ResourceManager.ManagedServiceIdentityProperty;
}

@armResourceOperations
interface Publishers {
  /**
   * Gets information about the specified publisher.
   */
  get is ArmResourceRead<Publisher>;

  /**
   * Creates or updates a publisher.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi"
  #suppress "@azure-tools/typespec-azure-resource-manager/retry-after"
  @extension(
    "x-ms-long-running-operation-options",
    #{ `final-state-via`: "azure-async-operation" }
  )
  @extension("x-ms-long-running-operation", true)
  createOrUpdate is ArmResourceCreateOrReplaceSync<Publisher>;

  /**
   * Update a publisher resource.
   */
  @patch(#{ implicitOptionality: false })
  update is Azure.ResourceManager.Legacy.CustomPatchSync<
    Publisher,
    PatchModel = TagsObject,
    OptionalRequestBody = true
  >;

  /**
   * Deletes the specified publisher.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    Publisher,
    LroHeaders = ArmLroLocationHeader
  >;

  /**
   * Lists all the publishers in a resource group.
   */
  listByResourceGroup is ArmResourceListByParent<Publisher>;

  /**
   * Lists all the publishers in a subscription.
   */
  listBySubscription is ArmListBySubscription<Publisher>;
}

@@maxLength(Publisher.name, 64);
@@doc(Publisher.name, "The name of the publisher.");
@@doc(Publisher.properties, "Publisher properties.");
@@doc(Publishers.createOrUpdate::parameters.resource,
  "Parameters supplied to the create publisher operation."
);
@@doc(Publishers.update::parameters.properties,
  "Parameters supplied to the create publisher operation."
);
