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
	error:
		| AuthError
		| null
		| string
		| {
			createdTeacherUserError: AuthError | null;
			createdTeacherRecordError: any;
		};
	data:
		| {
			createdTeacherUserData: { user: User | null };
			createdTeacherRecordData: any[] | null;
		}
		| { user: User | null }
		| null;
}

serve(async (req: Request) => {
	const supabase = createSupabase(req);

	try {
		const { email, password, phone, firstName, lastName } = await req
			.json();

		if (
			!confirmedRequiredParams([
				email,
				password,
				phone,
				firstName,
				lastName,
			])
		) {
			return new Response(JSON.stringify(errorResponseData), {
				headers: { 'Content-Type': 'application/json' },
			});
		}

		const { data, error } = await supabase.auth.admin.createUser({
			email,
			password,
			phone,
		});

		if (error !== null) {
			const responseData: CreateUserTeacherResponseModel = {
				isRequestSuccessful: false,
				data: data,
				error: error as unknown as AuthError,
			};

			return new Response(JSON.stringify(responseData), {
				headers: { 'Content-Type': 'application/json' },
			});
		}

		const createdTeacherRecord = await supabase
			.from('Teachers')
			.insert({
				firstName,
				lastName,
				userId: data.user.id,
			})
			.select();

		const createdTeacherRecordData = createdTeacherRecord.data;

		const responseData: CreateUserTeacherResponseModel = {
			isRequestSuccessful: true,
			data: { createdTeacherUserData: data, createdTeacherRecordData },
			error: {
				createdTeacherUserError: error,
				createdTeacherRecordError: createdTeacherRecord.error,
			},
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
});
