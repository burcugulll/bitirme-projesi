const getData = async () => {
	const res = await fetch("https://api.api-ninjas.com/v1/exercises?muscle=biceps", {
		headers: {
			"X-Api-Key": "64LlWR1Gr/Dw2iF46o505Q==KZL1aOjWVRX1pfrl",
		},
	});

	console.log("res:", await res.json());
};


getData()