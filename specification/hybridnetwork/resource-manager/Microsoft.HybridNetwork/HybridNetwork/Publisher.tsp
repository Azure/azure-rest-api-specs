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
  createOrUpdate is Azure.ResourceManager.Legacy.CreateOrUpdateAsync<
    Publisher,
    LroHeaders = ArmAsyncOperationHeader,
    OptionalRequestBody = true
  >;

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
    LroHeaders = ArmLroLocationHeader,
    Response = ArmAcceptedLroResponse<
      "Accepted. Sets provisioningState to 'Deleting' until the operation is completed. Returns an operation URI that can be queried to find the current state of the operation.",
      LroHeaders = ArmLroLocationHeader
    > | ArmNoContentResponse<"Request is successful. Resource does not exist.">
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
@@doc(Publisher.identity,
  "The managed identity of the publisher, if configured."
);
