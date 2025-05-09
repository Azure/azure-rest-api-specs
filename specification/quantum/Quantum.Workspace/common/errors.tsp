// --------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// --------------------------------------------------------------------------------------------

import "./common.tsp";

using TypeSpec.Versioning;

using Quantum.Workspace;

/** A versioned namespace to use the Error model in the unversioned root namespace. */
@useDependency(DefaultAzureCoreVersion)
namespace Errors {
  /** The error object. */
  model WorkspaceItemError {
    ...Azure.Core.Foundations.Error;
  }
}
