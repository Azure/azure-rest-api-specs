import "@azure-tools/typespec-azure-core";

import "../models/registration.tsp";

using Azure.Core;
using Azure.Core.Traits;

namespace VdiBatchRegistration;

// Service Traits to be reviewed
alias ServiceTraits = SupportsRepeatableRequests &
    SupportsConditionalRequests &
    SupportsClientRequestId;

alias Operations = Azure.Core.ResourceOperations<ServiceTraits>;

interface Registrations {
    @doc("Fetch a registration by name.")
    getRegistration is Operations.ResourceRead<Registration>;

    @doc("Create or update registration.")
    createOrUpdateRegistration is Operations.ResourceCreateOrUpdate<Registration>;

    @doc("Delete a registration resource.")
    deleteRegistration is Operations.ResourceDelete<Registration>;

    @doc("List registration resources.")
    listRegistration is Operations.ResourceList<Registration>;
}
