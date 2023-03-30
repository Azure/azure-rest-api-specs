import "@typespec/rest";
import "@azure-tools/typespec-azure-core";
import "../../models/common.tsp";
import "../../models/configuration.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.Core;
using Azure.Core.Traits;
using DeveloperServicesApi.Models;

namespace DeveloperServicesPublicApi.Routes.Configuration;

@doc("API configuration content resource model.")
@resource("configuration")
model ConfigurationContentResource extends ContentSettings {
  @doc("Configuration content identifier.")
  @key("id")
  @visibility("query")
  id: "content";
}

@doc("API configuration signup resource model.")
@resource("configuration")
model ConfigurationSignupResource extends SignupConfiguration {
  @doc("Configuration signup identifier.")
  @key("id")
  @visibility("query")
  id: "signup";
}

interface Configurations {
  @doc("Get content settings.")
  getContentSettings is ResourceRead<ConfigurationContentResource>;

  @doc("Get signup settings.")
  getSignupSettings is ResourceRead<ConfigurationSignupResource>;
}
