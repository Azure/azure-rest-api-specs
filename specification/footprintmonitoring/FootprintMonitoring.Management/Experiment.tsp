import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Profile.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.FootprintMonitoring;
/**
 * A model representing the Footprint experiment.
 */
@parentResource(Profile)
model Experiment is Azure.ResourceManager.ProxyResource<ExperimentProperties> {
  ...ResourceNameParameter<
    Resource = Experiment,
    KeyName = "experimentName",
    SegmentName = "experiments",
    NamePattern = "^[a-zA-Z0-9]"
  >;

  /**
   * The type of the resource.
   */
  //@visibility(Lifecycle.Read)
  // type?: string;
}

@armResourceOperations
interface Experiments {
  /**
   * Retrieves the information about a single Footprint experiment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" ""
  @OpenAPI.extension(
    "x-ms-examples",
    #{
      `Get a Footprint experiment (max).`: #{
        $ref: "./examples/Experiments_Get_MaximumSet_Gen.json",
      },
    }
  )
  @OpenAPI.extension(
    "x-ms-examples",
    #{
      `Get a Footprint experiment (min).`: #{
        $ref: "./examples/Experiments_Get_MinimumSet_Gen.json",
      },
    }
  )
  get is ArmResourceRead<Experiment>;

  /**
   * Creates or updates a Footprint experiment with the specified properties.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" ""
  @OpenAPI.extension(
    "x-ms-examples",
    #{
      `Create or update a Footprint experiment (max).`: #{
        $ref: "./examples/Experiments_CreateOrUpdate_MaximumSet_Gen.json",
      },
    }
  )
  createOrUpdate is ArmResourceCreateOrReplaceSync<Experiment>;

  /**
   * Deletes an existing Footprint experiment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" ""
  @OpenAPI.extension(
    "x-ms-examples",
    #{
      `Delete a Footprint experiment (max).`: #{
        $ref: "./examples/Experiments_Delete_MaximumSet_Gen.json",
      },
    }
  )
  // @OpenAPI.extension(
  //   "x-ms-examples",
  //   {
  //     `Delete a Footprint experiment (min).`: {
  //       $ref: "./examples/Experiments_Delete_MinimumSet_Gen.json",
  //     },
  //   }
  // )
  delete is ArmResourceDeleteSync<Experiment>;

  /**
   * Retrieves the information about all experiments under a Footprint profile.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" ""
  @OpenAPI.extension(
    "x-ms-examples",
    #{
      `List all Footprint experiments (max).`: #{
        $ref: "./examples/Experiments_ListByProfile_MaximumSet_Gen.json",
      },
    }
  )
  listByProfile is ArmResourceListByParent<Experiment>;
}

@@maxLength(Experiment.name, 64);
@@minLength(Experiment.name, 5);
@@doc(Experiment.name, "Name of the Footprint experiment resource.");
@@doc(Experiments.createOrUpdate::parameters.resource,
  "Footprint experiment creation or update parameters."
);
