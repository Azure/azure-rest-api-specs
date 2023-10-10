import { TsvHost } from "../src/tsv-host.js";

export const TsvTestHost: TsvHost = {
    gitOperation: (folder: string) => {
        return {
            status: () => {return {modified:[`${folder}\n`], isClean: ()=>{return false}}},
            diff: ()=>{return "diff"}
        }
    }
};