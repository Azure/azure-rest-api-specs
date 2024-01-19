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
@doc("Premier add-on.")
@parentResource(Site)
model PremierAddOn is TrackedResource<PremierAddOnProperties> {
  @doc("Add-on name.")
  @path
  @key("premierAddOnName")
  @segment("premieraddons")
  name: string;
}

@armResourceOperations
interface PremierAddOns {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Description for Gets a named add-on of an app.")
  @operationId("WebApps_GetPremierAddOn")
  getPremierAddOn is ArmResourceRead<PremierAddOn>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Description for Updates a named add-on of an app.")
  @operationId("WebApps_AddPremierAddOn")
  addPremierAddOn is ArmResourceCreateOrReplaceSync<PremierAddOn>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Description for Updates a named add-on of an app.")
  @operationId("WebApps_UpdatePremierAddOn")
  updatePremierAddOn is ArmCustomPatchSync<
    PremierAddOn,
    PremierAddOnPatchResource
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Description for Delete a premier add-on from an app.")
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
