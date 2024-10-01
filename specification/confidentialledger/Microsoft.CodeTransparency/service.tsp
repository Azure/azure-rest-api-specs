using Azure.Core;
using Azure.Core.Traits;
using TypeSpec.Rest;
using TypeSpec.Http;

namespace Microsoft.CodeTransparency;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@doc("Get service parameters")
@route("/parameters")
@get
op getParameters is Foundations.Operation<{}, ParametersResult, ServiceTraits>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@doc("Get the DID configuration file.")
@route("/.well-known/did.json")
@get
op getDidConfig is Foundations.Operation<{}, DidDocument, ServiceTraits>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@doc("Get CodeTransparency configuration information.")
@route("/configuration")
@get
op getCodeTransparencyConfig is Foundations.Operation<
  {},
  CodeTransparencyConfiguration,
  ServiceTraits
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations"
@doc("Get CodeTransparency version information.")
@route("/version")
@get
op getCodeTransparencyVersion is Foundations.Operation<
  {},
  VersionResult,
  ServiceTraits
>;
