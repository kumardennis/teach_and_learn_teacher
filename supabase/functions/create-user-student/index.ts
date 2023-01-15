// deno-lint-ignore-file no-explicit-any
// Follow this setup guide to integrate the Deno language server with your editor:
// https://deno.land/manual/getting_started/setup_your_environment
// This enables autocomplete, go to definition, etc.

import { serve } from 'https://deno.land/std@0.131.0/http/server.ts';
import {
	AuthError,
	User,
} from 'https://esm.sh/v96/@supabase/gotrue-js@2.0.0-rc.10/dist/module/index.d.ts';
import {
	confirmedRequiredParams,
	errorResponseData,
} from '../_shared/confirmedRequiredParams.ts';
import { corsHeaders } from '../_shared/cors.ts';
import { createSupabase } from '../_shared/supabaseClient.ts';
import { handler } from './handler.ts';

console.log('Hello from Create user teacher Functions!');

interface CreateUserStudentResponseModel {
	isRequestSuccessful: boolean;
	error: any;
	data:
		| {
			createdStudentUserData: { user: User | null };
			createdStudentRecordData: any[] | null;
		}
		| { user: User | null }
		| null;
}

serve(handler);
