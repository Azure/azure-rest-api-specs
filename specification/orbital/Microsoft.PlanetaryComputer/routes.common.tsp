import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.Core.Traits;

namespace Microsoft.PlanetaryComputer;

alias ServiceTraits = NoRepeatableRequests &
  NoConditionalRequests &
  NoClientRequestId;

alias StandardOperations = Azure.Core.ResourceOperations<ServiceTraits>;
