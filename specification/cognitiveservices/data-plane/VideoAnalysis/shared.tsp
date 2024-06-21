using Azure.Core;
using Azure.Core.Traits;
using Azure.Core.Foundations;

namespace VideoAnalysis;

alias JobServiceTraits = SupportsRepeatableRequests &
    NoConditionalRequests &
    SupportsClientRequestId;

alias JobOperations = Azure.Core.ResourceOperations<JobServiceTraits>;
