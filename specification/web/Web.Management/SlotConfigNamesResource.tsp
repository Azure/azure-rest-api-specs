import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Site.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Web;
/**
 * Slot Config names azure resource.
 */
@singleton("slotConfigNames")
@parentResource(Site)
model SlotConfigNamesResource
  is Azure.ResourceManager.ProxyResource<SlotConfigNames> {
  ...ResourceNameParameter<
    Resource = SlotConfigNamesResource,
    KeyName = "config",
    SegmentName = "config",
    NamePattern = ""
  >;

  /**
   * Kind of resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  kind?: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
interface SlotConfigNamesResources {
  /**
   * Description for Gets the names of app settings and connection strings that stick to the slot (not swapped).
   */
  @summary("Gets the names of app settings and connection strings that stick to the slot (not swapped).")
  listSlotConfigurationNames is ArmResourceRead<
    SlotConfigNamesResource,
    Error = DefaultErrorResponse
  >;

  /**
   * Description for Updates the names of application settings and connection string that remain with the slot during swap operation.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Updates the names of application settings and connection string that remain with the slot during swap operation.")
  updateSlotConfigurationNames is ArmResourceCreateOrReplaceSync<
    SlotConfigNamesResource,
    Response = ArmResourceUpdatedResponse<SlotConfigNamesResource>,
    Error = DefaultErrorResponse
  >;
}

@@doc(SlotConfigNamesResource.name, "");
@@doc(SlotConfigNamesResource.properties, "Core resource properties");
@@doc(SlotConfigNamesResources.updateSlotConfigurationNames::parameters.resource,
  "Names of application settings and connection strings. See example."
);
