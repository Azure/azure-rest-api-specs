import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DevTestLab;
/**
 * A container for a managed identity to execute DevTest lab services.
 */
model ServiceRunner is Azure.ResourceManager.ProxyResource<never> {
  ...ResourceNameParameter<
    Resource = ServiceRunner,
    KeyName = "name",
    SegmentName = "servicefabrics",
    NamePattern = ""
  >;
  ...Azure.ResourceManager.Foundations.ArmTagsProperty;

  /**
   * The geo-location where the resource lives
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Day 0 Property"
  @visibility(Lifecycle.Create, Lifecycle.Read)
  location?: string;
}

@armResourceOperations
interface ServiceRunnerOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,

        /** The name of the lab. */
        @path @segment("labs") labName: string,
      },
      KeysOf<ResourceNameParameter<
        Resource = ServiceRunner,
        KeyName = "name",
        SegmentName = "servicerunners",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface ServiceRunners {
  /**
   * Get service runner.
   */
  get is ServiceRunnerOps.Read<ServiceRunner>;

  /**
   * Create or replace an existing service runner.
   */
  createOrUpdate is ServiceRunnerOps.CreateOrUpdateSync<ServiceRunner>;

  /**
   * Delete service runner.
   */
  delete is ServiceRunnerOps.DeleteSync<ServiceRunner>;
}

@@doc(ServiceRunner.name, "The name of the service runner.");
@@doc(ServiceRunners.createOrUpdate::parameters.resource,
  "A container for a managed identity to execute DevTest lab services."
);
