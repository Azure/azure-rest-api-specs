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
 * Premier add-on.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(Site)
@includeInapplicableMetadataInPayload(false)
model PremierAddOn extends Resource {
  /**
   * Add-on name.
   */
  @path
  @key("premierAddOnName")
  @segment("premieraddons")
  @visibility("read")
  name: string;

  /**
   * PremierAddOn resource specific properties
   */
  @extension("x-ms-client-flatten", true)
  properties?: PremierAddOnProperties;
}

@armResourceOperations
interface PremierAddOns {
  /**
   * Description for Gets a named add-on of an app.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WebApps_GetPremierAddOn")
  getPremierAddOn is ArmResourceRead<PremierAddOn>;

  /**
   * Description for Updates a named add-on of an app.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WebApps_AddPremierAddOn")
  addPremierAddOn is ArmResourceCreateOrReplaceSync<PremierAddOn>;

  /**
   * Description for Updates a named add-on of an app.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @parameterVisibility("read")
  @operationId("WebApps_UpdatePremierAddOn")
  updatePremierAddOn is ArmCustomPatchSync<
    PremierAddOn,
    PremierAddOnPatchResource
  >;

  /**
   * Description for Delete a premier add-on from an app.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("WebApps_DeletePremierAddOn")
  deletePremierAddOn is ArmResourceDeleteSync<PremierAddOn>;
}

@@projectedName(PremierAddOns.addPremierAddOn::parameters.resource,
  "json",
  "premierAddOn"
);
@@extension(PremierAddOns.addPremierAddOn::parameters.resource,
  "x-ms-client-name",
  "premierAddOn"
);
@@doc(PremierAddOns.addPremierAddOn::parameters.resource,
  "A JSON representation of the edited premier add-on."
);
@@projectedName(PremierAddOns.updatePremierAddOn::parameters.properties,
  "json",
  "premierAddOn"
);
@@extension(PremierAddOns.updatePremierAddOn::parameters.properties,
  "x-ms-client-name",
  "premierAddOn"
);
@@doc(PremierAddOns.updatePremierAddOn::parameters.properties,
  "A JSON representation of the edited premier add-on."
);
