import { TsvHost } from "./tsv-host.js";
import { simpleGit } from "simple-git";

export const TsvRunnerHost: TsvHost = {
    gitOperation: simpleGit
    // TODO: Other functions that need mocks
};
