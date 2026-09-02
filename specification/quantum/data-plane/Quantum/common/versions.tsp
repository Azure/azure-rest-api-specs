// --------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// --------------------------------------------------------------------------------------------

import "./common.tsp";

using TypeSpec.Versioning;

namespace Quantum.Workspace;

/** The Azure Quantum Workspace REST API version. */
enum QuantumWorkspaceAPIVersion {
  /** 2024-03-01-preview */
  v2024_03_01_preview: "2024-03-01-preview",

  /** 2024-10-01-preview */
  v2024_10_01_preview: "2024-10-01-preview",

  /** 2025-09-01-preview */
  v2025_09_01_preview: "2025-09-01-preview",

  /** 2025-12-01-preview */
  v2025_12_01_preview: "2025-12-01-preview",

  /** 2026-01-15-preview */
  v2026_01_15_preview: "2026-01-15-preview",
}
