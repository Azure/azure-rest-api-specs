// --------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// --------------------------------------------------------------------------------------------

import "./common.tsp";

using TypeSpec.Versioning;

namespace Quantum.Workspace;

alias DefaultAzureCoreVersion = Azure.Core.Versions.v1_0_Preview_2;

/** The Azure Quantum Workspace REST API version. */
enum QuantumWorkspaceAPIVersion {
  /** 2024-03-01-preview */
  @useDependency(DefaultAzureCoreVersion)
  v2024_03_01_preview: "2024-03-01-preview",

  /** 2024-10-01-preview */
  @useDependency(DefaultAzureCoreVersion)
  v2024_10_01_preview: "2024-10-01-preview",
}
