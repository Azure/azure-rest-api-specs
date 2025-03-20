import "@azure-tools/typespec-azure-core";

import "../models/videoDescription.tsp";
import "../../VDI.BatchRegistration/main.tsp";

using Azure.Core;
using Azure.Core.Traits;
using VdiBatchRegistration;

namespace VdiVideoAnalysis;

// Service Traits to be reviewed
alias ServiceTraits = SupportsRepeatableRequests &
    SupportsConditionalRequests &
    SupportsClientRequestId;

alias Operations = Azure.Core.ResourceOperations<ServiceTraits>;

interface VideoDescriptions {
    @doc("Fetch a registration by name.")
    getVideoDescription is Operations.ResourceRead<VideoDescriptionTask>;

    @doc("Create or update registration.")
    createOrUpdateVideoDescriptionTask is Operations.ResourceCreateOrUpdate<VideoDescriptionTask>;

    @doc("Delete a registration resource.")
    deleteVideoDescriptionTask is Operations.ResourceDelete<VideoDescriptionTask>;

    @doc("List registration resources.")
    listVideoDescriptionTask is Operations.ResourceList<VideoDescriptionTask>;

    //Registration api definition inherited
    @doc("Fetch a registration by name.")
    getRegistration is Operations.ResourceRead<Registration>;

    @doc("Create or update registration.")
    createOrUpdateRegistration is Operations.ResourceCreateOrUpdate<Registration>;

    @doc("Delete a registration resource.")
    deleteRegistration is Operations.ResourceDelete<Registration>;

    @doc("List registration resources.")
    listRegistration is Operations.ResourceList<Registration>;
}
