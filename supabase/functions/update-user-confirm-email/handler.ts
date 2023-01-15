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

console.log('Hello from Create user teacher Functions!');

interface CreateUserTeacherResponseModel {
	isRequestSuccessful: boolean;
	error: any;

	data: any;
}

export const handler = async (req: Request) => {
	const supabase = createSupabase(req);

	try {
		const { userUid } = await req
			.json();

		if (
			!confirmedRequiredParams([
				userUid,
			])
		) {
			return new Response(JSON.stringify(errorResponseData), {
				headers: { 'Content-Type': 'application/json' },
			});
		}

		const { data, error } = await supabase.auth.admin.updateUserById(
			userUid,
			{
				email_confirm: true,
			},
		);

		if (error !== null) {
			const responseData: CreateUserTeacherResponseModel = {
				isRequestSuccessful: false,
				data: data,
				error: error,
			};

			return new Response(JSON.stringify(responseData), {
				headers: { 'Content-Type': 'application/json' },
			});
		}

		const responseData: CreateUserTeacherResponseModel = {
			isRequestSuccessful: true,
			data: data,
			error: error,
		};

		return new Response(JSON.stringify(responseData), {
			headers: { ...corsHeaders, 'Content-Type': 'application/json' },
		});
	} catch (err) {
		const responseData: CreateUserTeacherResponseModel = {
			isRequestSuccessful: false,
			data: null,
			error: err,
		};

		return new Response(JSON.stringify(responseData), {
			headers: { ...corsHeaders, 'Content-Type': 'application/json' },
		});
	}
};
