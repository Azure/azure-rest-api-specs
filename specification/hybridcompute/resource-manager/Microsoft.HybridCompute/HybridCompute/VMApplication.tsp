import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";
import "./Machine.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.HybridCompute;

/**
 * A VM application installed on a hybrid machine.
 */
@added(Versions.v2026_09_01)
@parentResource(Machine)
model VmApplication
  is Azure.ResourceManager.TrackedResource<VmApplicationProperties> {
  ...ResourceNameParameter<
    Resource = VmApplication,
    KeyName = "applicationName",
    SegmentName = "applications",
    NamePattern = "^[A-Za-z0-9](?:[A-Za-z0-9_.-]{0,78}[A-Za-z0-9_-])?$"
  >;
}

/**
 * Operations for managing VM applications on a hybrid machine.
 */
@added(Versions.v2026_09_01)
@armResourceOperations
interface VmApplications {
  /**
   * Gets a VM application.
   */
  get is ArmResourceRead<VmApplication>;

  /**
   * Gets the instance view of a VM application.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "The established ARM instance view pattern is a GET action."
  #suppress "@azure-tools/typespec-azure-resource-manager/use-operation-decorator" "The established ARM instance view pattern is a GET action."
  @get
  @action("instanceView")
  getInstanceView is ArmResourceActionSync<VmApplication, void, VmApplication>;

  /**
   * Creates or updates a VM application.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<VmApplication>;

  /**
   * Updates a VM application.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    VmApplication,
    PatchModel = VmApplicationUpdate
  >;

  /**
   * Deletes a VM application.
   */
  delete is ArmResourceDeleteWithoutOkAsync<VmApplication>;

  /**
   * Lists the VM applications installed on a hybrid machine.
   */
  list is ArmResourceListByParent<
    VmApplication,
    Parameters = {
      /**
       * The maximum number of results to return.
       */
      @query("$top")
      $top?: int32 = 100;

      /**
       * The continuation token for the next page of results.
       */
      @query("$skipToken")
      $skipToken?: string;
    },
    Response = VmApplicationsListResult
  >;
}

@@doc(
  VmApplication.name,
  "The name of the VM application. When creating the resource, this name must match the application name in the selected gallery reference."
);
@@doc(VmApplication.properties, "The VM application properties.");
@@doc(
  VmApplications.createOrUpdate::parameters.resource,
  "The VM application resource."
);
@@doc(
  VmApplications.update::parameters.properties,
  "The VM application update properties."
);
