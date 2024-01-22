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

namespace Microsoft.LabServices;
/**
 * The lab resource.
 */
model Lab is TrackedResource<LabProperties> {
  /**
   * The name of the lab that uniquely identifies it within containing lab plan. Used in resource URIs.
   */
  @maxLength(100)
  @minLength(1)
  @path
  @key("labName")
  @segment("labs")
  name: string;
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
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Lab>;

  /**
   * Operation to update a lab resource.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchAsync<
    Lab,
    LabUpdate,
    BaseParameters<Lab>,
    ArmLroLocationHeader
  >;

  /**
   * Operation to delete a lab resource.
   */
  delete is ArmResourceDeleteAsync<
    Lab,
    BaseParameters<Lab>,
    ArmLroLocationHeader
  >;

  /**
   * Returns a list of all labs in a resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Labs_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<Lab>;

  /**
   * Returns a list of all labs for a subscription.
   */
  listBySubscription is ArmListBySubscription<Lab>;

  /**
   * Publish or re-publish a lab. This will create or update all lab resources, such as virtual machines.
   */
  publish is ArmResourceActionAsync<
    Lab,
    void,
    void,
    BaseParameters<Lab>,
    ArmLroLocationHeader
  >;

  /**
   * Action used to manually kick off an AAD group sync job.
   */
  syncGroup is ArmResourceActionAsync<
    Lab,
    void,
    void,
    BaseParameters<Lab>,
    ArmLroLocationHeader
  >;
}

@@projectedName(Labs.createOrUpdate::parameters.resource, "json", "body");
@@extension(Labs.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "body"
);
@@doc(Labs.createOrUpdate::parameters.resource, "The request body.");
@@projectedName(Labs.update::parameters.properties, "json", "body");
@@extension(Labs.update::parameters.properties, "x-ms-client-name", "body");
@@doc(Labs.update::parameters.properties, "The request body.");
