import "@azure-tools/typespec-client-generator-core";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ClientGenerator.Core;

namespace Microsoft.PortalServices;
/**
 * The portal tenant provider action.
 */
model PortalTenantCompileFile
  is TrackedResource<PortalTenantCompileFileProperties> {
  /**
   * The name of the portal tenant compile file.
   */
  @maxLength(64)
  @minLength(3)
  @pattern("^[a-zA-Z0-9]+$")
  @path
  @key("compilefile")
  @segment("compilefile")
  @visibility("read")
  name: string;
}

@armResourceOperations
interface PortalTenant {
  @doc("compiles a file using inline content.")
  @route("/providers/Microsoft.PortalServices/compilefile")
  compilefile(
    ...ApiVersionParameter,

    @doc("The parameters required to compile a file.")
    @body
    body: PortalTenantCompileFileProperties,
  ): ArmResponse<PortalTenantCompileFileResult> | ErrorResponse;
}

@@clientName(PortalTenant.compilefile::parameters.body,
  "portalTenantCompileFile"
);
#suppress "deprecated" "LEGACY - DO NOT COPY - FIX"
@@encodedName(PortalTenant.compilefile::parameters.body,
  "application/json",
  "portalTenantCompileFile"
);
