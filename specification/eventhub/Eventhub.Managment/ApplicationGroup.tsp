import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./EHNamespace.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.EventHub;
/**
 * The Application Group object
 */
@parentResource(EHNamespace)
model ApplicationGroup
  is Azure.ResourceManager.ProxyResource<ApplicationGroupProperties> {
  ...ResourceNameParameter<
    Resource = ApplicationGroup,
    KeyName = "applicationGroupName",
    SegmentName = "applicationGroups",
    NamePattern = ""
  >;

  /**
   * The geo-location where the resource lives
   */
  @visibility(Lifecycle.Read)
  location?: string;
}

@armResourceOperations
interface ApplicationGroups {
  /**
   * Gets an ApplicationGroup for a Namespace.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ApplicationGroup_Get")
  get is ArmResourceRead<ApplicationGroup>;

  /**
   * Creates or updates an ApplicationGroup for a Namespace.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("ApplicationGroup_CreateOrUpdateApplicationGroup")
  createOrUpdateApplicationGroup is ArmResourceCreateOrReplaceSync<
    ApplicationGroup,
    Response = ArmResourceUpdatedResponse<ApplicationGroup>
  >;

  /**
   * Deletes an ApplicationGroup for a Namespace.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ApplicationGroup_Delete")
  delete is ArmResourceDeleteSync<ApplicationGroup>;

  /**
   * Gets a list of application groups for a Namespace.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ApplicationGroup_ListByNamespace")
  listByNamespace is ArmResourceListByParent<ApplicationGroup>;
}

@@maxLength(ApplicationGroup.name, 256);
@@minLength(ApplicationGroup.name, 1);
@@doc(ApplicationGroup.name, "The Application Group name ");
@@doc(ApplicationGroup.properties, "");
@@doc(ApplicationGroups.createOrUpdateApplicationGroup::parameters.resource,
  "The ApplicationGroup."
);
