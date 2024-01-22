import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Site.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.CertificateRegistration;
/**
 * Slot Config names azure resource.
 */
@singleton("slotConfigNames")
@parentResource(Site)
model SlotConfigNamesResource is ProxyResource<SlotConfigNames> {
  @key("config")
  @segment("config")
  name: string;
}

@armResourceOperations
interface SlotConfigNamesResources {
  /**
   * Description for Gets the names of app settings and connection strings that stick to the slot (not swapped).
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WebApps_ListSlotConfigurationNames")
  listSlotConfigurationNames is ArmResourceRead<SlotConfigNamesResource>;

  /**
   * Description for Updates the names of application settings and connection string that remain with the slot during swap operation.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WebApps_UpdateSlotConfigurationNames")
  updateSlotConfigurationNames is ArmResourceCreateOrReplaceSync<SlotConfigNamesResource>;

  /**
   * Description for List the configurations of an app
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WebApps_ListConfigurations")
  listConfigurations is ArmResourceListByParent<SlotConfigNamesResource>;
}

@@projectedName(SlotConfigNamesResources.updateSlotConfigurationNames::parameters.resource,
  "json",
  "slotConfigNames"
);
@@extension(SlotConfigNamesResources.updateSlotConfigurationNames::parameters.resource,
  "x-ms-client-name",
  "slotConfigNames"
);
@@doc(SlotConfigNamesResources.updateSlotConfigurationNames::parameters.resource,
  "Names of application settings and connection strings. See example."
);
