// --------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// --------------------------------------------------------------------------------------------

import "./common.tsp";

using TypeSpec.Versioning;

@useDependency(DefaultAzureCoreVersion)
@doc("A versioned namespace to use the Error model in the unversioned root namespace.")
namespace Errors {
  @doc("The error object.")
  model Error {
    ...Azure.Core.Foundations.Error;
  }
}
