// -----------------------------------------------------------------------
// <copyright file="encryptedTransportService.tsp" company="Microsoft Corporation">
// Copyright (c) Microsoft Corporation. All rights reserved.
// </copyright>
// -----------------------------------------------------------------------

import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

@armProviderNamespace
@service(#{ title: "Microsoft.EncryptedTransport" })
@versioned(Microsoft.EncryptedTransport.Versions)
@doc("Azure Encrypted Transport Management API")
namespace Microsoft.EncryptedTransport;

@doc("Azure Encrypted Transport Service versioning")
enum Versions {
  @doc("Azure Encrypted Transport 2024-09-01-preview version")
  @armCommonTypesVersion(CommonTypes.Versions.v6)
  @useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
  @useDependency(Azure.Core.Versions.v1_0_Preview_1)
  v2024_09_01_preview: "2024-09-01-preview",
}
