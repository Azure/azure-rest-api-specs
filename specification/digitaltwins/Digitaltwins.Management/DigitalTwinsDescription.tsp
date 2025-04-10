import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DigitalTwins;
/**
 * The description of the DigitalTwins service.
 */
model DigitalTwinsDescription
  is Azure.ResourceManager.TrackedResource<DigitalTwinsProperties> {
  ...ResourceNameParameter<
    Resource = DigitalTwinsDescription,
    KeyName = "resourceName",
    SegmentName = "digitalTwinsInstances",
    NamePattern = "^(?!-)[A-Za-z0-9-]{3,63}(?<!-)$"
  >;
}

@armResourceOperations
interface DigitalTwinsDescriptions {
  /**
   * Get DigitalTwinsInstances resource.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("DigitalTwins_Get")
  get is ArmResourceRead<DigitalTwinsDescription>;

  /**
   * Create or update the metadata of a DigitalTwinsInstance. The usual pattern to modify a property is to retrieve the DigitalTwinsInstance and security metadata, and then combine them with the modified values in a new body to update the DigitalTwinsInstance.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("DigitalTwins_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    DigitalTwinsDescription,
    LroHeaders = ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Update metadata of DigitalTwinsInstance.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  @patch(#{ implicitOptionality: false })
  @operationId("DigitalTwins_Update")
  update is ArmCustomPatchAsync<
    DigitalTwinsDescription,
    PatchModel = DigitalTwinsPatchDescription,
    Response = ArmResponse<DigitalTwinsDescription> | (ArmAcceptedLroResponse & {
      @bodyRoot
      _: DigitalTwinsDescription;
    })
  >;

  /**
   * Delete a DigitalTwinsInstance.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  @operationId("DigitalTwins_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    DigitalTwinsDescription,
    Response = ArmResponse<DigitalTwinsDescription> | (ArmDeleteAcceptedLroResponse & {
      @bodyRoot
      _: DigitalTwinsDescription;
    }) | ArmDeletedNoContentResponse
  >;

  /**
   * Get all the DigitalTwinsInstances in a resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("DigitalTwins_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<DigitalTwinsDescription>;

  /**
   * Get all the DigitalTwinsInstances in a subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("DigitalTwins_List")
  list is ArmListBySubscription<DigitalTwinsDescription>;
}

@@maxLength(DigitalTwinsDescription.name, 63);
@@minLength(DigitalTwinsDescription.name, 3);
@@doc(DigitalTwinsDescription.name, "The name of the DigitalTwinsInstance.");
@@doc(DigitalTwinsDescription.properties, "DigitalTwins instance properties.");
@@doc(DigitalTwinsDescriptions.createOrUpdate::parameters.resource,
  "The DigitalTwinsInstance and security metadata."
);
@@doc(DigitalTwinsDescriptions.update::parameters.properties,
  "The DigitalTwinsInstance and security metadata."
);
