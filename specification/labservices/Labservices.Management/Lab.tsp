import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.LabServices;
/**
 * The lab resource.
 */
model Lab is Azure.ResourceManager.TrackedResource<LabProperties, false> {
  ...ResourceNameParameter<
    Resource = Lab,
    KeyName = "labName",
    SegmentName = "labs",
    NamePattern = ""
  >;
}

@armResourceOperations
interface Labs {
  /**
   * Returns the properties of a lab resource.
   */
  get is ArmResourceRead<Lab>;

  /**
   * Operation to create or update a lab resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    Lab,
    Response = ArmResourceUpdatedResponse<Lab> | ArmResourceCreatedResponse<Lab> | (ArmAcceptedLroResponse & {
      @bodyRoot
      _: Lab;
    })
  >;

  /**
   * Operation to update a lab resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    Lab,
    PatchModel = LabUpdate,
    Response = ArmResponse<Lab> | (ArmAcceptedLroResponse & {
      @bodyRoot
      _: Lab;
    })
  >;

  /**
   * Operation to delete a lab resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    Lab,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Returns a list of all labs in a resource group.
   */
  listByResourceGroup is ArmResourceListByParent<
    Lab,
    Response = ArmResponse<PagedLabs>
  >;

  /**
   * Returns a list of all labs for a subscription.
   */
  listBySubscription is ArmListBySubscription<
    Lab,
    Parameters = {
      /**
       * The filter to apply to the operation.
       */
      @query("$filter")
      $filter?: string;
    },
    Response = ArmResponse<PagedLabs>
  >;

  /**
   * Publish or re-publish a lab. This will create or update all lab resources, such as virtual machines.
   */
  publish is ArmResourceActionAsync<Lab, void, OkResponse>;

  /**
   * Action used to manually kick off an AAD group sync job.
   */
  syncGroup is ArmResourceActionAsync<Lab, void, OkResponse>;
}

@@maxLength(Lab.name, 100);
@@minLength(Lab.name, 1);
@@doc(Lab.name,
  "The name of the lab that uniquely identifies it within containing lab plan. Used in resource URIs."
);
@@doc(Lab.properties, "Lab resource properties");
@@doc(Labs.createOrUpdate::parameters.resource, "The request body.");
@@doc(Labs.update::parameters.properties, "The request body.");
