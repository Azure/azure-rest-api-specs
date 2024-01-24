import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Volume.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.NetApp;
/**
 * Quota Rule of a Volume
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(Volume)
@Azure.ResourceManager.Private.armResourceInternal(VolumeQuotaRulesProperties)
@includeInapplicableMetadataInPayload(false)
model VolumeQuotaRule extends TrackedResourceBase {
  /**
   * The name of volume quota rule
   */
  @path
  @key("volumeQuotaRuleName")
  @segment("volumeQuotaRules")
  name: string;

  /**
   * Volume Quota Rule Properties
   */
  @extension("x-ms-client-flatten", true)
  properties?: VolumeQuotaRulesProperties;
}

@armResourceOperations
interface VolumeQuotaRules {
  /**
   * Get details of the specified quota rule
   */
  get is ArmResourceRead<VolumeQuotaRule>;

  /**
   * Create the specified quota rule within the given volume
   */
  create is ArmResourceCreateOrReplaceAsync<
    VolumeQuotaRule,
    BaseParameters<VolumeQuotaRule>,
    ArmLroLocationHeader
  >;

  /**
   * Patch a quota rule
   */
  @parameterVisibility("read")
  update is ArmCustomPatchAsync<
    VolumeQuotaRule,
    VolumeQuotaRulePatch,
    BaseParameters<VolumeQuotaRule>,
    ArmLroLocationHeader
  >;

  /**
   * Delete quota rule
   */
  delete is ArmResourceDeleteAsync<
    VolumeQuotaRule,
    BaseParameters<VolumeQuotaRule>,
    ArmLroLocationHeader
  >;

  /**
   * List all quota rules associated with the volume
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("VolumeQuotaRules_ListByVolume")
  listByVolume is ArmResourceListByParent<VolumeQuotaRule>;
}

@@projectedName(VolumeQuotaRules.create::parameters.resource, "json", "body");
@@extension(VolumeQuotaRules.create::parameters.resource,
  "x-ms-client-name",
  "body"
);
@@doc(VolumeQuotaRules.create::parameters.resource,
  "Quota rule object supplied in the body of the operation."
);
@@projectedName(VolumeQuotaRules.update::parameters.properties, "json", "body");
@@extension(VolumeQuotaRules.update::parameters.properties,
  "x-ms-client-name",
  "body"
);
@@doc(VolumeQuotaRules.update::parameters.properties,
  "Quota rule object supplied in the body of the operation."
);
