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
			scheduleTimeIds,
			scheduleId,
			teacherId,
			studentId,
			fee,
			addressId,
			studentDealsWithFieldReservation,
		} = await req.json();

		if (
			!confirmedRequiredParams([
				scheduleTimeIds,
				scheduleId,
				teacherId,
				studentId,
				fee,
				addressId,
			])
		) {
			return new Response(JSON.stringify(errorResponseData), {
				headers: { ...corsHeaders, 'Content-Type': 'application/json' },
			});
		}

		const { createNewLessonData, createNewLessonError } =
			await createNewLesson(
				supabase,
				scheduleId,
				studentId,
				teacherId,
				fee,
				addressId,
				studentDealsWithFieldReservation,
			);

		if (createNewLessonError !== null) {
			responseData.isRequestSuccessful = false;
			responseData.data = null;
			responseData.error = createNewLessonError;

			return new Response(JSON.stringify(responseData), {
				headers: { ...corsHeaders, 'Content-Type': 'application/json' },
			});
		}

		if (createNewLessonData !== null) {
			const { bookTimeSlotData, bookTimeSlotError } = await bookTimeSlot(
				supabase,
				scheduleTimeIds,
				createNewLessonData[0].id,
			);

			responseData.isRequestSuccessful = bookTimeSlotError === null;
			responseData.data = { createNewLessonData, bookTimeSlotData };
			responseData.error = bookTimeSlotError;
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

const bookTimeSlot = async (
	supabaseClient: any,
	scheduleTimeIds: string[],
	lessonId: string,
) => {
	const scheduleTimes: { id: string; isBooked: boolean }[] = [];

	scheduleTimeIds.forEach((id) => scheduleTimes.push({ id, isBooked: true }));

	const { data, error } = await supabaseClient.from('LessonScheduleTimes')
		.update(scheduleTimes).select();

	const scheduleTimeIds_lessonId: {
		lessonId: string;
		scheduleTimeId: string;
	}[] = [];

	scheduleTimeIds.forEach((timeId) => {
		scheduleTimeIds_lessonId.push({ lessonId, scheduleTimeId: timeId });
	});

	const lessonTimes_Lessons = await supabaseClient.from(
		'Lessons_LessonScheduleTimes',
	)
		.insert(scheduleTimeIds_lessonId).select();

	if (lessonTimes_Lessons.error !== null) {
		console.log(
			{
				isRequestSuccessful: false,
				data: null,
				error: lessonTimes_Lessons.error,
			},
		);
	}

	return { bookTimeSlotData: data, bookTimeSlotError: error };
};

const createNewLesson = async (
	supabaseClient: any,
	scheduleId: string,
	studentId: string,
	teacherId: string,
	fee: number,
	addressId: string,
	studentDealsWithFieldReservation: boolean,
) => {
	const { data, error } = await supabaseClient.from('Lessons').insert({
		studentId,
		teacherId,
		scheduleId,
		addressId,
		fee,
		studentDealsWithFieldReservation,
		isAccepted: false,
		isChild: false,
	}).select();

	return { createNewLessonData: data, createNewLessonError: error };
};
