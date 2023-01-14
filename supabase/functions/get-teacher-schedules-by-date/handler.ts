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
import dayjs from 'https://cdn.skypack.dev/dayjs@1.11.6';
import lodash from 'https://cdn.skypack.dev/lodash';
import { corsHeaders } from '../_shared/cors.ts';

console.log('Hello from get schedule Functions!');

const _ = lodash;

export const handler = async (req: Request) => {
	const supabase = createSupabase(req);
	const responseData: ResponseModel = {} as ResponseModel;

	console.log('Hello from get schedule by date Functions!');

	try {
		const { date, teacherId } = await req.json();

		if (!confirmedRequiredParams([date, teacherId])) {
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

		const { data, error } = await supabase
			.from('LessonSchedules')
			.select(
				`*,${lessonScheduleTimeQueryString}, ${lessonQueryString}`,
			)
			.eq('teacherId', teacherId)
			.eq('scheduleDate', date)
			// .eq(
			// 	'Lessons_LessonScheduleTimes.scheduleId',
			// 	'LessonScheduleTimes.id',
			// )
			.eq('LessonScheduleTimes.isBooked', false)
			.order('scheduleDate', { ascending: true });

		const todaysDate = dayjs().format('YYYY-MM-DD');

		// if (data !== null) {
		// 	for (const schedule of data) {
		// 		if (schedule.LessonScheduleTimes !== null) {
		// 			let groupedTimes = {};

		// 			groupedTimes = _.groupBy(
		// 				schedule.LessonScheduleTimes,
		// 				'Lessons.id',
		// 			);

		// 			console.log(groupedTimes);
		// 		}
		// 	}
		// }

		/* Group schedules by date */

		if (data !== null) {
			responseData.isRequestSuccessful = error === null;
			responseData.data = data;
			responseData.error = error;
		} else {
			responseData.isRequestSuccessful = error === null;
			responseData.data = data;
			responseData.error = error;
		}

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
