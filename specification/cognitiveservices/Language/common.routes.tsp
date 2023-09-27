import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./common.models.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;

@versioned(Versions)
namespace Language;

#suppress "@azure-tools/typespec-azure-core/long-running-polling-operation-required" "template"
@Foundations.Private.needsRoute
@post
@doc("Long running operation template to match Azure Language.")
op LanguageLongRunningOperation<
  TParams extends TypeSpec.Reflection.Model,
  TStatusResult extends TypeSpec.Reflection.Model,
  TStatusError = Foundations.Error,
  Traits extends TypeSpec.Reflection.Model = {},
  TErrorResponse = Azure.Core.Foundations.ErrorResponse
> is Foundations.Operation<
  TParams &
    Azure.Core.Traits.Private.TraitProperties<
      Traits,
      Azure.Core.Traits.TraitLocation.Parameters
    >,
  Azure.Core.Foundations.AcceptedResponse &
    Foundations.LongRunningStatusLocation<TStatusResult> &
    Azure.Core.Traits.Private.TraitProperties<
      Traits,
      Azure.Core.Traits.TraitLocation.Response
    >,
  Traits,
  TErrorResponse
>;

#suppress "@azure-tools/typespec-azure-core/long-running-polling-operation-required" "template"
@Foundations.Private.needsRoute
@post
@doc("Long running operation template to match Azure Language.")
op LanguageLongRunningResourceCancel<
    TParams extends TypeSpec.Reflection.Model,
    Traits extends TypeSpec.Reflection.Model = {},
    TErrorResponse = Azure.Core.Foundations.ErrorResponse
  > is Foundations.ResourceOperation<
    TParams,
    Azure.Core.Traits.Private.TraitProperties<Traits, TraitLocation.Parameters>,
    Foundations.AcceptedResponse<
      Foundations.LongRunningStatusLocation &
      Azure.Core.Traits.Private.TraitProperties<Traits, TraitLocation.Response>>,
    Traits,
    TErrorResponse
  >;