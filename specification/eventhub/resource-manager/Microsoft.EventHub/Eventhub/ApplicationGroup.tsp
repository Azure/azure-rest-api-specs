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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  location?: string;
}

@armResourceOperations
interface ApplicationGroups {
  /**
   * Gets an ApplicationGroup for a Namespace.
   */
  get is ArmResourceRead<ApplicationGroup, Error = ErrorResponse>;

  /**
   * Creates or updates an ApplicationGroup for a Namespace.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  createOrUpdateApplicationGroup is ArmResourceCreateOrReplaceSync<
    ApplicationGroup,
    Response = ArmResourceUpdatedResponse<ApplicationGroup>,
    Error = ErrorResponse
  >;

  /**
   * Deletes an ApplicationGroup for a Namespace.
   */
  delete is ArmResourceDeleteSync<ApplicationGroup, Error = ErrorResponse>;

  /**
   * Gets a list of application groups for a Namespace.
   */
  listByNamespace is ArmResourceListByParent<
    ApplicationGroup,
    Error = ErrorResponse
  >;
}

@@maxLength(ApplicationGroup.name, 256);
@@minLength(ApplicationGroup.name, 1);
@@doc(ApplicationGroup.name, "The Application Group name ");
@@doc(ApplicationGroup.properties, "");
@@doc(ApplicationGroups.createOrUpdateApplicationGroup::parameters.resource,
  "The ApplicationGroup."
);
