// Follow this setup guide to integrate the Deno language server with your editor:
// https://deno.land/manual/getting_started/setup_your_environment
// This enables autocomplete, go to definition, etc.

import { serve } from 'https://deno.land/std@0.131.0/http/server.ts';
import {
	confirmedRequiredParams,
	errorResponseData,
} from '../_shared/confirmedRequiredParams.ts';

import { ResponseModel } from '../_shared/ResponseModel.ts';
import { createSupabase } from '../_shared/supabaseClient.ts';

console.log('Hello from Address Teacher Functions!');

serve(async (req) => {
	const supabase = createSupabase(req);

	try {
		const { schoolId, teacherId } = await req.json();

		if (!confirmedRequiredParams([schoolId, teacherId])) {
			return new Response(JSON.stringify(errorResponseData), {
				headers: { 'Content-Type': 'application/json' },
			});
		}

		const { data, error } = await supabase
			.from('Teachers_Schools')
			.insert({
				schoolId,
				teacherId,
				invitationAccepted: false,
				isInvitationFromTeacher: true,
				isInvitationFromSchool: false,
			})
			.select();

		const responseData: ResponseModel = {
			isRequestSuccessful: error === null,
			data,
			error,
		};

		return new Response(JSON.stringify(responseData), {
			headers: { 'Content-Type': 'application/json' },
		});
	} catch (err) {
		const responseData: ResponseModel = {
			isRequestSuccessful: false,
			data: null,
			error: err,
		};

		return new Response(JSON.stringify(responseData), {
			headers: { 'Content-Type': 'application/json' },
		});
	}
});
