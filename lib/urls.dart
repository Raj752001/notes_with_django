

String baseUrl = '192.168.0.103:7000';
Uri baseUri = Uri.http(baseUrl, "");
Uri retrieveUri = Uri.http(baseUrl, 'notes');
Uri createUri = Uri.http(baseUrl, 'notes/create');