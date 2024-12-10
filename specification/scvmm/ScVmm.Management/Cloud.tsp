import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using OpenAPI;

namespace Microsoft.ScVmm;
/** The Clouds resource definition. */
model Cloud is TrackedResource<CloudProperties> {
  /** Name of the Cloud. */
  @maxLength(54)
  @minLength(1)
  @pattern("[a-zA-Z0-9-_\\.]")
  @path
  @key("cloudResourceName")
  @segment("clouds")
  name: string;

  /** The extended location. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "This property is allowed but not recognized by the linter"
  extendedLocation: ExtendedLocation;
}

@armResourceOperations
interface Clouds {
  /** Implements Cloud GET method. */
  @summary("Gets a Cloud.")
  get is ArmResourceRead<Cloud>;
  /** Onboards the ScVmm fabric cloud as an Azure cloud resource. */
  #suppress "@azure-tools/typespec-azure-core/invalid-final-state" "MUST CHANGE ON NEXT UPDATE"
  @summary("Implements Clouds PUT method.")
  @Azure.Core.useFinalStateVia("azure-async-operation")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    Cloud,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader
  >;
  /** Updates the Clouds resource. */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "DO NOT COPY - TODO migrate to LRO apis"
  @summary("Implements the Clouds PATCH method.")
  @extension(
    "x-ms-long-running-operation-options",
    {
      `final-state-via`: "azure-async-operation",
    }
  )
  update is ArmTagsPatchAsync<Cloud>;
  /** Deregisters the ScVmm fabric cloud from Azure. */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "DO NOT COPY - TODO migrate to LRO apis"
  @summary("Implements Cloud resource DELETE method.")
  @extension(
    "x-ms-long-running-operation-options",
    {
      `final-state-via`: "azure-async-operation",
    }
  )
  delete is ArmResourceDeleteWithoutOkAsync<
    Cloud,
    {
      ...Foundations.BaseParameters<Cloud>;
      ...QueryForceDelete;
    }
  >;
  /** List of Clouds in a resource group. */
  @summary("Implements GET Clouds in a resource group.")
  listByResourceGroup is ArmResourceListByParent<Cloud>;
  /** List of Clouds in a subscription. */
  @summary("Implements GET Clouds in a subscription.")
  listBySubscription is ArmListBySubscription<Cloud>;
}
