// -----------------------------------------------------------------------
// <copyright file="service.tsp" company="Microsoft Corporation">
// Copyright (c) Microsoft Corporation. All rights reserved.
// </copyright>
// -----------------------------------------------------------------------

import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using OpenAPI;

@armProviderNamespace("Microsoft.StandbyPool")
@service({
  title: "Microsoft.StandbyPool",
})
@versioned(Microsoft.StandbyPool.Versions)
namespace Microsoft.StandbyPool;

@doc("Supported API Versions for Microsoft.StandbyPool")
enum Versions {
  @doc("API Version 2023-12-01-preview.")
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
  `2023-12-01-preview`,
}

interface Operations extends Azure.ResourceManager.Operations {}

@doc("Provisioning state")
@lroStatus
union ProvisioningState {
  string,
  ResourceProvisioningState,

  @doc("Resource is being deleted.")
  Deleting: "Deleting",
}
