// -----------------------------------------------------------------------
// <copyright file="UpdateGroup.tsp" company="Microsoft Corporation">
// Copyright (c) Microsoft Corporation. All rights reserved.
// </copyright>
// -----------------------------------------------------------------------
import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

import "../common/base.tsp";
import "./AccessPointAccount.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using Azure.Core;

namespace Microsoft.AccessPoint;

@doc("An Access Point Update Group Resource")
@parentResource(AccessPointAccount)
model UpdateGroup is ProxyResource<UpdateGroupProperties> {
  @doc("The name of the Update Group")
  @key("updateGroupName")
  @segment("updateGroups")
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9-]{1,62}[a-zA-Z0-9]$")
  @path
  name: string;
}

@doc("Update Group Properties.")
model UpdateGroupProperties {
  @doc("The image modification name to associate.")
  imageMod: string;

  @doc("Additional details.")
  description?: string;

  @doc("The status of the last operation.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@armResourceOperations
interface UpdateGroupOperations {
  get is ArmResourceRead<UpdateGroup>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<UpdateGroup>;
  update is ArmResourcePatchSync<UpdateGroup, UpdateGroupProperties>;
  delete is ArmResourceDeleteWithoutOkAsync<UpdateGroup>;
  listByParent is ArmResourceListByParent<UpdateGroup>;
}
