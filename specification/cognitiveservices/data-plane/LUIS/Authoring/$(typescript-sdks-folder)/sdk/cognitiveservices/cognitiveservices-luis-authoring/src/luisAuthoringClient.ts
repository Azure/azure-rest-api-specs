import * as coreAuth from "@azure/core-auth";
import {
  FeaturesImpl,
  ExamplesImpl,
  ModelImpl,
  AppsImpl,
  VersionsImpl,
  TrainImpl,
  PatternImpl,
  SettingsImpl,
  AzureAccountsImpl
} from "./operations";
import {
  Features,
  Examples,
  Model,
  Apps,
  Versions,
  Train,
  Pattern,
  Settings,
  AzureAccounts
} from "./operationsInterfaces";
import { LuisAuthoringClientContext } from "./luisAuthoringClientContext";
import { LuisAuthoringClientOptionalParams } from "./models";

export class LuisAuthoringClient extends LuisAuthoringClientContext {
  /**
   * Initializes a new instance of the LuisAuthoringClient class.
   * @param credentials Subscription credentials which uniquely identify client subscription.
   * @param endpoint Supported Cognitive Services endpoints (protocol and hostname, for example:
   *                 https://westus.api.cognitive.microsoft.com).
   * @param options The parameter options
   */
  constructor(
    credentials: coreAuth.TokenCredential,
    endpoint: string,
    options?: LuisAuthoringClientOptionalParams
  ) {
    super(credentials, endpoint, options);
    this.features = new FeaturesImpl(this);
    this.examples = new ExamplesImpl(this);
    this.model = new ModelImpl(this);
    this.apps = new AppsImpl(this);
    this.versions = new VersionsImpl(this);
    this.train = new TrainImpl(this);
    this.pattern = new PatternImpl(this);
    this.settings = new SettingsImpl(this);
    this.azureAccounts = new AzureAccountsImpl(this);
  }

  features: Features;
  examples: Examples;
  model: Model;
  apps: Apps;
  versions: Versions;
  train: Train;
  pattern: Pattern;
  settings: Settings;
  azureAccounts: AzureAccounts;
}
