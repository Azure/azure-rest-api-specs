// --------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// --------------------------------------------------------------------------------------------

import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Versioning;

@doc("The Azure Quantum REST API version.")
enum QuantumAPIVersion {
  @doc("2024-03-01-preview")
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  `2024-03-01-preview`,
}
