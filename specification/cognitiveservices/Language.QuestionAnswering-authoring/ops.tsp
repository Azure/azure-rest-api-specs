// --------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// --------------------------------------------------------------------------------------------

import "@typespec/rest";
import "@typespec/versioning";
import "@typespec/http";
import "@typespec/openapi";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.Core;
using Azure.Core.Traits;

namespace Language.QuestionAnswering.Authoring;

#suppress "@azure-tools/typespec-azure-core/no-private-usage" "Need to define custom ops for older predefined PATCH ops"
@Foundations.Private.ensureVerb("ResourceCreateOrUpdate", "PATCH")
@createsOrUpdatesResource(Resource)
@parameterVisibility(Lifecycle.Create, Lifecycle.Update)
@patch(#{ implicitOptionality: true })
op ResourceCreateOrUpdateWithJsonContentType<
  Resource extends TypeSpec.Reflection.Model,
  MethodTraits extends TypeSpec.Reflection.Model = {},
  ServiceTraits extends TypeSpec.Reflection.Model = {},
  ErrorResponse = Azure.Core.Foundations.ErrorResponse
> is Azure.Core.Foundations.ResourceOperation<
  Resource,
  {
    /**
     * The name of the project to use.
     */
    @doc("This request has a JSON body.")
    @TypeSpec.Http.header("Content-Type")
    contentType: "application/json";

    @doc("The resource instance.")
    @body
    body: Resource;

    ...Azure.Core.Traits.Private.TraitProperties<
      MethodTraits & ServiceTraits,
      TraitLocation.Parameters,
      TraitContext.Create | TraitContext.Update
    >;
  },
  Azure.Core.Foundations.ResourceCreatedOrOkResponse<Resource &
    Azure.Core.Traits.Private.TraitProperties<
      MethodTraits & ServiceTraits,
      TraitLocation.Response,
      TraitContext.Create | TraitContext.Update
    >>,
  MethodTraits & ServiceTraits,
  ErrorResponse
>;
