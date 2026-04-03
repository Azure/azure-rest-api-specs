import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

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
  createOrUpdateServiceGroup is ArmResourceCreateOrReplaceAsync<
    ServiceGroup,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters
  >;

  /**
   * Update a serviceGroup
   */
  @patch(#{ implicitOptionality: false })
  updateServiceGroup is ArmCustomPatchAsync<
    ServiceGroup,
    PatchModel = ServiceGroup,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters
  >;

  /**
   * Delete a ServiceGroup
   */
  deleteServiceGroup is ArmResourceDeleteWithoutOkAsync<
    ServiceGroup,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters
  >;

  /**
   * Get the details of the serviceGroup's ancestors
   */
  listAncestors is ArmResourceActionSync<
    ServiceGroup,
    void,
    ArmResponse<ServiceGroupCollectionResponse>,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters
  >;
}

@@doc(ServiceGroup.name, "ServiceGroup Name.");
@@doc(ServiceGroup.properties,
  "ServiceGroup creation request body parameters."
);
@@doc(ServiceGroups.createOrUpdateServiceGroup::parameters.resource,
  "ServiceGroup creation parameters"
);
@@doc(ServiceGroups.updateServiceGroup::parameters.properties,
  "ServiceGroup update parameters"
);
