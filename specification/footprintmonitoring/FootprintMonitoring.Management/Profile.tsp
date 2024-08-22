import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.FootprintMonitoring;
/**
 * The Footprint profile resource.
 */
model Profile is Azure.ResourceManager.TrackedResource<ProfileProperties> {
  ...ResourceNameParameter<
    Resource = Profile,
    KeyName = "profileName",
    SegmentName = "profiles",
    NamePattern = "^[a-zA-Z0-9]"
  >;
}

@armResourceOperations
interface Profiles {
  /**
   * Retrieves the information about a single Footprint profile.
   */
  @OpenAPI.extension(
    "x-ms-examples",
    {
      `Get a Footprint profile (max).`: {
        $ref: "./examples/Profiles_Get_MaximumSet_Gen.json",
      },
    }
  )
  get is ArmResourceRead<Profile>;

  /**
   * Creates or updates a Footprint profile with the specified properties.
   */
  @OpenAPI.extension(
    "x-ms-examples",
    {
      `Create or update a Footprint profile (max).`: {
        $ref: "./examples/Profiles_CreateOrUpdate_MaximumSet_Gen.json",
      },
    }
  )
  createOrUpdate is ArmResourceCreateOrReplaceSync<Profile>;

  /**
   * Updates an existing Footprint profile resource.
   */
  @OpenAPI.extension(
    "x-ms-examples",
    {
      `Update a Footprint profile (max).`: {
        $ref: "./examples/Profiles_Update_MaximumSet_Gen.json",
      },
    }
  )
  @parameterVisibility
  update is ArmCustomPatchSync<Profile, ProfilePatch>;

  /**
   * Deletes an existing Footprint profile.
   */
  @OpenAPI.extension(
    "x-ms-examples",
    {
      `Delete a Footprint profile (max).`: {
        $ref: "./examples/Profiles_Delete_MaximumSet_Gen.json",
      },
    }
  )
  @OpenAPI.extension(
    "x-ms-examples",
    {
      `Delete a Footprint profile (min).`: {
        $ref: "./examples/Profiles_Delete_MinimumSet_Gen.json",
      },
    }
  )
  delete is ArmResourceDeleteSync<Profile>;

  /**
   * Retrieves the information about all Footprint profiles under a resource group.
   */
  @OpenAPI.extension(
    "x-ms-examples",
    {
      `List all Footprint profiles under a resource group (max).`: {
        $ref: "./examples/Profiles_ListByResourceGroup_MaximumSet_Gen.json",
      },
    }
  )
  listByResourceGroup is ArmResourceListByParent<Profile>;

  /**
   * Retrieves the information about all Footprint profiles under a subscription.
   */
  @OpenAPI.extension(
    "x-ms-examples",
    {
      `List all Footprint profiles under a subscription (max).`: {
        $ref: "./examples/Profiles_ListBySubscription_MaximumSet_Gen.json",
      },
    }
  )
  listBySubscription is ArmListBySubscription<Profile>;
}

@@maxLength(Profile.name, 64);
@@minLength(Profile.name, 3);
@@doc(Profile.name, "Name of the Footprint profile resource.");
@@doc(Profiles.createOrUpdate::parameters.resource,
  "Footprint profile creation or update parameters."
);
@@doc(Profiles.update::parameters.properties,
  "Footprint profile update parameters."
);
