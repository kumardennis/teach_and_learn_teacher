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

console.log('Hello from get schedule Functions!');

export const handler = async (req: Request) => {
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
				headers: { ...corsHeaders, 'Content-Type': 'application/json' },
			});
		}

		const addressQueryString =
			'Addresses(line1, line2, city, stateCountyProvince, zipCode, countryName, countryCode, geoPoint, name, id, otherDetails)';
		const studentQueryString =
			'Students(id, firstName, lastName, profileImage)';

		const lessonScheduleTimeQueryString =
			'LessonScheduleTimes(scheduleId, time, isBooked, id)';

		const lessonQueryString =
			`Lessons(Lessons_LessonScheduleTimes(${lessonScheduleTimeQueryString}), ${studentQueryString}, ${addressQueryString}, id, fee, studentComment, teacherComment, studentRating, teacherRating, studentSkillLevelRating, hasLessonEnded, hasLessonEndedEarly, hasLessonStarted, isInWaitingList, isAccepted, isChild)`;

		const { data, error } = await supabase.from('LessonSchedules').select(
			`*, Subcategories(id, name, description, picture, categoryId) ,${lessonScheduleTimeQueryString}, ${lessonQueryString}`,
		).eq('id', scheduleId).eq('Lessons.scheduleId', scheduleId).eq(
			'LessonScheduleTimes.scheduleId',
			scheduleId,
		);

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
