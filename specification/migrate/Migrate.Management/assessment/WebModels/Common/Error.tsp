@doc("Error web model class.")
model Error {
    @doc("Gets the error ID.")
    @visibility("read")
    id?: int32;

    @doc("Gets the error code.")
    @visibility("read")
    code?: string;

    @doc("Gets the Run as account ID.")
    @visibility("read")
    runAsAccountId?: string;

    @doc("Gets the Appliance name.")
    @visibility("read")
    applianceName?: string;

    @doc("Gets the error message.")
    @visibility("read")
    message?: string;

    @doc("Gets the error summary message.")
    @visibility("read")
    summaryMessage?: string;

    @doc("Gets the agent scenario where this error occurred.")
    @visibility("read")
    agentScenario?: string;

    @doc("Gets the error possible causes.")
    @visibility("read")
    possibleCauses?: string;

    @doc("Gets the recommended action for the error.")
    @visibility("read")
    recommendedAction?: string;

    @doc("Gets the error severity.")
    @visibility("read")
    severity?: string;

    @doc("Gets the error message parameters.")
    @visibility("read")
    messageParameters?: Record<string>;

    @doc("Gets the time stamp when the error was updated.")
    @visibility("read")
    updatedTimeStamp?: utcDateTime;

    @doc("Gets the type of assessment impacted by this error.")
    @visibility("read")
    impactedAssessmentType?: string;
}
