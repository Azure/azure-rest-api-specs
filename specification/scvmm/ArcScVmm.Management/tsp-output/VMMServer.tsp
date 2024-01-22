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

namespace Microsoft.ScVmm;
/**
 * The VmmServers resource definition.
 */
model VMMServer is TrackedResource<VMMServerProperties> {
  /**
   * Name of the VMMServer.
   */
  @path
  @key("vmmServerName")
  @segment("vmmServers")
  name: string;

  /**
   * The extended location.
   */
  extendedLocation: ExtendedLocation;
}

@armResourceOperations
interface VMMServers {
  /**
   * Implements VMMServer GET method.
   */
  get is ArmResourceRead<VMMServer>;

  /**
   * Onboards the SCVMM fabric as an Azure VmmServer resource.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    VMMServer,
    BaseParameters<VMMServer>,
    ArmAsyncOperationHeader
  >;

  /**
   * Updates the VmmServers resource.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchAsync<
    VMMServer,
    ResourcePatch,
    BaseParameters<VMMServer>,
    ArmAsyncOperationHeader
  >;

  /**
   * Deboards the SCVMM fabric from Azure.
   */
  delete is ArmResourceDeleteAsync<
    VMMServer,
    {
      ...BaseParameters<VMMServer>;

      /**
       * Forces the resource to be deleted from azure. The corresponding CR would be attempted to be deleted too.
       */
      @query("force")
      force?: boolean;
    },
    ArmAsyncOperationHeader
  >;

  /**
   * List of VmmServers in a resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("VmmServers_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<VMMServer>;

  /**
   * List of VmmServers in a subscription.
   */
  listBySubscription is ArmListBySubscription<VMMServer>;
}

@@projectedName(VMMServers.createOrUpdate::parameters.resource, "json", "body");
@@extension(VMMServers.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "body"
);
@@doc(VMMServers.createOrUpdate::parameters.resource, "Request payload.");
@@projectedName(VMMServers.update::parameters.properties, "json", "body");
@@extension(VMMServers.update::parameters.properties,
  "x-ms-client-name",
  "body"
);
@@doc(VMMServers.update::parameters.properties, "VmmServers patch payload.");
