// Routes for the Experiments data-plane surface.
// Provides experiment lifecycle for A/B version traffic-split on agents.

import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Azure.AI.Projects;

// ---------------------------------------------------------------------------
// Experiment CRUD + lifecycle actions
// ---------------------------------------------------------------------------

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "OpenAI-based operations are definitionally non-standard"
@tag("Experiments")
interface Experiments {
  @summary("Create an experiment")
  @doc("Creates an experiment. For an agents_safe_rollout experiment, the service mints experiment_id and salt, write-locks the agent's version selector, and starts sticky-per-conversation routing.")
  @route("experiments")
  @post
  @extension("x-ms-foundry-meta", ExperimentsRequiredPreviews)
  create is FoundryDataPlanePreviewOperation<
    FoundryFeaturesOptInKeys.experiments_v1_preview,
    CreateExperimentRequest,
    {
      @statusCode statusCode: 201;
      @body body: Experiment;
    }
  >;

  @summary("Get an experiment")
  @doc("Retrieves the experiment by id.")
  @route("experiments/{experiment_id}")
  @get
  @extension("x-ms-foundry-meta", ExperimentsRequiredPreviews)
  get is FoundryDataPlanePreviewOperation<
    FoundryFeaturesOptInKeys.experiments_v1_preview,
    {
      @doc("The unique identifier of the experiment.")
      @path
      experiment_id: string;
    },
    Experiment
  >;

  @summary("List experiments")
  @doc("Returns the list of all experiments.")
  @route("experiments")
  @get
  @extension("x-ms-foundry-meta", ExperimentsRequiredPreviews)
  list is FoundryDataPlanePreviewOperation<
    FoundryFeaturesOptInKeys.experiments_v1_preview,
    {
      ...CursorPaginationParams;
    },
    OpenAIPage<Experiment>
  >;

  @summary("Stop an experiment")
  @doc("Stops a running experiment. Routing collapses to the control variant and the agent's version selector is unlocked for editing.")
  @route("experiments/{experiment_id}:stop")
  @post
  @extension("x-ms-foundry-meta", ExperimentsRequiredPreviews)
  stop is FoundryDataPlanePreviewOperation<
    FoundryFeaturesOptInKeys.experiments_v1_preview,
    {
      @doc("The unique identifier of the experiment to stop.")
      @path
      experiment_id: string;
    },
    Experiment
  >;

  @summary("Promote an experiment")
  @doc("Promotes the winning variant. The agent's version selector is replaced with a single 100% rule for the winner.")
  @route("experiments/{experiment_id}:promote")
  @post
  @extension("x-ms-foundry-meta", ExperimentsRequiredPreviews)
  promote is FoundryDataPlanePreviewOperation<
    FoundryFeaturesOptInKeys.experiments_v1_preview,
    {
      @doc("The unique identifier of the experiment to promote.")
      @path
      experiment_id: string;

      @doc("The promotion request.")
      @body
      body: PromoteExperimentRequest;
    },
    Experiment
  >;

  @summary("List scorecards")
  @doc("Returns the list of generated scorecards for an experiment. Each scorecard is a table comparing metric values between variants.")
  @route("experiments/{experiment_id}/scorecards")
  @get
  @extension("x-ms-foundry-meta", ExperimentsRequiredPreviews)
  listScorecards is FoundryDataPlanePreviewOperation<
    FoundryFeaturesOptInKeys.experiments_v1_preview,
    {
      @doc("The unique identifier of the experiment.")
      @path
      experiment_id: string;
    },
    {
      @doc("The list of scorecards.")
      data: Scorecard[];
    }
  >;

  @summary("Delete a scorecard")
  @doc("Deletes the scorecard record and its user-blob artifact. Does not stop or mutate the experiment itself.")
  @route("experiments/{experiment_id}/scorecards/{scorecard_id}")
  @delete
  @extension("x-ms-foundry-meta", ExperimentsRequiredPreviews)
  deleteScorecard is FoundryDataPlanePreviewOperation<
    FoundryFeaturesOptInKeys.experiments_v1_preview,
    {
      @doc("The unique identifier of the experiment.")
      @path
      experiment_id: string;

      @doc("The unique identifier of the scorecard to delete.")
      @path
      scorecard_id: string;
    },
    {
      @statusCode statusCode: 204;
    }
  >;
}
