using Azure.Core;
using Azure.Core.Traits;
using TypeSpec.Rest;
using TypeSpec.Http;

namespace Microsoft.CodeTransparency;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@doc("General service endpoints")
interface ServiceConfiguration {
  @doc("Get service parameters")
  @route("/parameters")
  @get
  getParameters is Foundations.Operation<{}, ParametersResult, ServiceTraits>;

  @doc("Get the DID configuration file.")
  @route("/.well-known/did.json")
  @get
  getDidConfig is Foundations.Operation<{}, DidDocument, ServiceTraits>;

  @doc("Get CodeTransparency configuration information.")
  @route("/configuration")
  @get
  getCtsConfig is Foundations.Operation<{}, CtsConfiguration, ServiceTraits>;

  @doc("Get CodeTransparency version information.")
  @route("/version")
  @get
  getCtsVersion is Foundations.Operation<{}, VersionResult, ServiceTraits>;
}