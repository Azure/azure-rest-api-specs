// --------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// --------------------------------------------------------------------------------------------

import "./common.tsp";

using TypeSpec.Versioning;

alias DefaultAzureCoreVersion = Azure.Core.Versions.v1_0_Preview_2;

/** The Azure Quantum Workspace REST API version. */
#suppress "@azure-tools/typespec-azure-core/no-enum" "This is the version enum"
enum QuantumWorkspaceAPIVersion {
  /** 2019-11-04-preview */
  @useDependency(DefaultAzureCoreVersion)
  `2019-11-04-preview`,

  /** 2021-05-06-preview */
  @useDependency(DefaultAzureCoreVersion)
  `2021-05-06-preview`,

  /** 2021-11-01-preview */
  @useDependency(DefaultAzureCoreVersion)
  `2021-11-01-preview`,

  /** 2022-09-12-preview */
  @useDependency(DefaultAzureCoreVersion)
  `2022-09-12-preview`,

  /** 2023-11-13-preview */
  @useDependency(DefaultAzureCoreVersion)
  `2023-11-13-preview`,

  /** 2024-03-01-preview */
  @useDependency(DefaultAzureCoreVersion)
  `2024-03-01-preview`,
}
