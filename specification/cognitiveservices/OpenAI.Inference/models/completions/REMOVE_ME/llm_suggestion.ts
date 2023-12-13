interface Data {
    id: string;
    object: string;
    created: number;
    model: string;
    system_fingerprint?: string;
    prompt_filter_results?: PromptFilterResult[];
    choices: Choice[];
}

interface PromptFilterResult {
    prompt_index: number;
    content_filter_results: ContentFilterResults;
}

interface ContentFilterResults {
    custom_blocklists: any[];
    hate: FilterResult;
    jailbreak: JailbreakFilterResult;
    profanity: FilterResult;
    self_harm: FilterResult;
    sexual: FilterResult;
    violence: FilterResult;
}

interface FilterResult {
    filtered: boolean;
    severity: string;
}

interface JailbreakFilterResult {
    detected: boolean;
    filtered: boolean;
}

interface Choice {
    index: number;
    finish_reason: string | null;
    delta: Delta;
    finish_details?: FinishDetails;
    content_filter_results?: any;
}

interface Delta {
    role?: string;
    content?: string;
    tool_calls?: ToolCall[];
}

interface ToolCall {
    index: number;
    id: string;
    type: string;
    function: Function;
}

interface Function {
    name: string;
    arguments: string;
}

interface FinishDetails {
    type: string;
    stop: string;
}
