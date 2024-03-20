import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "@typespec/http";

using Azure.ClientGenerator.Core;
using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.OpenAPI;

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
alias ProviderAction<
  Request extends {} | void,
  Response extends {} | void,
  Parameters extends {} = {}
> = ArmResourceActionSync<
  {
    ...Azure.ResourceManager.Foundations.ArmResource;
  },
  Request,
  Response,
  Parameters = Parameters,
  BaseParameters = ApiVersionParameter
>;

@armResourceOperations
interface PortalTenant {
  @doc("compiles a file using inline content.")
  compileFile is ProviderAction<
    PortalTenantCompileFile,
    PortalTenantCompileFileResult
  >;
}

// @@clientName(PortalTenant.compileFile::parameters.body, "portalTenantCompileFile");
// @@encodedName(PortalTenant.compileFile::parameters.body,
//   "application/json",
//   "portalTenantCompileFile"
// );
// @@OpenAPI.extension(PortalTenant.compileFile::parameters.body,
//   "x-ms-client-name",
//   "portalTenantCompileFile"
// );
