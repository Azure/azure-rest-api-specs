import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Automanage;
/**
 * Definition of the Automanage best practice.
 */
@tenantResource
model BestPractice
  is Azure.ResourceManager.ProxyResource<ConfigurationProfileProperties> {
  ...ResourceNameParameter<
    Resource = BestPractice,
    KeyName = "bestPracticeName",
    SegmentName = "bestPractices",
    NamePattern = ""
  >;
}

@armResourceOperations
interface BestPracticeOps
  extends Azure.ResourceManager.Legacy.ExtensionOperations<
      {
        ...ApiVersionParameter,

        /** the provider namespace */
        @path
        @segment("providers")
        @key
        providerNamespace: "Microsoft.Automanage",
      },
      {},
      {
        /** The Automanage best practice name. */
        @path
        @segment("bestPractices")
        @key
        bestPracticeName: string,
      }
    > {}

@armResourceOperations
interface BestPractices {
  /**
   * Get information about a Automanage best practice
   */
  get is BestPracticeOps.Read<BestPractice>;

  /**
   * Retrieve a list of Automanage best practices
   */
  listByTenant is BestPracticeOps.List<
    BestPractice,
    Response = ArmResponse<BestPracticeList>
  >;
}
@armResourceOperations
interface BestPracticesVersionOps
  extends Azure.ResourceManager.Legacy.ExtensionOperations<
      {
        ...ApiVersionParameter,

        /** the provider namespace */
        @path
        @segment("providers")
        @key
        providerNamespace: "Microsoft.Automanage",

        /** The Automanage best practice name. */
        @path
        @segment("bestPractices")
        @key
        bestPracticeName: string,
      },
      {},
      {
        /** The Automanage best practice version name. */
        @path
        @segment("versions")
        @key
        versionName: string,
      }
    > {}

@armResourceOperations
interface BestPracticesVersions {
  /**
   * Get information about a Automanage best practice version
   */
  get is BestPracticesVersionOps.Read<BestPractice>;
}

@@doc(BestPractice.name, "The Automanage best practice name.");
@@doc(BestPractice.properties, "Properties of the best practice.");
@@summary(BestPractice.properties, "Properties");
