import "@azure-tools/typespec-client-generator-core";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ClientGenerator.Core;

namespace Microsoft.PortalServices;

@armResourceOperations
interface PortalTenant {
  @doc("Compiles a file using inline content.")
  @route("/providers/Microsoft.PortalServices/compilefile")
  compilefile(
    ...ApiVersionParameter,

    @doc("The parameters required to compile a file.")
    @body
    body: PortalTenantCompileFileProperties,
  ): ArmResponse<PortalTenantCompileFileResult> | ErrorResponse;
}

@@clientName(
  PortalTenant.compilefile::parameters.body,
  "portalTenantCompileFile"
);
#suppress "deprecated" "LEGACY - DO NOT COPY - FIX"
@@encodedName(
  PortalTenant.compilefile::parameters.body,
  "application/json",
  "portalTenantCompileFile"
);
