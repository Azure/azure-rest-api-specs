import * as dotenv from 'dotenv';

const envFile = process.env.NODE_ENV ? `.env.${process.env.NODE_ENV}` : '.env';
dotenv.config({ path: envFile });

export async function api_change_comment(
    headCommitSh: string,
    options: { verbose?: boolean }) : Promise<void> {
        const baseApiUrl = process.env.API_URL;
    console.log("headCommitSh:", headCommitSh);
    console.log("baseApiUrl:", baseApiUrl);
}
