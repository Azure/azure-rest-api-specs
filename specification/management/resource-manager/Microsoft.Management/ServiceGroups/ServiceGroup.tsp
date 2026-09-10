import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Microsoft.Management;
/**
 * The serviceGroup details.
 */
@tenantResource
model ServiceGroup
  is Azure.ResourceManager.ProxyResource<ServiceGroupProperties> {
  ...ResourceNameParameter<
    Resource = ServiceGroup,
    KeyName = "serviceGroupName",
    SegmentName = "serviceGroups",
    NamePattern = "^[a-zA-Z0-9\\-_().]{1,90}$"
  >;

  /**
   * The kind of the serviceGroup.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  kind?: string;

  /**
   * The serviceGroup tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "For backward compatibility"
  tags?: Record<string>;
}

@armResourceOperations
interface ServiceGroups {
  /**
   * Get the details of the serviceGroup
   */
  get is ArmResourceRead<
    ServiceGroup,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters
  >;

  /**
   * Create or Update a serviceGroup
   */
  @removed(Versions.v2026_08_01)
  @renamedFrom(Versions.v2026_08_01, "createOrUpdateServiceGroup")
  @sharedRoute
  createOrUpdateServiceGroupV1 is ArmResourceCreateOrReplaceAsync<
    ServiceGroup,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters
  >;

  /**
   * Create or Update a serviceGroup
   */
  @added(Versions.v2026_08_01)
  @sharedRoute
  @Azure.Core.useFinalStateVia("original-uri")
  createOrUpdateServiceGroup is ArmResourceCreateOrReplaceAsync<
    ServiceGroup,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters
  >;

  /**
   * Update a serviceGroup
   */
  @removed(Versions.v2026_08_01)
  @renamedFrom(Versions.v2026_08_01, "updateServiceGroup")
  @sharedRoute
  @patch(#{ implicitOptionality: false })
  updateServiceGroupV1 is ArmCustomPatchAsync<
    ServiceGroup,
    PatchModel = ServiceGroup,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters
  >;

  /**
   * Update a serviceGroup
   */
  @added(Versions.v2026_08_01)
  @sharedRoute
  @patch(#{ implicitOptionality: false })
  updateServiceGroup is ArmCustomPatchAsync<
    ServiceGroup,
    PatchModel = ServiceGroup,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters,
    LroHeaders = ArmCombinedLroHeaders<FinalResult = ServiceGroup> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Delete a ServiceGroup
   */
  @removed(Versions.v2026_08_01)
  @renamedFrom(Versions.v2026_08_01, "deleteServiceGroup")
  @sharedRoute
  deleteServiceGroupV1 is ArmResourceDeleteWithoutOkAsync<
    ServiceGroup,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters
  >;

  /**
   * Delete a ServiceGroup
   */
  @added(Versions.v2026_08_01)
  @sharedRoute
  deleteServiceGroup is ArmResourceDeleteWithoutOkAsync<
    ServiceGroup,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters,
    LroHeaders = ArmCombinedLroHeaders<FinalResult = void> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Get the details of the serviceGroup's ancestors
   */
  @removed(Versions.v2026_08_01)
  listAncestors is ArmResourceActionSync<
    ServiceGroup,
    void,
    ArmResponse<ServiceGroupCollectionResponse>,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters
  >;
}

@added(Versions.v2026_08_01)
interface Operations extends Azure.ResourceManager.Operations {}

@@doc(
  Operations.list,
  "Lists all available REST API operations for the Microsoft.Management resource provider."
);

@@doc(ServiceGroup.name, "ServiceGroup Name.");
@@doc(
  ServiceGroup.properties,
  "ServiceGroup creation request body parameters."
);
@@doc(
  ServiceGroups.createOrUpdateServiceGroup::parameters.resource,
  "ServiceGroup creation parameters"
);
@@doc(
  ServiceGroups.createOrUpdateServiceGroupV1::parameters.resource,
  "ServiceGroup creation parameters"
);
@@doc(
  ServiceGroups.updateServiceGroup::parameters.properties,
  "ServiceGroup update parameters"
);
@@doc(
  ServiceGroups.updateServiceGroupV1::parameters.properties,
  "ServiceGroup update parameters"
);
