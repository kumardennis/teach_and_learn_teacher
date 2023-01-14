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

console.log('Hello from get schedule Functions!');

serve(async (req) => {
	const supabase = createSupabase(req);
	const responseData: ResponseModel = {} as ResponseModel;

	try {
		const {
			scheduleId,
		} = await req.json();

		if (
			!confirmedRequiredParams([
				scheduleId,
			])
		) {
			return new Response(JSON.stringify(errorResponseData), {
				headers: { 'Content-Type': 'application/json' },
			});
		}

		const { data, error } = await supabase.from('LessonSchedules').select(
			'*, LessonScheduleTimes(*), Lessons(id, fee, studentComment, teacherComment, studentRating, teacherRating, studentSkillLevelRating, hasLessonEnded, hasLessonEndedEarly, hasLessonStarted, isInWaitingList, isAccepted, isChild, Students(id, firstName, lastName, profileImage))',
		).eq('id', scheduleId).eq('Lessons.scheduleId', scheduleId).eq(
			'LessonScheduleTimes.scheduleId',
			scheduleId,
		);

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
