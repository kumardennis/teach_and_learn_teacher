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

import lodash from 'https://cdn.skypack.dev/lodash';

console.log('Hello from get schedule Functions!');

const _ = lodash;

serve(async (req) => {
	const supabase = createSupabase(req);
	const responseData: ResponseModel = {} as ResponseModel;

	try {
		const {
			teacherId,
			subcategoryId,
			canBeSeenBy,
			levelFrom,
			levelUpto,
		} = await req.json();

		if (
			!confirmedRequiredParams([
				teacherId,
				subcategoryId,
				canBeSeenBy,
				levelFrom,
				levelUpto,
			])
		) {
			return new Response(JSON.stringify(errorResponseData), {
				headers: { 'Content-Type': 'application/json' },
			});
		}

		const { data, error } = await supabase.from('LessonSchedules').select(
			'*',
		).eq('teacherId', teacherId).order('scheduleDate', { ascending: true });

		responseData.isRequestSuccessful = error === null;
		responseData.data = data;
		responseData.error = error;

		return new Response(JSON.stringify(responseData), {
			headers: { 'Content-Type': 'application/json' },
		});
	} catch (err) {
		responseData.isRequestSuccessful = false;
		responseData.data = null;
		responseData.error = err;

		return new Response(JSON.stringify(responseData), {
			headers: { 'Content-Type': 'application/json' },
		});
	}
});
