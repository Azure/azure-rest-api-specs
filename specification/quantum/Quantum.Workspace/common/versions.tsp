// --------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// --------------------------------------------------------------------------------------------

import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Versioning;

@doc("The Azure Quantum Workspace REST API version.")
enum QuantumWorkspaceAPIVersion {
  @doc("2019-11-04-preview")
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  `2019-11-04-preview`,

  @doc("2021-05-06-preview")
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  `2021-05-06-preview`,

  @doc("2021-11-01-preview")
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  `2021-11-01-preview`,

  @doc("2022-09-12-preview")
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  `2022-09-12-preview`,

  @doc("2023-11-13-preview")
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  `2023-11-13-preview`,

  @doc("2024-03-01-preview")
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  `2024-03-01-preview`,
}
