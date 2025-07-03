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
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...Azure.ResourceManager.Legacy.Provider,
      },
      KeysOf<ResourceNameParameter<
        Resource = BestPractice,
        KeyName = "bestPracticeName",
        SegmentName = "bestPractices",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface BestPracticeByTenantOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...Azure.ResourceManager.Legacy.Provider,
      },
      KeysOf<ResourceNameParameter<
        Resource = BestPractice,
        SegmentName = "bestPractices",
        NamePattern = ""
      >>
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
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("BestPractices_ListByTenant")
  listByTenant is BestPracticeByTenantOps.List<
    BestPractice,
    Response = ArmResponse<BestPracticeList>
  >;
}

@armResourceOperations
interface BestPracticesVersionOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...Azure.ResourceManager.Legacy.Provider,
        ...KeysOf<ResourceNameParameter<
          Resource = BestPractice,
          KeyName = "bestPracticeName",
          SegmentName = "bestPractices",
          NamePattern = ""
        >>,
      },
      KeysOf<ResourceNameParameter<
        Resource = BestPractice,
        KeyName = "versionName",
        SegmentName = "versions",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface BestPracticesVersionByTenantOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...Azure.ResourceManager.Legacy.Provider,
        ...KeysOf<ResourceNameParameter<
          Resource = BestPractice,
          KeyName = "bestPracticeName",
          SegmentName = "bestPractices",
          NamePattern = ""
        >>,
        
      },
      KeysOf<ResourceNameParameter<
        Resource = BestPractice,
        KeyName = "versions",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface BestPracticesVersions {
  /**
   * Get information about a Automanage best practice version
   */
  get is BestPracticesVersionOps.Read<BestPractice>;

  /**
   * Retrieve a list of Automanage best practices
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("BestPractices_ListByTenant")
  listByTenant is BestPracticesVersionByTenantOps.List<
    BestPractice,
    Response = ArmResponse<BestPracticeList>
  >;
}

@@doc(BestPractice.name, "The Automanage best practice name.");
@@doc(BestPractice.properties, "Properties of the best practice.");
