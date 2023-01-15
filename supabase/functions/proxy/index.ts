// Follow this setup guide to integrate the Deno language server with your editor:
// https://deno.land/manual/getting_started/setup_your_environment
// This enables autocomplete, go to definition, etc.

import {
	ConnInfo,
	Handler,
	serve,
} from 'https://deno.land/std@0.131.0/http/server.ts';
import { corsHeaders } from '../_shared/cors.ts';

console.log('Setting up localdev');

const handlers = {
	'get-teacher-schedules-grouped-date': await import(
		'../get-teacher-schedules-grouped-date/handler.ts'
	)
		.then((it) => it.handler),
	'get-teacher-schedules-by-date': await import(
		'../get-teacher-schedules-by-date/handler.ts'
	)
		.then((it) => it.handler),
	'create-teacher-schedule': await import(
		'../create-teacher-schedule/handler.ts'
	)
		.then((it) => it.handler),
	'create-student-individual-lesson': await import(
		'../create-student-individual-lesson/handler.ts'
	)
		.then((it) => it.handler),

	'create-student-group-lesson': await import(
		'../create-student-group-lesson/handler.ts'
	)
		.then((it) => it.handler),

	'get-teacher-schedule-details': await import(
		'../get-teacher-schedule-details/handler.ts'
	)
		.then((it) => it.handler),

	'create-user-student': await import(
		'../create-user-student/handler.ts'
	)
		.then((it) => it.handler),

	'update-user-confirm-email': await import(
		'../update-user-confirm-email/handler.ts'
	)
		.then((it) => it.handler),
} as Record<string, Handler>;

function localdevHandler(req: Request, connInfo: ConnInfo) {
	// This is needed if you're planning to invoke your function from a browser.
	if (req.method === 'OPTIONS') {
		return new Response('OK', { headers: corsHeaders });
	}

	const url = new URL(req.url);
	const urlParts = url.pathname.split('/');
	const handlerName = urlParts[urlParts.length - 1];
	const handler = handlers[handlerName];

	console.log(`${handlerName} ${req.url}`);
	try {
		return handler(req, connInfo);
	} catch (err) {
		return new Response(
			JSON.stringify({ error: err }),
			{
				headers: { ...corsHeaders, 'Content-Type': 'application/json' },
				status: 200,
			},
		);
	}
}

serve(localdevHandler);
