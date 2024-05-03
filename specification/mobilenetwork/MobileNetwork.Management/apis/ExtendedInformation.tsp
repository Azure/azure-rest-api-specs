import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";

import "../models/ExtendedInformationModels.tsp";
import "./Ues.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.MobileNetwork;

@doc("Extended User Equipment (UE) information.")
@resource("extendedInformation")
@singleton("default")
@parentResource(UeInfo)
model ExtendedUeInfo is ProxyResource<ExtendedUeInfoProperties> {
  @doc("The name of the extended UE info.")
  @pattern(".*")
  @path
  @key("extendedInformation")
  @segment("extendedInformation")
  @visibility("read")
  name: string;
}

@armResourceOperations
interface ExtendedUeInfos {
  @doc("Gets extended information about the specified UE from the packet core.")
  get is ArmResourceRead<ExtendedUeInfo>;
}
