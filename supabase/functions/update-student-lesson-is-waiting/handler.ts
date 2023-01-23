// Follow this setup guide to integrate the Deno language server with your editor:
// https://deno.land/manual/getting_started/setup_your_environment
// This enables autocomplete, go to definition, etc.

import {
	confirmedRequiredParams,
	errorResponseData,
} from '../_shared/confirmedRequiredParams.ts';
import { corsHeaders } from '../_shared/cors.ts';
import { ResponseModel } from '../_shared/ResponseModel.ts';
import { createSupabase } from '../_shared/supabaseClient.ts';

console.log('Hello from update lesson is waiting Functions!');

export const handler = async (req: Request) => {
	const supabase = createSupabase(req);
	const responseData: ResponseModel = {} as ResponseModel;

	try {
		const {
			lessonId,
			teacherId,
			isAccepted,
		} = await req.json();

		if (
			!confirmedRequiredParams([
				lessonId,
				teacherId,
				isAccepted,
			])
		) {
			return new Response(JSON.stringify(errorResponseData), {
				headers: { ...corsHeaders, 'Content-Type': 'application/json' },
			});
		}

		const { data, error } = await supabase.from('Lessons').update(
			{ isAccepted },
		).match({
			id: lessonId,
			teacherId,
		});

		responseData.isRequestSuccessful = error === null;
		responseData.data = data;
		responseData.error = error;

		return new Response(JSON.stringify(responseData), {
			headers: { ...corsHeaders, 'Content-Type': 'application/json' },
		});
	} catch (err) {
		responseData.isRequestSuccessful = false;
		responseData.data = null;
		responseData.error = err;

		return new Response(JSON.stringify(responseData), {
			headers: { ...corsHeaders, 'Content-Type': 'application/json' },
		});
	}
};
