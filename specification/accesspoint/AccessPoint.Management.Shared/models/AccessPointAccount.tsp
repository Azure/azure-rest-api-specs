// -----------------------------------------------------------------------
// <copyright file="AccessPointAccount.tsp" company="Microsoft Corporation">
// Copyright (c) Microsoft Corporation. All rights reserved.
// </copyright>
// -----------------------------------------------------------------------
import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

import "../common/base.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using Azure.Core;

namespace Microsoft.AccessPoint;

@doc("An Access Point Account Resource")
model AccessPointAccount is TrackedResource<AccessPointAccountProperties> {
  @doc("The name of the Access Point")
  @key("accessPointAccountName")
  @segment("accessPointAccounts")
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9-]{1,62}[a-zA-Z0-9]$")
  @path
  name: string;
}

@doc("Access Point Account Properties.")
model AccessPointAccountProperties {
  @doc("The image modification for the access point account")
  imageMod: string;

  @doc("The classification of the access point account")
  classification: string;

  @doc("The status of the last operation.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@armResourceOperations
interface AccessPointOperations {
  get is ArmResourceRead<AccessPointAccount>;
  createOrUpdate is ArmResourceCreateOrUpdateAsync<AccessPointAccount>;
  update is ArmTagsPatchSync<AccessPointAccount>;
  delete is ArmResourceDeleteWithoutOkAsync<AccessPointAccount>;
  listByResourceGroup is ArmResourceListByParent<AccessPointAccount>;
  listBySubscription is ArmListBySubscription<AccessPointAccount>;
}
